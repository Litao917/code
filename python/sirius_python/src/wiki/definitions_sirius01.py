# -*- coding: utf-8 -*-

'''
Sirius01
====================
Date: 2014-08-12

Storage ring:    V00B00   - This lattice/optics mode corresponds to the previous V500_AC10.5
Booster:         V810OPT2 -  
'''

import optics
import math

class ParameterDefinitions(object):

    '''Storage ring parameters'''

    si_beam_energy            = 3.0       # [GeV]
    si_beam_gamma_factor      = optics.gamma(si_beam_energy)
    si_beam_beta_factor       = optics.beta(si_beam_gamma_factor)
    si_beam_velocity          = optics.velocity(si_beam_beta_factor)
    si_beam_magnetic_rigidity = optics.brho(si_beam_energy, si_beam_beta_factor)
    
    si_beam_current                      = 350.0 #[mA]
    si_lattice_version                   = 'V00' 
    si_lattice_type                      = '5BA'
    si_lattice_circumference             = 518.396 #[m]
    si_lattice_symmetry                  = 10
    si_number_of_long_straight_sections  = si_lattice_symmetry
    si_number_of_short_straight_sections = si_lattice_symmetry
    si_length_of_long_straight_sections  = 7.0 #[m]
    si_length_of_short_straight_sections = 6.0 #[m]
    si_harmonic_number                   = 864
    si_rf_cavity_peak_voltage            = 2.7 #[MV]
    
    si_revolution_period = optics.revolution_period(
        si_lattice_circumference, si_beam_velocity)

    si_revolution_frequency = optics.revolution_frequency(
        si_revolution_period)

    si_rf_frequency = optics.rf_frequency(
        si_revolution_frequency, si_harmonic_number)
    
    si_number_of_electrons = optics.number_of_electrons(
        si_beam_current, si_revolution_period)
          
    si_number_of_B1_dipoles = 4 * si_lattice_symmetry
    si_number_of_B2_dipoles = 4 * si_lattice_symmetry
    si_number_of_B3_dipoles = 4 * si_lattice_symmetry
    si_number_of_BC_dipoles = 2 * si_lattice_symmetry
    
    si_hardedge_length_of_B1_dipoles =  0.828080 #[m] 
    si_hardedge_length_of_B2_dipoles =  1.228262 #[m]
    si_hardedge_length_of_B3_dipoles =  0.428011 #[m]
    si_hardedge_length_of_BC_dipoles =  0.125394 #[m]
    
    si_B1_dipole_deflection_angle = 2.76654
    si_B2_dipole_deflection_angle = 4.10351
    si_B3_dipole_deflection_angle = 1.42995
    si_BC_dipole_deflection_angle = 1.40000

    si_B1_dipole_bending_radius = si_hardedge_length_of_B1_dipoles / math.radians(si_B1_dipole_deflection_angle)
    si_B2_dipole_bending_radius = si_hardedge_length_of_B2_dipoles / math.radians(si_B2_dipole_deflection_angle)
    si_B3_dipole_bending_radius = si_hardedge_length_of_B3_dipoles / math.radians(si_B3_dipole_deflection_angle)
    si_BC_dipole_bending_radius = si_hardedge_length_of_BC_dipoles / math.radians(si_BC_dipole_deflection_angle)

    si_B1_dipole_magnetic_field = si_beam_magnetic_rigidity / si_B1_dipole_bending_radius
    si_B2_dipole_magnetic_field = si_beam_magnetic_rigidity / si_B2_dipole_bending_radius
    si_B3_dipole_magnetic_field = si_beam_magnetic_rigidity / si_B3_dipole_bending_radius
    si_BC_dipole_magnetic_field = si_beam_magnetic_rigidity / si_BC_dipole_bending_radius

    si_B1_dipole_critical_energy = optics.critical_energy(
        si_beam_gamma_factor,
        si_B1_dipole_bending_radius)
    si_B2_dipole_critical_energy = optics.critical_energy(
        si_beam_gamma_factor,
        si_B2_dipole_bending_radius)
    si_B3_dipole_critical_energy = optics.critical_energy(
        si_beam_gamma_factor,
        si_B3_dipole_bending_radius)
    si_BC_dipole_critical_energy = optics.critical_energy(
        si_beam_gamma_factor,
        si_BC_dipole_bending_radius)

    si_optics_mode = 'B00'
    si_horizontal_betatron_tune = 46.179867828110417
    si_vertical_betatron_tune = 14.149994739104255
    
    si_horizontal_beam_size_at_center_long_straight_sections  = 68.751773951345939  # [um] calculated using analytical expression
    si_horizontal_beam_size_at_center_short_straight_sections = 33.718654943446005  # [um]
    si_horizontal_beam_size_at_center_bc_dipoles              = 11.056250696773693  # [um]
    si_vertical_beam_size_at_center_long_straight_sections    = 3.041750355172871  # [um]
    si_vertical_beam_size_at_center_short_straight_sections   = 1.444008428763601  # [um]
    si_vertical_beam_size_at_center_bc_dipoles                = 4.016421176598540  # [um]
    
    si_horizontal_beam_divergence_at_center_long_straight_sections  = 4.105284385615102  # [urad] calculated using analytical expression
    si_horizontal_beam_divergence_at_center_short_straight_sections = 8.370606258537984  # [urad]
    si_horizontal_beam_divergence_at_center_bc_dipoles              = 26.577287542948945 # [urad]
    si_vertical_beam_divergence_at_center_long_straight_sections    = 0.927905156926034  # [urad]
    si_vertical_beam_divergence_at_center_short_straight_sections   = 1.954597898752207  # [urad]
    si_vertical_beam_divergence_at_center_bc_dipoles                = 0.702729050910861  # [urad]
    
    si_horizontal_natural_chromaticity = -113.1198708037573
    si_vertical_natural_chromaticity = -80.5026603600822
    si_horizontal_chromaticity = 0
    si_vertical_chromaticity = 0
    
    si_horizontal_betatron_frequency = optics.frequency_from_tune(
        si_revolution_frequency, si_horizontal_betatron_tune)

    si_vertical_betatron_frequency = optics.frequency_from_tune(
        si_revolution_frequency, si_vertical_betatron_tune)

    ''' DIPOLES ONLY '''
    si_radiation_integral_I1_from_dipoles =  0.090315779996644     #[m]
    si_radiation_integral_I2_from_dipoles =  0.433104068989975     #[1/m]
    si_radiation_integral_I3_from_dipoles =  0.038257877157466     #[1/m^2]
    si_radiation_integral_I4_from_dipoles = -0.137100015107741     #[1/m]
    si_radiation_integral_I5_from_dipoles =  1.218542781664562e-05 #[1/m]
    si_radiation_integral_I6_from_dipoles =  0.019201555654789     #[1/m]
    ''' IDs '''
    si_radiation_integral_I1_from_IDs =  0.0 #[m]
    si_radiation_integral_I2_from_IDs =  0.0 #[1/m]
    si_radiation_integral_I3_from_IDs =  0.0 #[1/m^2]
    si_radiation_integral_I4_from_IDs =  0.0 #[1/m]
    si_radiation_integral_I5_from_IDs =  0.0 #[1/m]
    si_radiation_integral_I6_from_IDs =  0.0 #[1/m] 
    ''' DIPOLES and IDs '''
    si_radiation_integral_I1 = (si_radiation_integral_I1_from_dipoles + 
        si_radiation_integral_I1_from_IDs) #[m]
    si_radiation_integral_I2 = (si_radiation_integral_I2_from_dipoles +
        si_radiation_integral_I2_from_IDs) #[m]
    si_radiation_integral_I3 = (si_radiation_integral_I3_from_dipoles +
        si_radiation_integral_I3_from_IDs) #[m]
    si_radiation_integral_I4 = (si_radiation_integral_I4_from_dipoles +
        si_radiation_integral_I4_from_IDs) #[m]
    si_radiation_integral_I5 = (si_radiation_integral_I5_from_dipoles +
        si_radiation_integral_I5_from_IDs) #[m]
    si_radiation_integral_I6 = (si_radiation_integral_I6_from_dipoles +
        si_radiation_integral_I6_from_IDs) #[m]
     
    si_energy_loss_per_turn_from_dipoles = optics.U0(
        si_beam_energy, si_radiation_integral_I2_from_dipoles)
    si_energy_loss_per_turn_from_IDs = optics.U0(
        si_beam_energy, si_radiation_integral_I2_from_IDs)
    si_energy_loss_per_turn = optics.U0(
        si_beam_energy, si_radiation_integral_I2)

    si_radiation_power_from_dipoles = optics.radiation_power(
        si_energy_loss_per_turn_from_dipoles, si_beam_current)
    si_radiation_power = optics.radiation_power(
        si_energy_loss_per_turn, si_beam_current)
    
    si_overvoltage_from_dipoles = optics.overvoltage(
        si_rf_cavity_peak_voltage, si_energy_loss_per_turn_from_dipoles)
    si_overvoltage = optics.overvoltage(
        si_rf_cavity_peak_voltage, si_energy_loss_per_turn)

    si_synchronous_phase_from_dipoles = optics.sync_phase(
        si_overvoltage_from_dipoles)
    si_synchronous_phase = optics.sync_phase(
        si_overvoltage)

    si_linear_momentum_compaction_from_dipoles = optics.alpha1(
        si_radiation_integral_I1_from_dipoles,
        si_lattice_circumference)
    si_linear_momentum_compaction = optics.alpha1(
        si_radiation_integral_I1,
        si_lattice_circumference)

    si_linear_slip_phase_from_dipoles = optics.slip_factor(
        si_linear_momentum_compaction_from_dipoles, si_beam_gamma_factor)
    si_linear_slip_phase = optics.slip_factor(
        si_linear_momentum_compaction, si_beam_gamma_factor)
        
    si_rf_energy_acceptance_from_dipoles = optics.rf_energy_acceptance(
        si_overvoltage_from_dipoles, si_beam_energy,
        si_energy_loss_per_turn_from_dipoles, si_harmonic_number,
        si_linear_momentum_compaction_from_dipoles)
    si_rf_energy_acceptance = optics.rf_energy_acceptance(
        si_overvoltage, si_beam_energy,
        si_energy_loss_per_turn, si_harmonic_number,
        si_linear_momentum_compaction) 

    si_horizontal_damping_partition_number_from_dipoles = optics.Jx(
        si_radiation_integral_I2_from_dipoles,
        si_radiation_integral_I4_from_dipoles)
    si_horizontal_damping_partition_number = optics.Jx(
        si_radiation_integral_I2, 
        si_radiation_integral_I4)

    si_vertical_damping_partition_number_from_dipoles = 1.0
    si_vertical_damping_partition_number = 1.0
    
    si_longitudinal_damping_partition_number_from_dipoles = optics.Js(
        si_horizontal_damping_partition_number_from_dipoles,
        si_vertical_damping_partition_number_from_dipoles)
    si_longitudinal_damping_partition_number = optics.Js(
        si_horizontal_damping_partition_number,
        si_vertical_damping_partition_number)

    si_natural_emittance_from_dipoles = optics.natural_emittance(
        si_beam_gamma_factor,
        si_horizontal_damping_partition_number_from_dipoles,
        si_radiation_integral_I2_from_dipoles,
        si_radiation_integral_I5_from_dipoles)
    si_natural_emittance = optics.natural_emittance(
        si_beam_gamma_factor, 
        si_horizontal_damping_partition_number,
        si_radiation_integral_I2, 
        si_radiation_integral_I5)

    si_natural_energy_spread_from_dipoles = optics.energy_spread(
        si_beam_gamma_factor,
        si_radiation_integral_I2_from_dipoles,
        si_radiation_integral_I3_from_dipoles,
        si_radiation_integral_I4_from_dipoles)
    si_natural_energy_spread = optics.energy_spread(
        si_beam_gamma_factor, 
        si_radiation_integral_I2,
        si_radiation_integral_I3, 
        si_radiation_integral_I4)
    
    si_synchrotron_tune_from_dipoles = 0.004421565111775
    si_synchrotron_tune              = 0.004421565111775
    
    si_synchrotron_frequency_from_dipoles = optics.frequency_from_tune(
        si_revolution_frequency, si_synchrotron_tune_from_dipoles)
    si_synchrotron_frequency = optics.frequency_from_tune(
        si_revolution_frequency, si_synchrotron_tune)
    
    si_natural_bunch_length_from_dipoles = optics.bunch_length(
        si_linear_slip_phase_from_dipoles, 
        si_natural_energy_spread_from_dipoles, 
        si_synchrotron_frequency)
    si_natural_bunch_length = optics.bunch_length(
        si_linear_slip_phase, 
        si_natural_energy_spread, 
        si_synchrotron_frequency)

    si_natural_bunch_duration_from_dipoles = optics.bunch_duration(
        si_natural_bunch_length_from_dipoles, 
        si_beam_beta_factor)    
    si_natural_bunch_duration = optics.bunch_duration(
        si_natural_bunch_length, 
        si_beam_beta_factor)
    
    si_horizontal_radiation_damping_time_from_dipoles = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2_from_dipoles,
        si_horizontal_damping_partition_number_from_dipoles,
        si_lattice_circumference)                                                                        
    si_horizontal_radiation_damping_time = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2,
        si_horizontal_damping_partition_number,
        si_lattice_circumference) 
    
    si_vertical_radiation_damping_time_from_dipoles = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2_from_dipoles,
        si_vertical_damping_partition_number_from_dipoles,
        si_lattice_circumference)                                                                        
    si_vertical_radiation_damping_time = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2,
        si_vertical_damping_partition_number,
        si_lattice_circumference)
    
    si_longitudinal_radiation_damping_time_from_dipoles = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2_from_dipoles,
        si_longitudinal_damping_partition_number_from_dipoles,
        si_lattice_circumference)                                                                        
    si_longitudinal_radiation_damping_time = optics.damping_time(
        si_beam_energy, 
        si_radiation_integral_I2,
        si_longitudinal_damping_partition_number,
        si_lattice_circumference)

    si_transverse_coupling = 1.0    # [%]
    
    si_dipoles_alignment_error_tolerance = 40 # [μm]
    si_quadrupoles_alignment_error_tolerance = 40 # [μm]
    si_sextupoles_alignment_error_tolerance = 40 # [μm]
    
    si_dipoles_rotation_error_tolerance = 0.2 # [mrad]
    si_quadrupoles_rotation_error_tolerance = 0.2 # [mrad]
    si_sextupoles_rotation_error_tolerance = 0.2 # [mrad]

    si_dipoles_excitation_error_tolerance = 0.05 # [%]
    si_quadrupoles_excitation_error_tolerance = 0.05 # [%]
    si_sextupoles_excitation_error_tolerance = 0.05 # [%]
    
    '''Booster parameters'''
    
    bo_beam_current          = 2.0 # [mA]
    bo_lattice_version       = '' 
    bo_circumference         = 496.8 # [m]
    bo_lattice_symmetry      = 10
    bo_harmonic_number       = 828
    bo_optics_mode = ''

    bo_number_of_dipoles = 50
    bo_number_of_QF_quadrupoles = 50
    bo_number_of_QD_quadrupoles = 25
    bo_number_of_SF_sextupoles = 25
    bo_number_of_SD_sextupoles = 10

    bo_number_of_horizontal_dipole_correctors = 50
    bo_number_of_vertical_dipole_correctors = 50

    bo_hardedge_length_of_dipoles =  1.152 # [m]
    bo_hardedge_length_of_QF_quadrupoles = 0.3 # [m]
    bo_hardedge_length_of_QD_quadrupoles = 0.2 # [m]
    bo_hardedge_length_of_SF_sextupoles = 0.2 # [m]
    bo_hardedge_length_of_SD_sextupoles = 0.2 # [m]

    bo_dipole_deflection_angle = 7.2 # [°]

    bo_dipole_bending_radius = bo_hardedge_length_of_dipoles / math.radians(bo_dipole_deflection_angle)

    bo_maximum_integrated_sextupole = 20.0138457118891 # B''L/2 [T/m]

    bo_horizontal_dipole_corrector_maximum_strength = 0.5 # [mrad]
    bo_vertical_dipole_corrector_maximum_strength = 0.5 # [mrad]

    bo_dipoles_alignment_error_tolerance = 100 # [μm]
    bo_quadrupoles_alignment_error_tolerance = 100 # [μm]
    bo_sextupoles_alignment_error_tolerance = 100 # [μm]
    
    bo_dipoles_rotation_error_tolerance = 0.5 # [mrad]
    bo_quadrupoles_rotation_error_tolerance = 0.5 # [mrad]
    bo_sextupoles_rotation_error_tolerance = 0.5 # [mrad]

    bo_dipoles_excitation_error_tolerance = 0.1 # [%]
    bo_quadrupoles_excitation_error_tolerance = 0.2 # [%]
    bo_sextupoles_excitation_error_tolerance = 0.2 # [%]

    bo_systematic_normal_6_pole_error_tolerance_for_dipoles = -3.0e-4
    bo_systematic_normal_8_pole_error_tolerance_for_dipoles = 2.0e-4
    bo_systematic_normal_10_pole_error_tolerance_for_dipoles = 1.0e-3
    bo_systematic_normal_12_pole_error_tolerance_for_dipoles = -2.0e-3
    bo_systematic_normal_14_pole_error_tolerance_for_dipoles = 2.0e-3
    bo_systematic_normal_12_pole_error_tolerance_for_quadrupoles = 6.0e-4
    bo_systematic_normal_20_pole_error_tolerance_for_quadrupoles = -6.2e-4
    bo_systematic_normal_28_pole_error_tolerance_for_quadrupoles = -0.5e-4
    bo_systematic_normal_18_pole_error_tolerance_for_sextupoles = -4.1e-4
    bo_systematic_normal_30_pole_error_tolerance_for_sextupoles = -4.5e-4

    bo_random_normal_6_pole_error_tolerance_for_dipoles = 3.0e-4
    bo_random_normal_8_pole_error_tolerance_for_dipoles = 8.0e-5
    bo_random_normal_10_pole_error_tolerance_for_dipoles = 1.0e-4
    bo_random_normal_12_pole_error_tolerance_for_dipoles = 6.0e-5
    bo_random_normal_14_pole_error_tolerance_for_dipoles = 2.0e-4
    bo_random_normal_6_pole_error_tolerance_for_quadrupoles = 2.8e-4
    bo_random_normal_8_pole_error_tolerance_for_quadrupoles = 2.0e-4
    bo_random_normal_10_pole_error_tolerance_for_quadrupoles = 3.0e-5
    bo_random_normal_12_pole_error_tolerance_for_quadrupoles = 2.0e-4
    bo_random_normal_14_pole_error_tolerance_for_quadrupoles = 3.0e-4
    bo_random_normal_16_pole_error_tolerance_for_quadrupoles = 9.0e-5
    bo_random_normal_18_pole_error_tolerance_for_quadrupoles = 1.0e-4
    bo_random_normal_20_pole_error_tolerance_for_quadrupoles = 3.0e-5
    bo_random_normal_8_pole_error_tolerance_for_sextupoles = 5.0e-4
    bo_random_normal_10_pole_error_tolerance_for_sextupoles = 3.5e-4
    bo_random_normal_12_pole_error_tolerance_for_sextupoles = 1.0e-4
    bo_random_normal_14_pole_error_tolerance_for_sextupoles = 1.0e-4
    bo_random_normal_16_pole_error_tolerance_for_sextupoles = 1.0e-4
    bo_random_normal_18_pole_error_tolerance_for_sextupoles = 9.0e-5
    bo_random_normal_20_pole_error_tolerance_for_sextupoles = 5.0e-5
    bo_random_normal_22_pole_error_tolerance_for_sextupoles = 1.0e-5
    bo_random_normal_30_pole_error_tolerance_for_sextupoles = 8.0e-5

    bo_random_skew_6_pole_error_tolerance_for_quadrupoles = 2.9e-4
    bo_random_skew_8_pole_error_tolerance_for_quadrupoles = 1.4e-4
    bo_random_skew_8_pole_error_tolerance_for_sextupoles = 4.9e-4
    
    bo_reference_position_for_multipole_contribution_for_dipoles = 17.5 # [mm]
    bo_reference_position_for_multipole_contribution_for_quadrupoles = 17.5 # [mm]
    bo_reference_position_for_multipole_contribution_for_sextupoles = 20 # [mm]

    bo_number_of_beam_position_monitors = 50

    bo_horizontal_betatron_tune = 19.204749345767866
    bo_vertical_betatron_tune   = 7.307442329080478
    bo_synchrotron_tune         = 0.004419249840938

    bo_horizontal_natural_chromaticity = -33.704073487683672
    bo_vertical_natural_chromaticity   = -13.950562838260794

    bo_rf_cavity_peak_voltage = 0.95 # [MV]

    bo_cycling_frequency = 2.0 # [Hz]

    bo_injection_beam_energy        = 0.150 # [GeV]
    bo_injection_beam_gamma_factor  = optics.gamma(bo_injection_beam_energy)
    bo_injection_beam_beta_factor   = optics.beta(bo_injection_beam_gamma_factor)
    bo_injection_beam_velocity      = optics.velocity(bo_injection_beam_beta_factor)

    bo_injection_beam_magnetic_rigidity = optics.brho(
        bo_injection_beam_energy,
        bo_injection_beam_beta_factor)

    bo_injection_dipole_magnetic_field = bo_injection_beam_magnetic_rigidity / bo_dipole_bending_radius
    bo_injection_QF_quadrupole_maximum_gradient = 1.0132009391643900 # [T/m]
    bo_injection_QD_quadrupole_maximum_absolute_gradient = 0.1250865356993070 # [T/m]

    bo_extraction_beam_energy       = 3.0; # [GeV]
    bo_extraction_beam_gamma_factor = optics.gamma(bo_extraction_beam_energy)
    bo_extraction_beam_beta_factor  = optics.beta(bo_extraction_beam_gamma_factor)
    bo_extraction_beam_velocity     = optics.velocity(bo_extraction_beam_beta_factor)

    bo_extraction_beam_magnetic_rigidity = optics.brho(
        bo_extraction_beam_energy,
        bo_extraction_beam_beta_factor)

    bo_extraction_dipole_magnetic_field = bo_extraction_beam_magnetic_rigidity / bo_dipole_bending_radius
    bo_extraction_QF_quadrupole_maximum_gradient = 20.2640187832877 # [T/m]
    bo_extraction_QD_quadrupole_maximum_absolute_gradient = 2.5017307139861400 # [T/m]

    bo_extraction_revolution_period = optics.revolution_period(
        bo_circumference, bo_extraction_beam_velocity)

    bo_extraction_revolution_frequency = optics.revolution_frequency(
        bo_extraction_revolution_period)
    
    bo_extraction_radiation_integral_I1 =  0.357376004142324 # [m]
    bo_extraction_radiation_integral_I2 =  0.632474441350948 # [1/m]
    bo_extraction_radiation_integral_I3 =  0.065162582244920 # [1/m^2]
    bo_extraction_radiation_integral_I4 = -0.139031150720390 # [1/m]
    bo_extraction_radiation_integral_I5 =  2.029704170935785e-04 # [1/m]
    bo_extraction_radiation_integral_I6 =  0.008112620479157 # [1/m]

    bo_extraction_energy_loss_per_turn = optics.U0(
        bo_extraction_beam_energy, bo_extraction_radiation_integral_I2)

    bo_extraction_linear_momentum_compaction = optics.alpha1(
        bo_extraction_radiation_integral_I1,
        bo_circumference)
    
    bo_extraction_horizontal_damping_partition_number = optics.Jx(
        bo_extraction_radiation_integral_I2,
        bo_extraction_radiation_integral_I4)

    bo_extraction_vertical_damping_partition_number = 1.0

    bo_extraction_longitudinal_damping_partition_number = optics.Js(
        bo_extraction_horizontal_damping_partition_number,
        bo_extraction_vertical_damping_partition_number)

    bo_extraction_natural_emittance = optics.natural_emittance(
        bo_extraction_beam_gamma_factor,
        bo_extraction_horizontal_damping_partition_number,
        bo_extraction_radiation_integral_I2,
        bo_extraction_radiation_integral_I5)

    bo_extraction_natural_energy_spread = optics.energy_spread(
        bo_extraction_beam_gamma_factor,
        bo_extraction_radiation_integral_I2,
        bo_extraction_radiation_integral_I3,
        bo_extraction_radiation_integral_I4)

    bo_extraction_horizontal_radiation_damping_time = optics.damping_time(
        bo_extraction_beam_energy,
        bo_extraction_radiation_integral_I2,
        bo_extraction_horizontal_damping_partition_number,
        bo_circumference)

    bo_extraction_vertical_radiation_damping_time = optics.damping_time(
        bo_extraction_beam_energy,
        bo_extraction_radiation_integral_I2,
        bo_extraction_vertical_damping_partition_number,
        bo_circumference)

    bo_extraction_longitudinal_radiation_damping_time = optics.damping_time(
        bo_extraction_beam_energy,
        bo_extraction_radiation_integral_I2,
        bo_extraction_longitudinal_damping_partition_number,
        bo_circumference)

    bo_extraction_rf_frequency = optics.rf_frequency(
        bo_extraction_revolution_frequency, bo_harmonic_number)

    bo_extraction_rf_wavelength = optics.rf_wavelength(
        bo_extraction_rf_frequency)

    bo_extraction_radiation_power = optics.radiation_power(
        bo_extraction_energy_loss_per_turn, bo_beam_current)
    
    bo_extraction_overvoltage = optics.overvoltage(
        bo_rf_cavity_peak_voltage, bo_extraction_energy_loss_per_turn)

    bo_extraction_synchronous_phase = optics.sync_phase(
        bo_extraction_overvoltage)

    bo_extraction_synchrotron_frequency = optics.frequency_from_tune(
        bo_extraction_revolution_frequency, bo_synchrotron_tune)

    bo_extraction_rf_energy_acceptance = optics.rf_energy_acceptance(
        bo_extraction_overvoltage, bo_extraction_beam_energy,
        bo_extraction_energy_loss_per_turn, bo_harmonic_number,
        bo_extraction_linear_momentum_compaction)

    bo_extraction_slip_factor = optics.slip_factor(
        bo_extraction_linear_momentum_compaction,
        bo_extraction_beam_gamma_factor)

    bo_extraction_natural_bunch_length = optics.bunch_length(
        bo_extraction_slip_factor,
        bo_extraction_natural_energy_spread,
        bo_extraction_synchrotron_frequency)

    bo_extraction_natural_bunch_duration = optics.bunch_duration(
        bo_extraction_natural_bunch_length,
        bo_extraction_beam_beta_factor)

    '''Linac parameters'''

    li_multi_bunch_beam_energy = 150.0 # [MeV]
    li_multi_bunch_rf_frequency = 3.0 # [GHz]
    li_multi_bunch_maximum_normalized_emittance = 50.0 # [π·mm·mrad]
    li_multi_bunch_maximum_rms_energy_spread = 0.5 # [%]
    li_multi_bunch_maximum_pulse_to_pulse_energy_variation = 0.25 # [%]
    li_multi_bunch_maximum_pulse_to_pulse_jitter = 100.0 # [ps]
    li_multi_bunch_minimum_pulse_charge = 3.0 # [nC]
    li_multi_bunch_minimum_pulse_duration = 100.0 # [ns]
    li_multi_bunch_maximum_pulse_duration = 300.0 # [ns]
    li_multi_bunch_repetition_rate = 2.0 # [Hz]

    li_single_bunch_beam_energy = 150.0 # [MeV]
    li_single_bunch_rf_frequency = 3.0 # [GHz]
    li_single_bunch_maximum_normalized_emittance = 50.0 # [π·mm·mrad]
    li_single_bunch_maximum_rms_energy_spread = 0.5 # [%]
    li_single_bunch_maximum_pulse_to_pulse_energy_variation = 0.25 # [%]
    li_single_bunch_maximum_pulse_to_pulse_jitter = 100.0 # [ps]
    li_single_bunch_minimum_pulse_charge = 1.0 # [nC]
    li_single_bunch_maximum_pulse_duration = 1.0 # [ns]
    li_single_bunch_repetition_rate = 2.0 # [Hz]

    '''Linac to booster transport line parameters'''

    tb_beam_energy            = 150.0 # [MeV]
    tb_beam_gamma_factor      = optics.gamma(1.0e-3*tb_beam_energy)
    tb_beam_beta_factor       = optics.beta(tb_beam_gamma_factor)
    tb_beam_velocity          = optics.velocity(tb_beam_beta_factor)
    tb_beam_magnetic_rigidity = optics.brho(1.0e-3*tb_beam_energy, tb_beam_beta_factor)

    tb_total_length = 22.15 # [m]
    tb_number_of_dipoles = 4
    tb_number_of_quadrupoles = 13
    tb_maximum_quadrupole_gradient = 3.0 # [T/m]

    tb_arc_length_of_BN_dipoles = 0.3500 # [m]
    tb_arc_length_of_BP_dipoles = 0.5017 # [m]
    tb_arc_length_of_septum = 0.5000 # [m]

    tb_BN_dipole_deflection_angle = 15.0 # [°]
    tb_BP_dipole_deflection_angle = 21.5 # [°]
    tb_septum_deflection_angle = 10.0 # [°]

    tb_BN_dipole_bending_radius = tb_arc_length_of_BN_dipoles / math.radians(tb_BN_dipole_deflection_angle)
    tb_BP_dipole_bending_radius = tb_arc_length_of_BP_dipoles / math.radians(tb_BN_dipole_deflection_angle)
    tb_septum_bending_radius = tb_arc_length_of_septum / math.radians(tb_septum_deflection_angle)

    tb_BN_dipole_magnetic_field = tb_beam_magnetic_rigidity / tb_BN_dipole_bending_radius
    tb_BP_dipole_magnetic_field = tb_beam_magnetic_rigidity / tb_BP_dipole_bending_radius
    tb_septum_magnetic_field = tb_beam_magnetic_rigidity / tb_septum_bending_radius

    tb_BN_dipole_sagitta = 11.4 # [mm]
    tb_BP_dipole_sagitta = 23.5 # [mm]
    tb_septum_sagitta = 43.5 # [mm]

    tb_number_of_BN_dipoles = 2
    tb_number_of_BP_dipoles = 2
    tb_number_of_septa = 1

    tb_hardedge_length_of_QA1_quadrupoles = 0.05 # [m]
    tb_hardedge_length_of_QA2_quadrupoles = 0.10 # [m]
    tb_hardedge_length_of_QB1_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QB2_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QB3_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QC1_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QC2_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QC3_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QD1_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QD2_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QE1_quadrupoles = 0.15 # [m]
    tb_hardedge_length_of_QE2_quadrupoles = 0.15 # [m]
    
    '''Booster to storage ring transport line parameters'''

    ts_beam_energy            = 3.0 # [GeV]
    ts_beam_gamma_factor      = optics.gamma(ts_beam_energy)
    ts_beam_beta_factor       = optics.beta(ts_beam_gamma_factor)
    ts_beam_velocity          = optics.velocity(ts_beam_beta_factor)
    ts_beam_magnetic_rigidity = optics.brho(ts_beam_energy, ts_beam_beta_factor)

    ts_total_length = 26.5 # [m]
    ts_number_of_dipoles = 2
    ts_number_of_quadrupoles = 7
    ts_maximum_quadrupole_gradient = 25.0 # [T/m]

    ts_arc_length_of_dipoles = 0.9006 # [m]
    ts_arc_length_of_extraction_septum = 2.0 # [m]
    ts_arc_length_of_thick_injection_septum = 1.0004 # [m]
    ts_arc_length_of_thin_injection_septum = 1.4016 # [m]

    ts_dipole_deflection_angle = 7.075 # [°]
    ts_extraction_septum_deflection_angle = 6.0 # [°]
    ts_thick_injection_septum_deflection_angle = 5.8 # [°]
    ts_thin_injection_septum_deflection_angle = 4.8 # [°]

    ts_dipole_bending_radius = ts_arc_length_of_dipoles / math.radians(ts_dipole_deflection_angle)
    ts_extraction_septum_bending_radius = ts_arc_length_of_extraction_septum / math.radians(ts_extraction_septum_deflection_angle)
    ts_thick_injection_septum_bending_radius = ts_arc_length_of_thick_injection_septum / math.radians(ts_thick_injection_septum_deflection_angle)
    ts_thin_injection_septum_bending_radius = ts_arc_length_of_thin_injection_septum / math.radians(ts_thin_injection_septum_deflection_angle)

    ts_dipole_magnetic_field = ts_beam_magnetic_rigidity / ts_dipole_bending_radius
    ts_extraction_septum_magnetic_field = ts_beam_magnetic_rigidity / ts_extraction_septum_bending_radius
    ts_thick_injection_septum_magnetic_field = ts_beam_magnetic_rigidity / ts_thick_injection_septum_bending_radius
    ts_thin_injection_septum_magnetic_field = ts_beam_magnetic_rigidity / ts_thin_injection_septum_bending_radius

    ts_dipole_sagitta = 13.9 # [mm]
    ts_extraction_septum_sagitta = 104.6 # [mm]
    ts_thick_injection_septum_sagitta = 12.7 # [mm]
    ts_thin_injection_septum_sagitta = 58.7 # [mm]

    ts_number_of_dipoles = 2
    ts_number_of_extraction_septa = 1
    ts_number_of_thick_injection_septa = 1
    ts_number_of_thin_injection_septa = 1

    ts_hardedge_length_of_QA1_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QA2_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QB1_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QB2_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QC1_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QC2_quadrupoles = 0.3 # [m]
    ts_hardedge_length_of_QC3_quadrupoles = 0.3 # [m]

    ts_QA1_quadrupole_strength = -1.292 # [1/m^2]
    ts_QA2_quadrupole_strength = 1.948 # [1/m^2]
    ts_QB1_quadrupole_strength = -1.326 # [1/m^2]
    ts_QB2_quadrupole_strength = 2.054 # [1/m^2]
    ts_QC1_quadrupole_strength = 1.543 # [1/m^2]
    ts_QC2_quadrupole_strength = -2.490 # [1/m^2]
    ts_QC3_quadrupole_strength = 1.633 # [1/m^2]

    ts_QA1_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QA1_quadrupole_strength
    ts_QA2_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QA2_quadrupole_strength
    ts_QB1_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QB1_quadrupole_strength
    ts_QB2_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QB2_quadrupole_strength
    ts_QC1_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QC1_quadrupole_strength
    ts_QC2_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QC2_quadrupole_strength
    ts_QC3_quadrupole_gradient = ts_beam_magnetic_rigidity * ts_QC3_quadrupole_strength