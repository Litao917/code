function study_low_alpha_mode_UVX(the_ring, flag)
if flag
%     deltaf_rf_pos = 100;
%     deltaf_rf_neg = 250;
    f_rf = 476066780;
    
    [~, the_ring] = setcavity('off',the_ring);
    [~, ~, ~, ~, ~, ~, the_ring] = setradiation('off',the_ring);
    spos = findspos(the_ring,1:length(the_ring));
    bpms = findcells(the_ring,'FamName','BPM');
    
    dp = 1e-3;
    orb = findorbit4(the_ring,dp, 1:length(the_ring));
    xpos_mo = orb(1,:);
    orb = findorbit4(the_ring,-dp, 1:length(the_ring));
    xneg_mo = orb(1,:);
    
    disp1_mo = (xpos_mo-xneg_mo)/2/dp;
    disp2_mo = (xpos_mo+xneg_mo)/2/dp^2;

    file = '/home/fac_files/code/MatlabMiddleLayer/Release/machine/LNLS1/StorageRingData/LowAlpha/LOCO/2014-04-28/Disp_2014-04-28_17-18-47_config13_aqs01_5A.mat';
    dados = load(file);
    xpos = dados.BPMxDisp.Data';
    xpos = xpos*dados.BPMxDisp.dp;
    deltaf_rf_pos = -dados.BPMxDisp.dp*dados.BPMxDisp.MCF*f_rf;
%     file = 'C:\Documents and Settings\Maquina\Desktop\20140307-Estudo_Maq\med_eta_300Hz_mig11.orb';
    %     rawData1 = importdata(file);
%     xpos=rawData1(:,1)'/1000;
    
%     file = 'C:\Documents and Settings\Maquina\Desktop\20140307-Estudo_Maq\med_eta_-250Hz_mig11.orb';
%     rawData1 = importdata(file);
%     xneg = rawData1(:,1)'/1000;
%     
    alphas = mcf(the_ring,3);
    alphas = alphas([1,2]);
    alpha1 = alphas(1);
    alpha2 = alphas(2);
    deltapos = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2-deltaf_rf_pos/f_rf/alpha2);
%     deltaneg = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2+deltaf_rf_neg/f_rf/alpha2);
%     disp1 = (xpos/deltapos^2-xneg/deltaneg^2)/(1/deltapos-1/deltaneg);
%     disp2 = (xpos/deltapos-xneg/deltaneg)/(deltapos-deltaneg);
%     err = sum([(disp1-disp1_mo(bpms)).^2/max(abs(disp1_mo))^2 , (disp2-disp2_mo(bpms)).^2/max(abs(disp2_mo))^2*1e-4]);
    xpos_mo =  disp1_mo(bpms)*deltapos + disp2_mo(bpms)*deltapos^2;
%     xneg_mo =  disp1_mo(bpms)*deltaneg + disp2_mo(bpms)*deltaneg^2;
    err = sum((xpos-xpos_mo).^2);%, (xneg-xneg_mo).^2]);
    figure; plot(spos(bpms),[xpos;xpos_mo]);

    for i=1:100000
        new_alphas = alphas.*(1+0.1*(0.5-rand(1,2)));
        alpha1 = new_alphas(1);
        alpha2 = new_alphas(2);
        deltapos = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2-deltaf_rf_pos/f_rf/alpha2);
%         deltaneg = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2+deltaf_rf_neg/f_rf/alpha2);
        
        %         new_disp1 = (xpos/deltapos^2-xneg/deltaneg^2)/(1/deltapos-1/deltaneg);
        %         new_disp2 = (xpos/deltapos-xneg/deltaneg)/(deltapos-deltaneg);
        %         new_err = sum([(new_disp1-disp1_mo(bpms)).^2/max(abs(disp1_mo))^2 , (new_disp2-disp2_mo(bpms)).^2/max(abs(disp2_mo))^2*1e-4]);
        
        new_xpos_mo =  disp1_mo(bpms)*deltapos + disp2_mo(bpms)*deltapos^2;
