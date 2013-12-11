function assr4(varargin)
% Lattice definition file - generated by dimad2at v1.300000 
%
% Eugene 2004-12-13 Updating the generalised file to realign the family
% names and elements with aspinit. NOTE: aspinit will not work with split
% elements... not without modification of the init file.
%
% Eugene 2005-09-16 Standardise all lattices being used to this. "Custom"
% versions of the lattice files, eg for ML, ID studies etc will take this
% file as a template. The following major changes were made -
%    * All family names in CAPS in line with ALS and SPEAR convention.
%    * Dipole path and gradient updated to reflect numerical studies on
%      measured data. Quadrupole values fitted for a tune of 13.3, 5.2 and
%      zero dispersion given the new dipole gradient fields.
%    * Merged with "aspsr_msrf.m" with independent/individual cavitie(s).
%    * Element positions/lengths should be inline with engineering
%      drawings.

global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 3e9;
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

L0 = 2.159946602239996e+02; % calculated using findspos %215.9945540689991;% with new dipole path lengths. Designed for 216m.
C0 = 299792458; 	   % speed of light [m/s]
HarmNumber = 360;

disp(' ');
fprintf('*** Loading lattice from %s.m ***\n',GLOBVAL.LatticeFile);

% With AT1.3 ringpass and atlinepass, particles limited by the apperturepass
% will have [x,x',y,y',delta,dl] = [NaN,0,0,0,0,0]. All pass methods will
% check for this and do nothing to particles with these coordinates.
% Ring/linepass will both return particle positions as well as the number
% of turns the particles achieved.
% ap  =   aperture('AP',[-32 17 -16 16]*1e-3,'AperturePass');
ap  =   aperture('AP',[-16 17 -16 16]*1e2,'AperturePass');

d1	=	drift('D1'	,2.698300e+000,'DriftPass'); % (2.698286 -> to get closer to the design distance of 216m)
d2	=	drift('D2'	,1.900000e-001,'DriftPass');
d3	=	drift('D3'	,1.650000e-001,'DriftPass');
d4	=	drift('D4'	,2.750000e-001,'DriftPass');
d5	=	drift('D5'	,1.550000e-001,'DriftPass');
d6	=	drift('D6'	,4.500000e-001,'DriftPass');

% Modified drifts around BPM sections.
bpm	=	monitor('BPM'	,'IdentityPass');
d1a	=	drift('D1A'	,len(d1)-3.942860e-001,'DriftPass'); % 2.304000e+000
d1b	=	drift('D1B'	,        3.942860e-001,'DriftPass');
d1aa=	drift('D1A'	,len(d1)-0.58,'DriftPass'); % Last bpm
d1bb=	drift('D1B'	,        0.58,'DriftPass');
d4a	=	drift('D4A'	,len(d4)-1.990000e-001,'DriftPass'); % 7.600000e-002
d4b	=	drift('D4B'	,        1.990000e-001,'DriftPass');
d4aa	=	drift('D4AA'	,len(d4)-6.400000e-002,'DriftPass'); % 2.110000e-001
d4bb	=	drift('D4BB'	,        6.400000e-002,'DriftPass');
d2a	=	drift('D2A'	,len(d2)-1.030000e-001,'DriftPass'); % 8.700000e-002
d2b	=	drift('D2B'	,        1.030000e-001,'DriftPass');

% Dipoles
% design -> rbend('BEND',1.726000e+000,2.243995e-001,...
%                     1.121997e-001,1.121997e-001,-3.349992e-001,[method]);
% From numerical studies ->   L: 1.72579121675e+000
%                             K: 0.33295132
%                          Sext: 0.01092687
%                           Oct: 0.15166053
dip1	=	rbend('BEND'	,1.72579121675e+000,2.243995e-001,1.121997e-001,1.121997e-001,-0.33295132,'BndMPoleSymplectic4Pass');
dip2	=	rbend('BEND'	,1.72579121675e+000,2.243995e-001,1.121997e-001,1.121997e-001,-0.33295132,'BndMPoleSymplectic4Pass');

