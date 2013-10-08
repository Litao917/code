function IDS = ID_definitions

% units
mm = 1; Tesla = 1;

%% TEST PLANAR UNDULATORS
%  ======================
IDS.UTEST.id_label                   = 'UTEST';
IDS.UTEST.nr_periods                 = 86;
IDS.UTEST.magnetic_gap               = 4.2 * mm;
IDS.UTEST.period                     = 22 * mm;
IDS.UTEST.cassette_separation        = 0.00001 * mm; 
IDS.UTEST.block_separation           = 0  * mm;
IDS.UTEST.block_width                = 25 * mm;
IDS.UTEST.block_height               = 30 * mm;
IDS.UTEST.phase_csd                  =  0 * mm;
IDS.UTEST.phase_cie                  =  0 * mm;
IDS.UTEST.chamfer                    =  0  * mm;
IDS.UTEST.magnetization              =  1.44 * Tesla;

%% WIGGLERs
%  ========

IDS.SCW3T.id_label                 = 'SCW3T';
IDS.SCW3T.nr_periods               = 16;
IDS.SCW3T.magnetic_gap             = 18.4 * mm;
IDS.SCW3T.period                   = 59.19 * mm; % from fft of field data
IDS.SCW3T.cassette_separation      = 0.001 * mm; 
IDS.SCW3T.block_separation         = 0  * mm;
IDS.SCW3T.block_width              = 39.734358709704878 * mm; % fits measured sextupolar component
IDS.SCW3T.block_height             = 40 * mm;
IDS.SCW3T.phase_csd                =  0 * mm;
IDS.SCW3T.phase_cie                =  0 * mm;
IDS.SCW3T.chamfer                  =  0  * mm;
IDS.SCW3T.magnetization            =  4.53; % gives 3T field

IDS.W2T.id_label                   = 'W2T';
IDS.W2T.nr_periods                 = 15;
IDS.W2T.magnetic_gap               = 22 * mm;
IDS.W2T.period                     = 180 * mm;
IDS.W2T.cassette_separation        = 0.001 * mm; 
IDS.W2T.block_separation           = 0  * mm;
IDS.W2T.block_width                = 40 * mm;
IDS.W2T.block_height               = 100 * mm;
IDS.W2T.phase_csd                  =  0 * mm;
IDS.W2T.phase_cie                  =  0 * mm;
IDS.W2T.chamfer                    =  0  * mm;
IDS.W2T.magnetization              =  1.9497;

%% PLANAR UNDULATORS
%  =================
IDS.U18.id_label                   = 'U18';
IDS.U18.nr_periods                 = 111;
IDS.U18.magnetic_gap               = 4.2 * mm;
IDS.U18.period                     = 18 * mm;
IDS.U18.cassette_separation        = 0.001 * mm; 
IDS.U18.block_separation           = 0  * mm;
IDS.U18.block_width                = 30 * mm;
IDS.U18.block_height               = 60 * mm;
IDS.U18.phase_csd                  =  0 * mm;
IDS.U18.phase_cie                  =  0 * mm;
IDS.U18.chamfer                    =  0  * mm;
IDS.U18.magnetization              =  1.44 * Tesla;

%% EPUs
%  ====

% --- epu50 ---
IDS.EPU50_PH.id_label             = 'EPU50_PH';
IDS.EPU50_PH.period               = 50 * mm;
IDS.EPU50_PH.nr_periods           = 60;
IDS.EPU50_PH.magnetic_gap         = 10.0 * mm;
IDS.EPU50_PH.cassette_separation  = 0.001 * mm; % diferente de zero para evitar singularidades nas express?es
IDS.EPU50_PH.block_separation     = 0  * mm;
IDS.EPU50_PH.block_width          = 40 * mm;
IDS.EPU50_PH.block_height         = 60 * mm;
IDS.EPU50_PH.phase_csd            =  0 * mm;
IDS.EPU50_PH.phase_cie            =  0 * mm;
IDS.EPU50_PH.chamfer              =  0  * mm;
IDS.EPU50_PH.magnetization        =  0.7634 * Tesla;