%         new_xneg_mo =  disp1_mo(bpms)*deltaneg + disp2_mo(bpms)*deltaneg^2;
        new_err = sum([(xpos-new_xpos_mo).^2]);%, (xneg-new_xneg_mo).^2]);
        if new_err < err
            alphas = new_alphas;
            err = new_err;
            xpos_mo = new_xpos_mo;
%             xneg_mo = new_xneg_mo;
%             disp1 = new_disp1;
%             disp2 = new_disp2;
            disp(alphas);
        end
    end
    disp(alphas*1e3);
    
    figure; plot(spos(bpms),[xpos;xpos_mo]);
%     figure; plot(spos(bpms),[xneg;xneg_mo]);
    
    deltapos = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2-deltaf_rf_pos/f_rf/alpha2);
    deltaneg = -alpha1/alpha2/2 + sign(alpha1*alpha2)*sqrt((alpha1/alpha2/2)^2+deltaf_rf_neg/f_rf/alpha2);
    disp1 = (xpos/deltapos^2-xneg/deltaneg^2)/(1/deltapos-1/deltaneg);
    disp2 = (xpos/deltapos-xneg/deltaneg)/(deltapos-deltaneg);

    figure1 = figure;
    % Create axes
    axes1 = axes('Parent',figure1,'FontSize',16);
    box(axes1,'on');
    hold(axes1,'all');
    % Create multiple lines using matrix input to plot
    plot1 = plot(spos(bpms),[disp2; disp2_mo(bpms)],'Parent',axes1);
    set(plot1(1),'DisplayName','medido');
    set(plot1(2),'DisplayName','modelo');
    % Create xlabel
    xlabel('BPMs','FontSize',16);
    % Create ylabel
    ylabel('\eta_2 [m]','FontSize',16);
    % Create title
    title('Fun��es dispers�o de segunda ordem','FontSize',20);
    legend1 = legend(axes1,'show');
    set(legend1,...
        'Position',[0.751806017398898 0.771405466601973 0.0967351874244256 0.116448326055313]);

    
    % Create figure
    figure1 = figure;
    % Create axes
    axes1 = axes('Parent',figure1,'FontSize',16);
    box(axes1,'on');
    hold(axes1,'all');
    % Create multiple lines using matrix input to plot
    plot1 = plot(spos(bpms),[disp1;disp1_mo(bpms)],'Parent',axes1);
    set(plot1(1),'DisplayName','medido');
    set(plot1(2),'DisplayName','modelo');
    % Create xlabel
    xlabel('BPMs','FontSize',16);
    % Create ylabel
    ylabel('\eta_1 [m]','FontSize',16);
    % Create title
    title('Fun��es dispers�o de primeira ordem','FontSize',20);
    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,...
        'Position',[0.751806017398898 0.771405466601973 0.0967351874244256 0.116448326055313]);

    
else
    
    [~, the_ring] = setcavity('on',the_ring);
    [~, ~, ~, ~, ~, ~, the_ring] = setradiation('on',the_ring);
    orb = [0;0;0;0;0;0];
    
    
    var_grid = [linspace(-35e-2, -25e-2 ,20) linspace(-2e-2, -0.2e-3,30)];
    ngrid = length(var_grid);
    nturns = 1000;
    
    xini  = 0.1e-4*ones(1,ngrid);
    xlini = 0*ones(1,ngrid);
    yini  = 0.1e-4*ones(1,ngrid);
    ylini = 0*ones(1,ngrid);
    enini = 0*ones(1,ngrid);
    long_ini = var_grid;%0*ones(1,ngrid);
    
    Rin = repmat(orb,1,ngrid) + [xini;xlini;yini;ylini;enini;long_ini];
    
    out = ringpass(the_ring,Rin,nturns);
    
    en = reshape(out(5,:),ngrid,nturns)';
    s  = reshape(out(6,:),ngrid,nturns)';
    x  = reshape(out(1,:),ngrid,nturns)';
    xl = reshape(out(2,:),ngrid,nturns)';
    y  = reshape(out(3,:),ngrid,nturns)';
    yl = reshape(out(4,:),ngrid,nturns)';
    isnan(s(end,:));
    figure;
    plot(s,en,'.');
end