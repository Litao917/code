import analysis.rotcoil as rotcoil

#default_energy        = 3.0        # [GeV]
default_r0             = 17.5/1000  # [m]
default_harmonics      = [1,2,3,4,5,6,7]
default_quad_harmonics = [1,2,3,4,5,6,7,8,9,10,14]
default_plot_label     = 'multipoles'


''' SIMULATION '''
''' ---------- '''
def quadrupole_multipole_simulation():
    
    harmonics       = [3,    4,    5,    6,    7,    8,    9,    10,     14  ]
    relative_LN_avg = [0,    0,    0,   -1.0310e-3, 0,    0,    0,    1.18022e-3, 3e-5] # integracao em toda regiao da simulacao
    #relative_LN_std = [7e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4,   0   ]
    relative_LN_std = [0,    0,    0,    0,    0,    0,    0,    0,      0   ]
    relative_LS_avg = [0,    0,    0,    0,    0,    0,    0,    0,      0   ]
    #relative_LS_std = [1e-4, 5e-4, 1e-4, 1e-4, 1e-4, 1e-4, 1e-4, 1e-4,   0   ]
    relative_LS_std = [0,    0,    0,    0,    0,    0,    0,    0,      0   ]
    m = rotcoil.multipoles(                        
                 harmonics = harmonics, r0 = default_r0,  
                 relative_LN_avg = relative_LN_avg,
                 relative_LS_avg = relative_LS_avg,
                 relative_LN_std = relative_LN_std,
                 relative_LS_std = relative_LS_std,
                 )
    return m
        

''' SPECS '''
''' ----- '''

def quadrupole_multipole_specs():
    
    harmonics       = [3,    4,    5,    6,    7,    8,    9,    10,     14  ]
    relative_LN_avg = [0,    0,    0,   -1e-3, 0,    0,    0,    1.1e-3, 8e-5]
    relative_LN_std = [7e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4, 4e-4,   0   ]
    relative_LS_avg = [0,    0,    0,    0,    0,    0,    0,    0,      0   ]
    relative_LS_std = [1e-4, 5e-4, 1e-4, 1e-4, 1e-4, 1e-4, 1e-4, 1e-4,   0   ]
    m = rotcoil.multipoles(                        
                 harmonics = harmonics, r0 = default_r0,  
                 relative_LN_avg = relative_LN_avg,
                 relative_LS_avg = relative_LS_avg,
                 relative_LN_std = relative_LN_std,
                 relative_LS_std = relative_LS_std,
                 )
    return m
        
        
''' ANALYSIS '''
''' -------- '''

def quadrupoles_excitation(folder,
                          harmonics = default_quad_harmonics,
                          r0 = default_r0,                                  
                          plot_label = 'BOOSTER QUADRUPOLES',
                          ymin_multipoles = 1e-6,
                          ymin_skew_angle = 1e-2,
                          legend = None,
                          plot_normal_multipoles_flag = True, 
                          plot_skew_multipoles_flag = True,
                          plot_skew_angle_flag = True):
    """ loads measurement quadrupole data and does excitation analysis """
    
    ''' loads rotating coil data from folder '''
    measurements    = rotcoil.read_measurements_from_folder(folder = folder)
    ''' does multipolar analysis on raw data '''
    multipoles      = rotcoil.calc_multipoles_from_measurements(measurements, harmonics, r0 = r0, main_harmonic = 2)
    ''' inserts specs and simulation data in data set '''
    multipoles      = [quadrupole_multipole_specs(), quadrupole_multipole_simulation()] + multipoles
    
    ''' summary '''
    rotcoil.excitation_print_summary(data = multipoles[2:])
    
    ''' excitation curve '''
    rotcoil.current_plot_multipoles(data = multipoles[2:],  
                                    harmonic_order = 2,
                                    plot_label = plot_label, 
                                    legend = None,
                                    plot_type = 'absolute_normal_multipoles',
                                    current_range = None
                                    )  
      

    ''' plots normal multipoles for comparison '''
    if plot_normal_multipoles_flag:
        rotcoil.bar_plot_multipoles_repetibility(multipoles, harmonics = [h for h in harmonics if h != 2], r0 = r0,                                  
                                                 plot_label = plot_label, ymin = ymin_multipoles, legend = legend,
                                                 plot_normal_multipoles_flag = plot_normal_multipoles_flag, 
                                                 plot_skew_multipoles_flag = False,
                                                 plot_skew_angle_flag = False,
                                                 base_bar = 2)
        
    ''' plots skew multipoles for comparison '''
    if plot_skew_multipoles_flag:
        rotcoil.bar_plot_multipoles_repetibility(multipoles, harmonics = harmonics, r0 = r0,                                  
                                                 plot_label = plot_label, ymin = ymin_multipoles, legend = legend,
                                                 plot_normal_multipoles_flag = False, 
                                                 plot_skew_multipoles_flag = plot_skew_multipoles_flag,
                                                 plot_skew_angle_flag = False,
                                                 base_bar = 2)
    
    ''' plots skew angle for all multipoles '''
    if plot_skew_angle_flag:
        rotcoil.bar_plot_multipoles_repetibility(multipoles[1:], harmonics = harmonics, r0 = r0,                                  
                                                 plot_label = plot_label, ymin = ymin_skew_angle, legend = legend,
                                                 plot_normal_multipoles_flag = False, 
                                                 plot_skew_multipoles_flag = False,
                                                 plot_skew_angle_flag = True,
                                                 base_bar = 0)
        