IDS.EPU50_PC.id_label             = 'EPU50_PC';
IDS.EPU50_PC.period               = 50 * mm;
IDS.EPU50_PC.nr_periods           = 60;
IDS.EPU50_PC.magnetic_gap         = 10.0 * mm;
IDS.EPU50_PC.cassette_separation  = 0.001 * mm; % diferente de zero para evitar singularidades nas express?es
IDS.EPU50_PC.block_separation     = 0  * mm;
IDS.EPU50_PC.block_width          = 40 * mm;
IDS.EPU50_PC.block_height         = 60 * mm;
IDS.EPU50_PC.phase_csd            =  14.5 * mm;
IDS.EPU50_PC.phase_cie            =  14.5 * mm;
IDS.EPU50_PC.chamfer              =  0  * mm;
IDS.EPU50_PC.magnetization        =  0.7634 * Tesla;

IDS.EPU50_PV.id_label             = 'EPU50_PV';
IDS.EPU50_PV.period               = 50 * mm;
IDS.EPU50_PV.nr_periods           = 60;
IDS.EPU50_PV.magnetic_gap         = 10.0 * mm;
IDS.EPU50_PV.cassette_separation  = 0.001 * mm; % diferente de zero para evitar singularidades nas express?es
IDS.EPU50_PV.block_separation     = 0  * mm;
IDS.EPU50_PV.block_width          = 40 * mm;
IDS.EPU50_PV.block_height         = 60 * mm;
IDS.EPU50_PV.phase_csd            =  25 * mm;
IDS.EPU50_PV.phase_cie            =  25 * mm;
IDS.EPU50_PV.chamfer              =  0  * mm;
IDS.EPU50_PV.magnetization        =  0.7634 * Tesla;

% --- epu200 ---
IDS.EPU200_PH.id_label            = 'EPU200_PH';
IDS.EPU200_PH.nr_periods          = 15;
IDS.EPU200_PH.magnetic_gap        = 10.0 * mm;
IDS.EPU200_PH.period              = 200 * mm;
IDS.EPU200_PH.cassette_separation = 0.001 * mm; % diferente de zero para evitar singularidades nas express?es
IDS.EPU200_PH.block_separation    = 0  * mm;
IDS.EPU200_PH.block_width         = 40 * mm;
IDS.EPU200_PH.block_height        = 60 * mm;
IDS.EPU200_PH.phase_csd           =  0 * mm;
IDS.EPU200_PH.phase_cie           =  0 * mm;
IDS.EPU200_PH.chamfer             =  0  * mm;
IDS.EPU200_PH.magnetization       =  0.3558 * Tesla;

IDS.EPU200_PC.id_label            = 'EPU200_PC';
IDS.EPU200_PC.nr_periods          = 15;
IDS.EPU200_PC.magnetic_gap        = 10.0 * mm;
IDS.EPU200_PC.period              = 200 * mm;
IDS.EPU200_PC.cassette_separation = 0.001 * mm; % diferente de zero para evitar singularidades nas express?es
IDS.EPU200_PC.block_separation    = 0  * mm;
IDS.EPU200_PC.block_width         = 40 * mm;
IDS.EPU200_PC.block_height        = 60 * mm;
IDS.EPU200_PC.phase_csd           =  50.5 * mm;
IDS.EPU200_PC.phase_cie           =  50.5 * mm;
IDS.EPU200_PC.chamfer             =  0  * mm;
IDS.EPU200_PC.magnetization       =  0.3558 * Tesla;

IDS.EPU200_PV.id_label            = 'EPU200_PV';
IDS.EPU200_PV.nr_periods          = 15;
IDS.EPU200_PV.magnetic_gap        = 10.0 * mm;
IDS.EPU200_PV.period              = 200 * mm;
IDS.EPU200_PV.cassette_separation = 0.001 * mm; % diferente de zero para evitar singularidades nas expressoes
IDS.EPU200_PV.block_separation    = 0  * mm;
IDS.EPU200_PV.block_width         = 40 * mm;
IDS.EPU200_PV.block_height        = 60 * mm;
IDS.EPU200_PV.phase_csd           =  100 * mm;
IDS.EPU200_PV.phase_cie           =  100 * mm;
IDS.EPU200_PV.chamfer             =  0  * mm;
IDS.EPU200_PV.magnetization       =  0.3558 * Tesla;