function [bd, b_length_segmented] = dipole_segmented_model(bend_pass_method)

% % dipole model 2014-10-19
% % =======================
% % this model is based on the same approved model6 dipole
% % new python script was used to derived integrated multipoles around
% % trajectory centered in good-field region. init_rx is set to +9.045 mm
% % model segmentation was preserved (14) but multipoles were rescaled
% % from previous integrated values to new ones.
% b_model = [ ...
% % len                angle                PolynomB[1]          PolynomB[2] ...
% +1.9600000000000E-01 +2.0195440847176E-02 +0.0000000000000E+00 -2.2718737794240E-01 -1.9838101973556E+00 -6.7100381692044E+00 +4.9920710941460E-05 -1.3300435827537E-04 +2.4235784274106E-08;...
% +1.9200000000000E-01 +1.9945732400886E-02 +0.0000000000000E+00 -2.1192778004400E-01 -1.9172568031810E+00 -3.7354632993019E+00 -1.9634481701885E-05 -4.9798831271698E-05 +3.4371169036436E-09;...
% +1.5800000000000E-01 +1.6625265049598E-02 +0.0000000000000E+00 -1.8590486931855E-01 -1.8737337003164E+00 -1.6541302326730E-01 -1.9338306308259E-05 +1.2255709898644E-05 +4.1512320572352E-09;...
% +3.4000000000000E-02 +3.4121780697475E-03 +0.0000000000000E+00 -2.0790741807102E-01 -1.9108616811517E+00 +6.0211592722707E+00 -8.0389504785605E-04 +4.2587366778860E-04 -2.0493449755724E-07;...
% +3.0000000000000E-02 +1.4593537587502E-03 +0.0000000000000E+00 -9.5038400635701E-02 -1.6494710898138E+00 +2.5462042127288E+01 +9.5248097990464E-04 +3.3179449011173E-05 +3.3304203270259E-07;...
% +1.5800000000000E-01 +1.1796180861276E-03 +0.0000000000000E+00 +4.8538016476408E-03 -7.1806104227790E-01 +3.1726318161202E+00 -2.1836064393780E-05 -7.5534836079246E-06 -2.5720679947909E-09;...
% +1.0000000000000E-03 +1.4264859509966E-05 +4.1405772719342E-05 +3.0576641299928E-02 -8.2104840247350E+00 -1.3034706925023E+02 -4.3041809412239E-02 -1.1076703523835E-02 -1.0030203613377E-05;...
% ];

% % dipole model 2014-10-19
% % =======================
% % this model is based on the same approved model6 dipole
% % new python script was used to derived integrated multipoles around
% % trajectory centered in good-field region.
% % model segmentation was preserved (14) but multipoles were rescaled
% % from previous integrated values to new ones.
% b_model = [ ...
% % len               angle               PolynomB[1]         PolynomB[2] ...
% 1.9600000000000E-01	2.0195440847176E-02	0.0000000000000E+00	-2.2498523857624E-01	-1.9838101973556E+00	-3.8395034249638E+00	 4.9897118923000E-05	-7.6114588512000E-05	 2.4217805205700E-04; ...
% 1.9200000000000E-01	1.9945732400886E-02	0.0000000000000E+00	-2.0987355277378E-01	-1.9172568031810E+00	-2.1374430025332E+00	-1.9625202646000E-05	-2.8498446214000E-05	 3.4345671137000E-05; ...
% 1.5800000000000E-01	1.6625265049598E-02	0.0000000000000E+00	-1.8410288350933E-01	-1.8737337003164E+00	-9.4649814703477E-02	-1.9329167222000E-05	 7.0135920950000E-06	 4.1481525082000E-05; ...
% 3.4000000000000E-02	3.4121780697475E-03	0.0000000000000E+00	-2.0589216038374E-01	-1.9108616811517E+00	 3.4453249095120E+00	-8.0351513526300E-04	 2.4371531431000E-04	-2.0478246899820E-03; ...
% 3.0000000000000E-02	1.4593537587502E-03	0.0000000000000E+00	-9.4117188351673E-02	-1.6494710898138E+00	 1.4569454821132E+01	 9.5203084711600E-04	 1.8987649287000E-05	 3.3279496888010E-03; ...
% 1.5800000000000E-01	1.1796180861276E-03	0.0000000000000E+00	 4.8067534895050E-03	-7.1806104227791E-01	 1.8153891851240E+00	-2.1825744893000E-05	-4.3226425370000E-06	-2.5701599325000E-05; ...
% 1.0000000000000E-03	1.4264859509966E-05	4.1405772719342E-05	 3.0280260285713E-02	-8.2104840247351E+00	-7.4584973468129E+01	-4.3021468292479E-02	-6.3388804826660E-03	-1.0022762809510E-01; ...
% ];

% % dipole model
% % ============
% % this model is based on the same approved model6 dipole
% % from matlab-derived fieldmap analysis
b_model = [ ...
% len               angle                 PolynomB[1]          PolynomB[2] ...
+1.9600000000000E-01 +2.0195440847176E-02 +0.0000000000000E+00 -2.2725730095568E-01 -1.9937933516712E+00 -6.4749558242816E+00 +2.1792245824426E+02 -2.0052690828560E+04 -7.4402792791901E+06; ...
+1.9200000000000E-01 +1.9945732400886E-02 +0.0000000000000E+00 -2.1199300650646E-01 -1.9269050399702E+00 -3.6045934816304E+00 -8.5711810551822E+01 -7.5080289102069E+03 -1.0551797865958E+06; ...
+1.5800000000000E-01 +1.6625265049598E-02 +0.0000000000000E+00 -1.8596208653178E-01 -1.8831629152189E+00 -1.5961787271676E-01 -8.4418894873476E+01 +1.8477587100809E+03 -1.2744100008992E+06; ...
+3.4000000000000E-02 +3.4121780697475E-03 +0.0000000000000E+00 -2.0797140715917E-01 -1.9204777356836E+00 +5.8102114050328E+00 -3.5093006829292E+03 +6.4207768098161E+04 +6.2913990260072E+07; ...
+3.0000000000000E-02 +1.4593537587502E-03 +0.0000000000000E+00 -9.5067651254331E-02 -1.6577717450130E+00 +2.4569994061559E+01 +4.1579335040946E+03 +5.0023716629309E+03 -1.0224244064030E+08; ...
+1.5800000000000E-01 +1.1796180861276E-03 +0.0000000000000E+00 +4.8552955353741E-03 -7.2167455036586E-01 +3.0614804771706E+00 -9.5322537306261E+01 -1.1388173548021E+03 +7.8961357263592E+05; ...
+1.0000000000000E-03 +1.4264859509966E-05 +4.1405772719342E-05 +3.0586052081966E-02 -8.2518017521740E+00 -1.2578043431903E+02 -1.8789349625640E+05 -1.6700032543536E+06 +3.0792284362095E+09; ...
];

b = [];
for i=1:size(b_model,1)
    b = [b rbend_sirius('b', b_model(i,1), b_model(i,2), 0, 0, 0, 0, 0, zeros(size(b_model(i,3:end))), b_model(i,3:end), bend_pass_method)];
end
pb = marker('pb', 'IdentityPass');
mb = marker('mb', 'IdentityPass');
bd = [pb, fliplr(b) , mb, b, pb];
b_length_segmented = 2*sum(b_model(:,1));