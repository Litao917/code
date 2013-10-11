function booster
%ALBA_BOOSTER lattice definition file
% Created 16/11/06
%

global FAMLIST THERING GLOBVAL

GLOBVAL.E0 = 0.1e+9;
GLOBVAL.LatticeFile = mfilename;
FAMLIST = cell(0);

disp(['**   Loading ALBA Booster lattice ', mfilename]);

AP = aperture('AP', [-0.0155, 0.0155, -0.0155, 0.0155],'AperturePass');

% Cavity
L0 =  2.496000000000002e+02;	% design length  [m]
C0 =   299792458; 	% speed of light [m/s]
HarmNumber = 416;
CAV	= rfcavity('RF' , 0 , 850e+3 , HarmNumber*C0/L0, HarmNumber ,'CavityPass');

D001      =    drift('D001', 1.230, 'DriftPass');
D002      =    drift('D002', 0.100, 'DriftPass');
D003      =    drift('D003', 0.090, 'DriftPass');
D004      =    drift('D004', 0.100, 'DriftPass');
D005      =    drift('D005', 0.330, 'DriftPass');
D006      =    drift('D006', 0.660, 'DriftPass');
D007      =    drift('D007', 0.500, 'DriftPass');
D008      =    drift('D008', 0.720, 'DriftPass');
D009      =    drift('D009', 0.130, 'DriftPass');
D010      =    drift('D010', 0.470, 'DriftPass');
D011      =    drift('D011', 0.150, 'DriftPass');
D012      =    drift('D012', 1.840, 'DriftPass');
D013      =    drift('D013', 0.770, 'DriftPass');
D113      =    drift('D013', 0.668, 'DriftPass');
D014      =    drift('D114', 0.810, 'DriftPass');
D114      =    drift('D114', 0.912, 'DriftPass');
D015      =    drift('D015', 1.450, 'DriftPass');

QF1 =    quadrupole('QF1',  0.36,  1.362000, 'StrMPoleSymplectic4Pass');
QF2 =    quadrupole('QF2',  0.36,  1.580000, 'StrMPoleSymplectic4Pass');
%QF2 =    quadrupoleC('QF2',  0.36,  1.580000, 4.39/2, 'StrMPoleSymplectic4Pass');
QD1 =    quadrupole('QD1',  0.20, -1.024000, 'StrMPoleSymplectic4Pass');
QD2 =    quadrupole('QD2',  0.20, -1.130000, 'StrMPoleSymplectic4Pass');

% SD1    = sextupole('SD1', 0.20, 0, 'StrMPoleSymplectic4Pass');
% SF2    = sextupole('SF', 0.20, 0, 'StrMPoleSymplectic4Pass');

SD    = sextupole('SD', 0.20, -12.70/0.2/2, 'StrMPoleSymplectic4Pass');
SF    = sextupole('SF', 0.20,   2.96/0.2/2, 'StrMPoleSymplectic4Pass');

bangle05 =  5*pi/180;
bangle10 = 10*pi/180;

% BM05 = sbendC ('BEND', 1.000, bangle05, bangle05/2, bangle05/2,...
%                  -0.229, -2.22/2, 'BndMPoleSymplectic4Pass');
% BM10 = sbendC ('BEND', 2.000, bangle10, bangle10/2, bangle10/2,...
%                  -0.229, -2.22/2, 'BndMPoleSymplectic4Pass');

% BM05 = sbendC ('BEND', 1.000, bangle05, bangle05/2, bangle05/2,...
%                  -0.229, -2.22/2+0.98/2, 'BndMPoleSymplectic4Pass');
% BM10 = sbendC ('BEND', 2.000, bangle10, bangle10/2, bangle10/2,...
%                  -0.229, -2.22/2+0.98/2, 'BndMPoleSymplectic4Pass');

BM05 = sbend('BEND', 1.000, bangle05, bangle05/2, bangle05/2,...
                 -0.229,  'BndMPoleSymplectic4Pass');
BM10 = sbend('BEND', 2.000, bangle10, bangle10/2, bangle10/2,...
                 -0.229,  'BndMPoleSymplectic4Pass');

HCM = corrector('HCM', 0.0, [0 0],'CorrectorPass');
VCM = corrector('VCM', 0.0, [0 0],'CorrectorPass');
BPM  = marker('BPM','IdentityPass');

% Begin Lattice
VHCMBPM = [VCM D009 BPM D009 HCM];
HVCMBPM = [HCM D009 BPM D009 VCM];
HCMBPM =  [D009 BPM HCM D009];

ARC1 =     [D001  QF1  D002  HCM D003 BPM D003 VCM  D004  QD1  D005  ... 
            BM05  D006  QD2  D007  SD  D008  VHCMBPM  D010 SF  D011 ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D011  SF  D015  SD  D007  QD2  D006  BM05  ...
            D005  QD1  D004  VCM  D003  BPM  D003  HCM  D002  QF1  D001];

ARC2 =     [D001  QF1  D002  HCM D003 BPM D003 VCM  D004  QD1  D005  ... 
            BM05  D006  QD2  D007  SD  D008  VHCMBPM  D010 SF  D011 ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D011  SF  D015  SD  D007  QD2  D006  BM05  ...
            D005  QD1  D004  VCM  D003  BPM  D003  HCM  D002  QF1  D001];

ARC3 =     [D001  QF1  D002  HCM D003 BPM D003 VCM  D004  QD1  D005  ... 
            BM05  D006  QD2  D007  SD  D008  VHCMBPM  D010 SF  D011 ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D011  SF  D015  SD  D007  QD2  D006  BM05  ...
            D005  QD1  D004  VCM  D003  BPM  D003  HCM  D002  QF1  D001];

ARC4 =     [D001  QF1  D002  HCM D003 BPM D003 VCM  D004  QD1  D005  ... 
            BM05  D006  QD2  D007  SD  D008  VHCMBPM  D010 SF  D011 ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D012  ...
            QF2  D114  HVCMBPM  D113  BM10  D013  VHCMBPM  D014  ...
            QF2  D012  BM10  D013  VHCMBPM  D014  ...
            QF2  D011  SF  D015  SD  D007  QD2  D006  BM05  ...
            D005  QD1  D004  VCM  D003  BPM  D003  HCM  D002  QF1  D001];

        
BOOSTER = [ARC1 ARC2 ARC3 ARC4 CAV];


% MACHINE = [CAV SECTOR1 SECTOR2 SECTOR3 SECTOR4];

buildlat(BOOSTER);

% set all magnets to the same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);

%evalin('caller','global THERING FAMLIST GLOBVAL');

atsummary;

if nargout
    varargout{1} = THERING;
end

% Compute total length and RF frequency
L0_tot=0;
for i=1:length(THERING)
    L0_tot=L0_tot+THERING{i}.Length;
end
fprintf('   Model booster circumference is %.6f meters\n', L0_tot)
fprintf('   Model RF frequency is %.6f MHz\n', HarmNumber*C0/L0_tot/1e6)


clear global FAMLIST
%clear global GLOBVAL when GWig... has been changed.

%evalin('caller','global THERING FAMLIST GLOBVAL');
