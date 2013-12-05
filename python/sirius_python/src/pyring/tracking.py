import pos
import passmethods
import trackcpp
import numpy

def track1turn(lattice, pos, trajectory = False, engine = 'trackcpp'):
    if engine == 'pyring':
        return _Tracking.track1turn_pyring(lattice, pos, trajectory)
    elif engine == 'trackcpp':
        return _Tracking.track1turn_trackcpp(lattice, pos, trajectory)
    else:
        raise Exception('tracking engine not defined|implemented!')
    
def tracknturns(lattice, pos, nr_turns = 1, turn_by_turn = False, trajectory = False, engine = 'trackcpp'):
    if engine == 'pyring':
        return _Tracking.tracknturns_pyring(lattice, pos, nr_turns, turn_by_turn, trajectory, engine = engine)
    elif engine == 'trackcpp':
        return _Tracking.tracknturns_trackcpp(lattice, pos, nr_turns, turn_by_turn, trajectory)
    else:
        raise Exception('tracking server not defined|implemented!')
    

def num2py(pos):
    return numpy.reshape(pos, pos.size, order='F').tolist()
def py2num(pos):
    return numpy.reshape(numpy.array(pos), (6,-1), order='F')


def get_turn (pos, nr_particles = 1, nr_elements = 1, nr_turns = 1, turn = None):
    if pos.shape[1] != (nr_particles*nr_elements*nr_turns):
        raise Exception('inconsistent parameters in get_turn invocation')
    if turn is None:
        turn = nr_turns-1
    return pos[:,(turn*nr_elements*nr_particles):((turn+1)*nr_elements*nr_particles)]
def get_element (pos, nr_particles = 1, nr_elements = 1, nr_turns = 1, element = None):
    if pos.shape[1] != (nr_particles*nr_elements*nr_turns):
        raise Exception('inconsistent parameters in get_element invocation')
    if element is None:
        element = nr_elements-1
    p = []
    for i in range(nr_turns):
        p = p + pos[:,(i*nr_elements*nr_particles + element*nr_particles):((i+1)*nr_elements*nr_particles + element*nr_particles)]
    return p
def get_particle (pos, nr_particles = 1, nr_elements = 1, nr_turns = 1, particle = 0, ):
    if pos.shape[1] != (nr_particles*nr_elements*nr_turns):
        raise Exception('inconsistent parameters in get_particle invocation')
    p = []
    for i in range(nr_turns):
        for j in range(nr_elements):
            p = p + pos[:,(i*nr_elements*nr_particles+j*nr_particles+particle):(i*nr_elements*nr_particles+j*nr_particles+(particle+1))]
    return p
def get_rx(pos):
    return pos[0,:]
def get_px(pos):
    return pos[1,:]
def get_ry(pos):
    return pos[2,:]
def get_py(pos):
    return pos[3,:]
def get_de(pos):
    return pos[4,:]
def get_dl(pos):
    return pos[5,:]



    




class _Tracking:

    @staticmethod
    def tracknturns_pyring(lattice, particles, nr_turns, turn_by_turn, trajectory):
        
        np = particles
        if turn_by_turn:
            new_particles = []
            for _ in range(nr_turns):
                np = _Tracking.track1turn_pyring(lattice, np, trajectory)
                new_particles += np
        else:
            new_particles = []
            for _ in range(nr_turns):
                np = _Tracking.track1turn_pyring(lattice, np, trajectory)
            new_particles = np
        return new_particles
                
            
        
        
    @staticmethod
    def track1turn_pyring(lattice, particles, trajectory):
        
        # converts linear array of particle coordinates into pynum array 
        nr_elements  = len(lattice)
        nr_particles = len(particles)/6 
        (rx, px) = (particles[0::6], particles[1::6])
        (ry, py) = (particles[2::6], particles[3::6])
        (de, dl) = (particles[4::6], particles[5::6])
        (rx,px) = (numpy.array(rx), numpy.array(px))
        (ry,py) = (numpy.array(ry), numpy.array(py))
        (de,dl) = (numpy.array(de), numpy.array(dl))
        np = pos.Pos(rx,px,ry,py,de,dl)
        
        if trajectory:
            # to return trajectory along lattice?
            new_particles = (6 * nr_elements * nr_particles) * [0]
            for i in range(len(lattice)):
                (_, pm_map) = passmethods.pm_dict[lattice[i].pass_method]
                pm_map(np, lattice[i])
                new_particles[(6*nr_particles*(i)+0):(6*nr_particles*(i+1)+0):6] = np.rx
                new_particles[(6*nr_particles*(i)+1):(6*nr_particles*(i+1)+1):6] = np.px
                new_particles[(6*nr_particles*(i)+2):(6*nr_particles*(i+1)+2):6] = np.ry
                new_particles[(6*nr_particles*(i)+3):(6*nr_particles*(i+1)+3):6] = np.py
                new_particles[(6*nr_particles*(i)+4):(6*nr_particles*(i+1)+4):6] = np.de
                new_particles[(6*nr_particles*(i)+5):(6*nr_particles*(i+1)+5):6] = np.dl
        else:
            # returns only final position at end of lattice
            new_particles = (6 * nr_particles) * [0]
            for element in lattice:
                (_, pm_map) = passmethods.pm_dict[element.pass_method]
                pm_map(np, element)
            (new_particles[0::6], new_particles[1::6]) = (np.rx, np.px) 
            (new_particles[2::6], new_particles[3::6]) = (np.ry, np.py)
            (new_particles[4::6], new_particles[5::6]) = (np.de, np.dl)
        return new_particles

    @staticmethod
    def track1turn_trackcpp(lattice, pos, trajectory):
        return py2num(trackcpp.track1turn(lattice, num2py(pos), trajectory))
    
    @staticmethod
    def tracknturns_trackcpp(lattice, pos, nr_turns, turn_by_turn, trajectory):
        return py2num(trackcpp.tracknturns(lattice, num2py(pos), nr_turns, turn_by_turn, trajectory))


    
