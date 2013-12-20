#import mathphysicslibs.constants as mpconsts
#import lattice
import tracking
import numpy
import math
import copy

class Twiss:
    def __init__(self):
        self.closed_orbit = numpy.zeros((6,1))
        self.alphax = None
        self.betax  = None
        self.mux    = 0
        self.etaxl  = 0
        self.etax   = 0
        self.alphay = None
        self.betay  = None
        self.muy    = 0
        self.etayl  = 0
        self.etay   = 0
        
def findorbit4(ring, de = 0, refpts = None, guess = None, turn_by_turn = False, engine = 'trackcpp',
               init_nr_turns = 20, max_pos_tol = 1e-14, max_iterations = 20):
    """ returns the closed orbit solution of the ring """
    
    ''' builds a valid list of element indices '''
    if refpts is None:
        refpts = [0]
    try:
        refpts[0]
    except:
        refpts = [refpts]
        
    ''' builds initial guess coordinate vector '''    
    Ri = numpy.array([[0.0],[0.0],[0.0],[0.0],[de],[0.0]])
    if guess is not None:
        guess = numpy.array(guess)
        Ri[:4,0] = guess[:4,0]    
    
    ''' main loop '''
    Ri_next = numpy.zeros((6,1))
    while True:
        
        ''' tracking '''
        Rf = tracking.ringpass(ring = ring, particles = Ri, nr_turns = init_nr_turns, engine = engine)
        Ri_next[:,0] = numpy.mean(Rf,axis=1) # averaging over points on invariant manifold
        
        ''' checks whether tracking is unstable '''
        if numpy.isnan(sum(Ri_next)):
            raise Exception('findorbit4: overflow in particle coordinates')
        
        ''' number of iterations exceeded? '''
        max_iterations -= 1
        if max_iterations < 0:
            raise Exception('findorbit4: max number of iterations reached')
        
        ''' tolerance achieved? '''
        delta = abs(Ri_next[[1,2,3,4],0] - Ri[[1,2,3,4],0])
        if all(delta < max_pos_tol):
            break;
        
        ''' next iteration '''
        Ri = numpy.array(Ri_next)
        init_nr_turns += 1
    
    ''' builds closed orbit at all specified locations '''
    Rf = numpy.zeros((6,len(ring)+1))
    Rf[:,0] = Ri[:,0]
    if (len(refpts)>1) or (refpts[0] != 0):             
        Rf[:,1:] = tracking.linepass(line = ring, particles = Ri, refpts = refpts, engine = engine)
        
    ''' returns 4d (default) or 6d closed orbit data '''
    if turn_by_turn:
        Rf = numpy.zeros((6,1+init_nr_turns))
        Ri = tracking.ringpass(ring = ring, particles = Ri, nr_turns = init_nr_turns, engine = engine)
        return Ri
    else:
        return Rf[:4,refpts]
    
    
# def findorbit6(ring, refpts = None, guess = None, init_nr_turns = 20, tol = 1e-8, max_iterations = 15, step_de = 1e-4):
    
#     ''' builds a valid list of element indices '''
#     if refpts is None:
#         refpts = [0]
#     try:
#         refpts[0]
#     except:
#         refpts = [refpts]
#      
#     if guess is None:
#         guess = numpy.array([[0.0],[0.0],[0.0],[0.0],[0.0],[0.0]])
#     
#     de0 = guess[4,0]        
#     iteration = 0
#     while (step_de > tol):
#         
#         de1 = de0 - step_de/2
#         pos = findorbit4(ring, de = de1, refpts = [0], guess = guess, init_nr_turns = init_nr_turns, tol = 1e-14, max_iterations = max_iterations, turn_by_turn = True)
#         guess[:,0] = pos[:,0] 
#         dl1 = pos[5,-1] - pos[5,0]
#         
#         
#         de2 = de0 + step_de/2
#         pos = findorbit4(ring, de = de2, refpts = [0], guess = guess, init_nr_turns = init_nr_turns, tol = 1e-14, max_iterations = max_iterations, turn_by_turn = True)
#         guess[:4,0] = pos[:4,0]
#         dl2 = pos[5,-1] - pos[5,0]
#         
#         de0 = de1 - (de2 - de1) * (dl1/(dl2-dl1)) # linear interpolation
#         
#         if ((dl1<=0)!=(dl2<=0)):  # if interval contains solution does bisection
#             step_de /= 2.0
#     
#         iteration += 1
#         #print((iteration, de0, step_de))
#             
#     de = 0.5 * (de1 + de2)
#     Ri = findorbit4(ring, de = de, refpts = [0], guess = guess, init_nr_turns = init_nr_turns, tol = tol, max_iterations = max_iterations, turn_by_turn = True)
#     Ri = Ri[:,0]
#     Ri = tracking.track1turn(lattice = ring, pos = Ri, trajectory = True, engine = 'trackcpp')
#     Ri = Ri[:, refpts]
#     return Ri
    
def calcm66 (line, m66_list = None, closed_orbit = None):
    """ returns the total transfer matrix (or one-turn matrix) """
    if m66_list is None:
        m66_list, closed_orbit = tracking.findm66(line = line, closed_orbit = closed_orbit)
    m = numpy.eye(6,6)
    for i in range(m66_list.shape[0]):
        m = numpy.dot(m66_list[i,:,:], m)
    return (m, m66_list, closed_orbit)