scalek = 0.991;
% scales = 12.64758043225615;
scales = 1;
leftdrift_a = drift('leftdrift',0.076,'DriftPass');
leftdrift_b = drift('leftdrift',0.0837626757-len(leftdrift_a),'DriftPass');
rightdrift_b = drift('rightdrift',0.064,'DriftPass');
rightdrift_a = drift('rightdrift',0.0887292346-len(rightdrift_b),'DriftPass');

% sf1	=	sextupole('SF1'	,0, 0.11741231554986,'ThinMPolePass');
% sf2	=	sextupole('SF2'	,0, 0.11741231554986,'ThinMPolePass');
b_left01 = rbend('b_left01',0.0695312761,0.0001684486,0.0000000000,0.0000000000,-0.0058550750*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.0058550750*scalek 0.0862147892*scales -1.2289013273]);
b_left02 = rbend('b_left02',0.0695282915,0.0007117061,0.0000000000,0.0000000000,-0.0239389168*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.0239389168*scalek -0.0583359949*scales -0.0632750927]);
b_left03 = rbend('b_left03',0.0695152451,0.0032675350,0.0000000000,0.0000000000,-0.2254325358*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.2254325358*scalek 0.2451727966*scales -0.1103893288]);
b_left04 = rbend('b_left04',0.0694679183,0.0087995936,0.0000000000,0.0000000000,-0.4158165694*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.4158165694*scalek -0.1443627022*scales 0.6681103839]);
b_left05 = rbend('b_left05',0.0694041758,0.0092692887,0.0000000000,0.0000000000,-0.3298403749*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3298403749*scalek -0.0340207205*scales 0.3349521492]);
b_centre01 = rbend('b_centre01',0.2820465390,0.0367531161,0.0000000000,0.0000000000,-0.3315842393*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3315842393*scalek 0.0083655817*scales 0.2965845308]);
b_centre02 = rbend('b_centre02',0.2815037989,0.0354072994,0.0000000000,0.0000000000,-0.3306516396*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3306516396*scalek 0.0236710994*scales -0.2196079070]);
b_centre03 = rbend('b_centre03',0.2813281018,0.0349189639,0.0000000000,0.0000000000,-0.3300962629*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3300962629*scalek 0.0101400673*scales -0.5218735605]);
b_centre04 = rbend('b_centre04',0.2814996751,0.0353946664,0.0000000000,0.0000000000,-0.3302155286*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3302155286*scalek 0.0236248098*scales -0.2148826863]);
b_centre05 = rbend('b_centre05',0.2820380879,0.0367421671,0.0000000000,0.0000000000,-0.3312220213*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3312220213*scalek 0.0103909753*scales 0.2969171603]);
b_right01 = rbend('b_right01',0.0694014448,0.0092683157,0.0000000000,0.0000000000,-0.3292611055*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3292611055*scalek -0.0291322494*scales 0.3681905186]);
b_right02 = rbend('b_right02',0.0694650575,0.0090036557,0.0000000000,0.0000000000,-0.3961176951*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3961176951*scalek -0.1539214712*scales 0.9528854933]);
b_right03 = rbend('b_right03',0.0695141539,0.0037120061,0.0000000000,0.0000000000,-0.2701751814*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.2701751814*scalek 0.3742213022*scales 0.7022676128]);
b_right04 = rbend('b_right04',0.0695280819,0.0007962279,0.0000000000,0.0000000000,-0.0288159660*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.0288159660*scalek -0.0571472318*scales 0.2460706289]);
b_right05 = rbend('b_right05',0.0695312501,0.0001902235,0.0000000000,0.0000000000,-0.0028161106*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.0028161106*scalek -0.1077402629*scales 0.7697020810]);