def quadrupoles_repetibility(folder,
                             harmonics = default_quad_harmonics,
                             r0 = default_r0,                                  
                             plot_label = 'QUADRUPOLES',
                             ymin_multipoles = 1e-6,
                             ymin_skew_angle = 1e-2,
                             legend = None,
                             plot_normal_multipoles_flag = True, 
                             plot_skew_multipoles_flag = True,
                             plot_skew_angle_flag = True):
    """ loads measurement quadrupole data and does repetibility analysis """
    
    ''' loads rotating coil data from folder '''
    measurements    = rotcoil.read_measurements_from_folder(folder = folder)
    ''' creates 'multipole' objects '''
    multipole       = rotcoil.multipoles(measurements[0], harmonics = harmonics, r0 = r0)
    ''' defines normal quadrupole as main multipole for normalization '''
    main_multipole  = multipole.select_main_multipole(2)
    ''' does multipolar analysis on raw data '''
    multipoles      = rotcoil.calc_multipoles_from_measurements(measurements, harmonics, r0, main_multipole = main_multipole)
    ''' loads quadrupolar simulation from database '''
    quad_sim = quadrupole_multipole_simulation()
    ''' inserts simulation in data set '''
    multipoles      = [quad_sim] + multipoles
    ''' loads quadrupolar specifications from database '''
    quad_specs      = quadrupole_multipole_specs()
    ''' inserts specs in data set '''
    multipoles      = [quad_specs] + multipoles


    ''' summary '''
    rotcoil.bar_print_summary(data = multipoles[2:])
    

    ''' plots normal and skew multipoles for comparison '''
    if plot_normal_multipoles_flag or plot_skew_multipoles_flag:
        rotcoil.bar_plot_multipoles_repetibility(multipoles, harmonics = harmonics, r0 = r0,                                  
                                                 plot_label = plot_label, ymin = ymin_multipoles, legend = legend,
                                                 plot_normal_multipoles_flag = plot_normal_multipoles_flag, 
                                                 plot_skew_multipoles_flag = plot_skew_multipoles_flag,
                                                 plot_skew_angle_flag = False,
                                                 base_bar = 2)
    
    ''' plots skew angle for all multipoles '''
    if plot_skew_angle_flag:
        rotcoil.bar_plot_multipoles_repetibility(multipoles[1:], harmonics = harmonics, r0 = r0,                                  
                                                 plot_label = plot_label, ymin = ymin_skew_angle, legend = legend,
                                                 plot_normal_multipoles_flag = False, 
                                                 plot_skew_multipoles_flag = False,
                                                 plot_skew_angle_flag = True,
                                                 base_bar = False)
        
    