def fractunes(ring, m66 = None, m66_list = None, closed_orbit = None):
    """ returns uncoupled fractional tunes """
    if m66 is None:
        m66,m66_list,closed_orbit = calcm66(ring, m66_list = m66_list, closed_orbit = closed_orbit)
    nux = math.acos((m66[0,0]+m66[1,1])/2)/(2*math.pi)
    nuy = math.acos((m66[2,2]+m66[3,3])/2)/(2*math.pi)
    nus = math.acos((m66[4,4]+m66[5,5])/2)/(2*math.pi)
    return ((nux,nuy,nus), m66, m66_list, closed_orbit)

def fractunes_coupled(ring, m66 = None, m66_list = None, closed_orbit = None):
    """ returns coupled fractional tunes """
    raise Exception('fractunes_coupled: not yet implemented')


def twiss (line, refpts = None, m66 = None, m66_list = None, closed_orbit = None, twiss_in = None):
    """ returns uncoupled Twiss parameters """
    
    ''' process arguments '''
    if refpts is None:
        refpts = range(len(line))
    try:
        refpts[0]
    except:
        refpts = [refpts]
    if m66 is None:
        m66,m66_list,closed_orbit = calcm66(line, m66_list = m66_list, closed_orbit = closed_orbit)
    if twiss_in is None:
        twiss_in = Twiss()
        twiss_in.closed_orbit = closed_orbit
        (twiss_in.mux, twiss_in.muy) = (0,0)
    
    
    
    ''' calcs twiss at first element '''
    (mx, my) = (m66[0:2,0:2], m66[2:4,2:4]) # decoupled transfer matrices
    sin_nux = math.copysign(1,mx[0,1]) * math.sqrt(-mx[0,1] * mx[1,0] - ((mx[0,0] - mx[1,1])**2)/4);
    sin_nuy = math.copysign(1,my[0,1]) * math.sqrt(-my[0,1] * my[1,0] - ((my[0,0] - my[1,1])**2)/4);
    t = Twiss()
    t.alphax  = (mx[0,0] - mx[1,1]) / 2 / sin_nux
    t.betax   = mx[0,1] / sin_nux
    t.alphay  = (my[0,0] - my[1,1]) / 2 / sin_nuy
    t.betay   = my[0,1] / sin_nuy
    ''' dispersion function based on eta = (1 - M)^(-1) D'''
    Dx = numpy.array([[m66[0,4]],[m66[1,4]]])
    Dy = numpy.array([[m66[2,4]],[m66[3,4]]]) 
    t.etax = numpy.linalg.solve(numpy.eye(2,2) - mx, Dx)
    t.etay = numpy.linalg.solve(numpy.eye(2,2) - my, Dy)
    
    if 0 in refpts:
        tw = [t]
    else:
        tw = []
        
    ''' propagates twiss through line '''
    for i in range(1,1+len(line)):
        m = m66_list[i-1,:,:]
        (mx, my) = (m[0:2,0:2], m[2:4,2:4]) # decoupled transfer matrices
        Dx = numpy.array([[m[0,4]],[m[1,4]]])
        Dy = numpy.array([[m[2,4]],[m[3,4]]])
        n = Twiss()
        n.betax  =  ((mx[0,0] * t.betax - mx[0,1] * t.alphax)**2 + mx[0,1]**2) / t.betax
        n.alphax = -((mx[0,0] * t.betax - mx[0,1] * t.alphax) * (mx[1,0] * t.betax - mx[1,1] * t.alphax) + mx[0,1] * mx[1,1]) / t.betax
        n.betay  =  ((my[0,0] * t.betay - my[0,1] * t.alphay)**2 + my[0,1]**2) / t.betay
        n.alphay = -((my[0,0] * t.betay - my[0,1] * t.alphay) * (my[1,0] * t.betay - my[1,1] * t.alphay) + my[0,1] * my[1,1]) / t.betay
        ''' calcs phase advance based on R(mu) = U(2) M(2|1) U^-1(1) '''
        n.mux    = t.mux + math.asin(mx[0,1]/math.sqrt(n.betax * t.betax)) 
        n.muy    = t.muy + math.asin(my[0,1]/math.sqrt(n.betay * t.betay))
        ''' dispersion function '''
        n.etax = Dx + numpy.dot(mx, t.etax)
        n.etay = Dy + numpy.dot(my, t.etay)
    
        if i in refpts:
            tw.append(n)
        t = copy.deepcopy(n)
    
    ''' converts eta format '''
    for t in tw:
        (t.etaxl, t.etayl) = (t.etax[1,0], t.etay[1,0])
        (t.etax,  t.etay ) = (t.etax[0,0], t.etay[0,0])
        
    return (tw, m66, m66_list, closed_orbit)
    
    
def twiss_coupled (line, refpts = None, m66 = None, m66_list = None, closed_orbit = None, twiss_in = None):
    """ returns coupled Twiss parameters """
    raise Exception('twiss_coupled: not yet implemented')
    