% RBEND
% b_left01 = rbend('b_left01',0.0695312761,0.0001700782,0.1121962211,-0.1120187381,0.0026580668*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 0.0026580668*scalek -0.0222542890 -0.0307698880]);
% b_left02 = rbend('b_left02',0.0695282915,0.0007118132,0.1120187381,-0.1112734474,0.0004302895*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 0.0004302895*scalek -0.0824996146 -0.0652385243]);
% b_left03 = rbend('b_left03',0.0695152451,0.0032678721,0.1112734474,-0.1078414785,-0.1045888695*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.1045888695*scalek -0.0928717833 0.2254072448]);
% b_left04 = rbend('b_left04',0.0694679183,0.0088002187,0.1078414785,-0.0989182337,-0.3486275471*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3486275471*scalek -0.0656081148 0.3572852967]);
% b_left05 = rbend('b_left05',0.0694041758,0.0092692888,0.0989182337,-0.0896518010,-0.3281526271*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3281526271*scalek -0.0355726539 0.3355904266]);
% b_centre01 = rbend('b_centre01',0.2820465390,0.0367531221,0.0896518010,-0.0529125655,-0.3312315118*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3312315118*scalek 0.0081060667 0.2963931827]);
% b_centre02 = rbend('b_centre02',0.2815037989,0.0354072962,0.0529125655,-0.0175134439,-0.3306429237*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3306429237*scalek 0.0237264198 -0.2192733272]);
% b_centre03 = rbend('b_centre03',0.2813281018,0.0349189640,0.0175134439,0.0174054578,-0.3300984023*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3300984023*scalek 0.0101509428 -0.5218382720]);
% b_centre04 = rbend('b_centre04',0.2814996751,0.0353946633,-0.0174054578,0.0528080683,-0.3302048119*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3302048119*scalek 0.0235987043 -0.2144554284]);
% b_centre05 = rbend('b_centre05',0.2820380879,0.0367421699,-0.0528080683,0.0895641319,-0.3309037380*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3309037380*scalek 0.0102169077 0.2963545009]);
% b_right01 = rbend('b_right01',0.0694014448,0.0092683188,-0.0895641319,0.0988345428,-0.3275972520*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3275972520*scalek -0.0308930090 0.3680490900]);
% b_right02 = rbend('b_right02',0.0694650575,0.0090032960,-0.0988345428,0.1077882518,-0.3467634133*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.3467634133*scalek -0.0345063628 0.6218385567]);
% b_right03 = rbend('b_right03',0.0695141539,0.0037116695,-0.1077882518,0.1112699557,-0.1347732139*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.1347732139*scalek 0.0189958278 0.8526578807]);
% b_right04 = rbend('b_right04',0.0695280819,0.0007961566,-0.1112699557,0.1120205593,-0.0014988960*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 -0.0014988960*scalek -0.0849450391 0.2100836063]);
% b_right05 = rbend('b_right05',0.0695312501,0.0001897883,-0.1120205593,0.1121997376,0.0026764692*scalek,'BndMPoleSymplectic4Pass',[0 0 0 0],[0 0.0026764692*scalek -0.0276971797 0.0360627830]);

dipole_arc = [leftdrift_a bpm leftdrift_b b_left01 b_left02 b_left03 b_left04 ...
       b_left05 b_centre01 b_centre02 b_centre03 b_centre04 ...
       b_centre05 b_right01 b_right02 b_right03 b_right04 ...
       b_right05 rightdrift_a bpm rightdrift_b];

% dipole_arc = [leftdrift_a bpm leftdrift_b sf1 b_left01 b_left02 b_left03 b_left04 ...
%        b_left05 b_centre01 b_centre02 b_centre03 b_centre04 ...
%        b_centre05 b_right01 b_right02 b_right03 b_right04 ...
%        b_right05 sf2 rightdrift_a bpm rightdrift_b];
   
% Quadrupoles (for design dipole: [QFA,QDA,QFB]=[1.761741,-1.038377,1.533802];
% To match new single dipole values from numerical studies
% tune of 13.3, 5.2 and 0 dispersion in straights.
% qfa	=	quadrupole('QFA'	,3.550000e-001, 1.7610967e+000,'QuadLinearPass');
% qda	=	quadrupole('QDA'	,1.800000e-001,-1.0715748e+000,'QuadLinearPass');
% qfb	=	quadrupole('QFB'	,3.550000e-001, 1.5406418e+000,'QuadLinearPass');

% To match split dipole values from numerical studies (SBENDS)
% tune of 13.216, 5.3006 and 0 dispersion in straights.
% qfa	=	quadrupole('QFA'	,3.550000e-001, 1.7610967e+000,'QuadLinearPass');
% qda	=	quadrupole('QDA'	,1.800000e-001,-1.0715748e+000,'QuadLinearPass');
% qfb	=	quadrupole('QFB'	,3.550000e-001, 1.5406418e+000,'QuadLinearPass');

% To match split dipole values from numerical studies (RBENDS)
% tune of 13.216, 5.3006 and 0 dispersion in straights.
%  qfa	=	quadrupole('QFA'	,3.550000e-001, 1.7521052e+000,'QuadLinearPass');
%  qda	=	quadrupole('QDA'	,1.800000e-001,-1.0897262e+000,'QuadLinearPass');
%  qfb	=	quadrupole('QFB'	,3.550000e-001, 1.5452228e+000,'QuadLinearPass');

% To match split dipole values from numerical studies (RBENDS)
% tune of 13.29, 5.216 and 0 dispersion in straights.
% qfa	=	quadrupole('QFA'	,3.550000e-001, 1.76190217411609,'QuadLinearPass');
% qda	=	quadrupole('QDA'	,1.800000e-001,-1.08597141914729,'QuadLinearPass');
% qfb	=	quadrupole('QFB'	,3.550000e-001, 1.54443756044807,'QuadLinearPass');

% To match split dipole values from numerical studies (SBENDS)
% tune of 13.29, 5.216 and 0 dispersion in straights.
qfa	=	quadrupole('QFA'	,3.550000e-001, 1.76272982211693,'QuadLinearPass');
qda	=	quadrupole('QDA'	,1.800000e-001,-1.06276736743823,'QuadLinearPass');
qfb	=	quadrupole('QFB'	,3.550000e-001, 1.53992875479511,'QuadLinearPass');


% Sextupoles with built in correctors. Corrector settings given by kick
% angle in radians.
sfa	=	sextcorr('SFA'	,2.000000e-001, 1.400000e+001,[0 0],'StrCorrMPoleSymplectic4Pass');
sda	=	sextcorr('SDA'	,2.000000e-001,-1.400000e+001,[0 0],'StrCorrMPoleSymplectic4Pass');
sdb	=	sextcorr('SDB'	,2.000000e-001,-7.014635e+000,[0 0],'StrCorrMPoleSymplectic4Pass');
sfb	=	sextcorr('SFB'	,2.000000e-001, 7.189346e+000,[0 0],'StrCorrMPoleSymplectic4Pass');
% sdb	=	sextcorr('SDB'	,2.000000e-001,-8.16157050824899,[0 0],'StrCorrMPoleSymplectic4Pass');
% sfb	=	sextcorr('SFB'	,2.000000e-001, 7.49928624020018,[0 0],'StrCorrMPoleSymplectic4Pass');

wig = multipole('wig',0,[0 0 0 0],[0 0 0 10],'ThinMPolePass');
wig = wiggler('ID12', 2, 0.1, 1.9, 5, 2, [0; 0; 0; 0; 0; 0;], [0; 0; 0; 0; 0; 0;], 'WigSymplectic4Pass')

% RF cavity and the corresponding straight used to position the cavity.
% 4.996540652069698e+008 old freq for 216m for 216.0004 its different. Also
% we are using ThinCavities therefore the drifts have to be set
% accordingly.
cav_single = rfcavity('RF' ,0.0,3.00e+006,C0/L0*HarmNumber,HarmNumber,'CavityPass'); 
cav        = rfcavity('RF' ,0.0,0.75e+006,C0/L0*HarmNumber,HarmNumber,'CavityPass');
% drifts around the rf cavities and space between them
d1ar1    =   drift('D1AR1'	,len(d1a)-len(cav_single)/2  ,'DriftPass'); % for just 1 cavity
drf      =	 drift('DRF'    ,0.45                        ,'DriftPass'); % space between cavities
d1ar4	 =	 drift('D1AR4'	,len(d1a)-len(cav)-len(drf)/2,'DriftPass'); % for 4 cavities
cav_pair = [cav drf cav];
dRF1 = drift('dRF1'	,len(d1)-2.55  ,'DriftPass');
dRF2 = drift('dRF2'	,2.55/3  ,'DriftPass');


% Kickers and the associated drifts to position them. (to be checked)
kick1	=	corrector('KICK'	,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
kick2	=	corrector('KICK'	,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
kick3	=	corrector('KICK'	,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
kick4	=	corrector('KICK'	,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
%fast feedback kicks
ffbh	=	corrector('FFBH'	,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
ffbv    =   corrector('FFBV'    ,0.000000e+000,[0.000000e+000 0.0],'CorrectorPass');
% Drift spaces to replace D1A for the upstream kickers, ie kickers 1 and 3.
d1ak2_up=	drift('D1AK2_UP'	,0.779 - len(d1b),'DriftPass');
d1ak1_up=	drift('D1AK1_UP'	,len(d1a) - len(d1ak2_up),'DriftPass');
% Drift spaces to replace D1A for the downstream kickers, ie kickers 2 and 4.
d1ak2_do=	drift('D1AK2_DO'	,1.073 - len(d1bb),'DriftPass');
d1ak1_do=	drift('D1AK1_DO'	,len(d1aa) - len(d1ak2_do),'DriftPass');


% Define the position of the bpm. bpm1d1 represents BPM number 1 in the D1
% straight and bpm5d4 represents BPM number 5 in straight d4. bpm7dk and
% bpm7dr repreents BPM number 7 in either the kicker stright or RF
% straight.
bpm1d1 = [ d1a bpm d1b ];
bpm1d1k = inline(['['  num2str(d1ak1_up) ' '  'kicker '  num2str(d1ak2_up) ' '  num2str(bpm) ' '  num2str(d1b) ' '  ']' ], 'kicker'); % Kicker
bpm1d1r1 = [ d1ar1 bpm d1b ]; % RF 1 cavity
%bpm1d1r4 = [ d1ar4 bpm d1b ]; % RF 4 cavity
bpm2d4 = [ d4a bpm d4b ];
bpm3d4 = [ d4aa bpm d4bb ];
bpm4d2 = [ d2a bpm d2b ];
bpm5d4 = [ bpm2d4 ];
bpm6d4 = [ bpm3d4 ];
bpm7d1 = [ d1bb bpm d1aa ];
bpm7d1k = inline(['['  num2str(d1bb) ' '  num2str(bpm) ' '  num2str(d1ak2_do) ' '  'kicker '  num2str(d1ak1_do) ' '  ']' ], 'kicker'); % Kicker
bpm7d1r1 = [ d1b bpm d1ar1 ];  % RF 1 cavity
%bpm7d1r4 = [ d1b bpm d1ar4 ];  % RF 4 cavity
bpm1d1RF = [ dRF1 bpm dRF2 cav dRF2 cav dRF2 ];

d1ffb = [];
bpm7d1ffb = [ d1b bpm d1ffb ]; %fast feedback kicker

% Arrange the elements onto the girders and use markers to define the
% sections for misalignment studies.
g1m1 = marker('g1m1','IdentityPass');
g1m2 = marker('g1m2','IdentityPass');
g2m1 = marker('g2m1','IdentityPass');
g2m2 = marker('g2m2','IdentityPass');
% girder1 = [ g1m1 sfa hcor sfa d2 qfa d3 sda vcor sda g1m2];
% girder2 = [ g2m1 sdb vcor sdb d5 qda d6 qfb d2 sfb hcor sfb bpm4d2 qfb d6 qda d5 sdb vcor sdb g2m2];
% girder3 = [ g1m1 sda vcor sda d3 qfa d2 sfa hcor sfa g1m2];
girder1 = [ g1m1 sfa d2 qfa d3 sda g1m2];
girder2 = [ g2m1 sdb d5 qda d6 qfb d2 sfb bpm4d2 qfb d6 qda d5 sdb g2m2];
girder3 = [ g1m1 sda d3 qfa d2 sfa g1m2];


% Arrange the girders into the different cell arrangements.
unit_cel = [ bpm1d1 girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1 ];
% Kickers in cells 1 and 14
celkick14 = [ bpm1d1k(kick1) girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1k(kick2) ];
celkick01 = [ bpm1d1k(kick3) girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1k(kick4) ];
% Shorten the straights in cells 6, 7 and 8 to put in the rf
% 4 RF cavities

celrf06_4 = [ bpm1d1RF girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1 ];
celrf07_4 = [ bpm1d1RF girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1 ];
%celrf06_4 = [ bpm1d1   girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1r4 ];
%celrf07_4 = [ bpm1d1r4 girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1r4 ];
%celrf08_4 = [ bpm1d1r4 girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1   ];

% Single RF cavity
celrf06_1 = [ bpm1d1   girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1r1 ];
celrf07_1 = [ bpm1d1r1 girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1   ];
%diagnostic straight with fast feedback kicker
celffb10_1 = [ bpm1d1 girder1 dipole_arc girder2 dipole_arc girder3 bpm7d1ffb ]; %includes fast feedback kicker

% Shift sector
shift1 = quadrupole('SHIFT1'	,0, 0,'QuadLinearPass');
shift2 = quadrupole('SHIFT2'	,0, 0,'QuadLinearPass');



% Definition of the types of rings
kickring    = [ ap celkick01 unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel celkick14];
% cavity1ring = [ ap celrf06_1 cav_single celrf07_1 unit_cel  unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel ];
% cavity4ring = [ ap celrf06_4 cav_pair   celrf07_4 cav_pair celrf08_4 unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel ];
cavity1ring = [ ap celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_1 cav_single celrf07_1 unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel celkick14];;
cavity4ring = [ ap celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_4 celrf07_4 unit_cel unit_cel unit_cel unit_cel wig unit_cel unit_cel celkick14];

%cavity4ring = [ ap celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_4 cav_pair   celrf07_4 cav_pair celrf08_4 unit_cel unit_cel unit_cel unit_cel unit_cel celkick14];

fullring_startwithRF = [ ap cav_single celrf07_1 unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel celkick14 celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_1 ];
ring        = [ ap unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel ];
fullring    = [ ap celkick14 celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_1 cav_single celrf07_1 unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel ];
%fast feedback kicker included:
ffbring     = [ ap celkick01 unit_cel unit_cel unit_cel unit_cel celrf06_1 cav_single celrf07_1 unit_cel unit_cel celffb10_1 unit_cel unit_cel unit_cel celkick14];
% Wiggler
wigring        = [ ap unit_cel wig unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel unit_cel ];

% Choose which lattice to load else load "fullring" as the default.
if nargin > 0
    fprintf('Using lattice : %s \n', varargin{1});
    eval(['buildlat(' varargin{1} ');']);
else
    % Default lattice to load
    fprintf('Using default lattice : cavity4ring\n');
    buildlat(cavity4ring);
end

% Make the variables THERING and GLOBVAL available to the caller's
% workspace.
evalin('caller','global THERING GLOBVAL');
disp('** Done **');

% New AT 1.3 does not require FAMLIST and is fazing out GLOBVAL
clear global FAMLIST

setenergymodel(3);

% Internal function used to return the length of a defined element.
function res = len(id)
global FAMLIST
res = FAMLIST{id}.ElemData.Length;

