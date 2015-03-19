function tracy3_da_ma_lt(path)

global THERING;
if ~isappdata(0,'ATSUMMARY')
    ats = atsummary(THERING);
    setappdata(0,'ATSUMMARY',ats);
end
% users selects submachine
prompt = {'Submachine (bo/si)', 'energy [GeV]', 'number of plots'};
defaultanswer = {'si', '3.0', '2'};
answer = inputdlg(prompt,'Select submachine, energy and nr of plots', 1, defaultanswer);
if isempty(answer), return; end;
energy = str2double(answer{2});
n_calls = round(str2double(answer{3}));

if strcmpi(answer{1}, 'bo')
    if ~exist('path','var')
        path = '/home/fac_files/data/sirius/bo/beam_dynamics';
    end
    r = which('sirius_bo_lattice.m');
    if isempty(r)
        sirius('BO');
        the_ring = THERING;
    else
        the_ring = sirius_bo_lattice(energy);
    end
    
    ats = getappdata(0, 'ATSUMMARY');
    if (energy == 0.15)
        % BOOSTER (equillibirum parameters from LINAC)
        params.E     = energy * 1e9;
        params.emit0 = 170e-9;  % linac
        params.sigE  = 5.0e-3;  % linac
        params.sigS  = 11.2e-3; % linac
        accepRF      = 0.033;
        params.K     = 0.0002;
        params.I     = 0.6;
        params.nrBun = 1;
    else
        params.E     = energy * 1e9;
        params.emit0 = ats.naturalEmittance;
        params.sigE  = ats.naturalEnergySpread;
        params.sigS  = ats.bunchlength;
        params.K     = 0.0002;
        params.I     = 0.6;
        params.nrBun = 1;
        accepRF      = ats.energyacceptance;
    end 
else
    if ~exist('path','var')
        path = '/home/fac_files/data/sirius/si/beam_dynamics';
    end
    r = which('sirius_si_lattice.m');
    if isempty(r)
        sirius('SI');
        the_ring = THERING;
    else
        the_ring = sirius_si_lattice(energy);
    end
    
    ats = getappdata(0, 'ATSUMMARY');
    params.E     = energy * 1e9;
    % Data given by Natalia
    params.emit0 = 0.306e-9; %ats.naturalEmittance;
    params.sigE  = 8.8e-4;   %ats.naturalEnergySpread;
    params.sigS  = 2.7e-3;   %3.5e-3; % takes IBS into account
    params.K     = 0.01;
    params.I     = 100;
    params.nrBun = 864;
    accepRF      = ats.energyacceptance;
end


% users selects beam lifetime parameters
prompt = {'Emitance[nm.rad]', 'Energy spread', 'Bunch length (with IBS) [mm]',...
          'Coupling [%]', 'Current [mA]', 'Nr bunches', 'RF Energy Acceptance [%]'};
defaultanswer = {num2str(params.emit0/1e-9), num2str(params.sigE), ...
                 num2str(params.sigS*1000), num2str(100*params.K), ...
                 num2str(params.I), num2str(params.nrBun), num2str(accepRF*100)};
answer = inputdlg(prompt,'Parameters for beam lifetime calculation', 1, defaultanswer);
if isempty(answer), return; end;
params.emit0 = str2double(answer{1})*1e-9;
params.sigE  = str2double(answer{2});
params.sigS  = str2double(answer{3})/1000;
params.K     = str2double(answer{4})/100;
params.I     = str2double(answer{5})/1000;
params.nrBun = round(str2double(answer{6}));
accepRF      = str2double(answer{7})/100;

params.N     = params.I/params.nrBun/1.601e-19*ats.revTime;

twi = calctwiss(the_ring);
% parâmetros para cálculo do tempo de vida
% segunda fase
% twi = calctwiss(the_ring);
% params.emit0 = 2.1e-10;
% params.E     = 3e9;
% params.N     = 350e-3/864/1.601e-19*1.72e-6;
% params.sigE  = 0.96e-3;
% params.sigS  = 13.1e-3;
% params.K     = 0.01;
% accepRF      = 0.05;

% parâmetros para cálculo do tempo de vida
% primeira fase
% params.emit0 = 2.7e-10;
% params.E     = 3e9;
% params.N     = 100e-3/864/1.601e-19*1.72e-6;
% params.sigE  = 0.87e-3;
% params.sigS  = 3.5e-3;
% params.K     = 0.01;
% accepRF      = 0.05;

%% storage ring 
% params.emit0 = 2.05e-10;
% params.E     = 3e9;
% params.N     = 350e-3/864/1.601e-19*1.72e-6;
% params.sigE  = 0.96e-3;
% params.sigS  = 13.1e-3;
% params.K     = 0.01;
% accepRF      = 0.05;

% % booster E = 3.00 GeV
% params.emit0 = 3.5e-9;
% params.E     = 3e9;
% params.N     = 0.6e-3/1/1.601e-19*1.72e-6;
% params.sigE  = 8.7e-4;
% params.sigS  = 11.2e-3;
% params.K     = 0.0002;
% accepRF      = 0.0061;

% BOOSTER E = 0.15 GeV
% params.emit0 = 170e-9; % linac
% params.E     = 0.15e9;
% params.N     = 0.6e-3/1/1.601e-19*1.72e-6;
% params.sigE  = 5e-3;    % linac
% params.sigS  = 11.2e-3; % linac
% params.K     = 0.0002;
% accepRF      = 0.033;

% parâmetros para a geração das figuras
color_vec = {'b','r','g','m','c','k','y'};
esp_lin = 5;
size_font = 24;
limx = 15;
limy = 5;
lime = 6;
scrsz = get(0,'ScreenSize');
xi = scrsz(4)/6;
yi = scrsz(4)/10;
xf = xi + scrsz(4)*(2/3);
yf = yi + scrsz(4)*(2/3);

% if ~exist('var_plane','var')
var_plane = 'x'; %determinaçao da abertura dinâmica por varreduda no plano x
% end

cell_leg_text = cell(1,n_calls);
pl = zeros(n_calls,3);
pldp = zeros(n_calls,3);
pllt = zeros(n_calls,2);
i=0;
while i < n_calls
    paths = my_uigetdir(path,'Em qual pasta estao os dados?');
    if isempty(paths);
        return;
    end
    for jj=1:length(paths)
        path = paths{jj};
        if i >= n_calls, break; end
        i=i+1;
        
        onda =  []; offda = [];
        lifetime = []; accep = []; Accep = [];
        
        [~, result] = system(['ls -la ' path ' | grep ''^d'' | grep rms | wc -l']);
        n_pastas = str2double(result);
        rms_mode = true;
        if n_pastas == 0
            rms_mode = false;
            n_pastas = 1;
        end
        %     if nr_rms == 0, nr_rms = n_pastas; end
        
        na = regexp(path,'/','split');
        cell_leg_text(i) = inputdlg('Digite a legenda','Legenda',1,na(end-2));
        
        j=1;
        m=1;
        l=0;
        for k=1:n_pastas; %min([n_pastas, nr_rms]);
            pathname = path;
            if rms_mode, pathname = fullfile(path,sprintf('rms%02d',k)); end
            
            %daxy
            if exist(fullfile(pathname,'daxy.out'),'file')
                [onda(j,:,:), ~] = tracy3_load_daxy_data(pathname,var_plane);
                j = j + 1;
            elseif exist(fullfile(pathname, 'fmap.out'),'file')
                [onda(j,:,:), ~] = tracy3_load_fmap_data(pathname,var_plane);
                j = j + 1;
            elseif exist(fullfile(pathname,'dynap_xy_out.txt'),'file');
                [onda(j,:,:), ~] = trackcpp_load_dynap_xy(pathname,var_plane);
                j = j + 1;
            else
                fprintf('%-2d-%-3d: xy nao carregou\n',i,k);
            end
            %end daxy
            %daex
            if exist(fullfile(pathname, 'daex.out'),'file')
                [offda(m,:,:), ~] = tracy3_load_daex_data(pathname);
                m = m + 1;
            elseif exist(fullfile(pathname, 'fmapdp.out'),'file')
                [offda(m,:,:), ~] = tracy3_load_fmapdp_data(pathname);
                m = m + 1;
            elseif exist(fullfile(pathname, 'dynap_ex_out.txt'),'file');
                [offda(m,:,:), ~] = trackcpp_load_dynap_ex(pathname);
                m = m + 1;
            else
                fprintf('%-2d-%-3d: ex nao carregou\n',i,k);
            end
            %end daex
            %malt
            if exist(fullfile(pathname,'momAccept.out'),'file');
                [spos, accep(l+1,:,:), ~, ~] = tracy3_load_ma_data(pathname);
                l = l + 1;
            elseif exist(fullfile(pathname,'dynap_ma_out.txt'),'file');
                [spos, accep(l+1,:,:), ~, ~] = trackcpp_load_ma_data(pathname);
                l = l + 1;
            else
                fprintf('%-2d-%-3d: ma nao carregou\n',i,k);
                break;
            end
            Accep(1,:) = spos;
            Accep(2,:) = min(accep(l,1,:), accepRF);
            Accep(3,:) = max(accep(l,2,:), -accepRF);
            % não estou usando alguns outputs
            LT = lnls_tau_touschek_inverso(params,Accep,twi);
            lifetime(l) = 1/LT.AveRate/60/60; % em horas
            %end malt
        end
        
        aveOnda = mean(onda,1);
        aveOffda = mean(offda,1);
        aveAccep = squeeze(mean(accep,1))*100; % em %
        aveLT = mean(lifetime);
        if rms_mode
            rmsOnda = std(onda,1);
            rmsOffda = std(offda,1);
            rmsAccep = squeeze(std(accep,0,1))*100;
            rmsLT = std(lifetime);
        end
        
        %% exposição dos resultados
        
        color = color_vec{i};
        
        %daxy
        if i == 1
            f=figure('OuterPosition',[xi yi xf yf]);
            fa = axes('Parent',f,'YGrid','on','XGrid','on','FontSize',size_font);
            box(fa,'on');
            hold(fa,'all');
            xlabel('x [mm]','FontSize',size_font);
            ylabel('z [mm]','FontSize',size_font);
            xlim(fa,[-limx limx]);
            ylim(fa,[0 limy]);
        end
        pl(i,2) = plot(fa, 1000*aveOnda(1,:,1), 1000*aveOnda(1,:,2), ...
            'Marker','.','LineWidth',esp_lin,'Color',color, 'LineStyle','-');
        if rms_mode
            pl(i,1) = plot(fa, 1000*(rmsOnda(1,:,1)+aveOnda(1,:,1)),1000*(rmsOnda(1,:,2)+aveOnda(1,:,2)),...
                'Marker','.','LineWidth',2,'LineStyle','--','Color', color);
            pl(i,3) = plot(fa, 1000*(aveOnda(1,:,1)-rmsOnda(1,:,1)),1000*(aveOnda(1,:,2)-rmsOnda(1,:,2)),...
                'Marker','.','LineWidth',2,'LineStyle','--','Color', color);
        end
        %end daxy
        
        %daex
        if i == 1
            fdp=figure('OuterPosition',[xi yi xf yf]);
            fdpa = axes('Parent',fdp,'YGrid','on','XGrid','on','FontSize',size_font);
            box(fdpa,'on');
            hold(fdpa,'all');
            xlabel('dp [%]','FontSize',size_font);
            ylabel('x [mm]','FontSize',size_font);
            xlim(fdpa,[-lime lime]);
            ylim(fdpa,[-limx,0]);
        end
        pldp(i,2) = plot(fdpa, 100*aveOffda(1,:,1),1000*aveOffda(1,:,2),...
            'Marker','.','LineWidth',esp_lin,'Color',color, 'LineStyle','-');
        if rms_mode
            pldp(i,1) = plot(fdpa, 100*aveOffda(1,:,1), 1000*(rmsOffda(1,:,2)+aveOffda(1,:,2)),...
                'Marker','.','LineWidth',2,'LineStyle','--','Color', color);
            pldp(i,3) = plot(fdpa, 100*aveOffda(1,:,1),1000*(aveOffda(1,:,2)-rmsOffda(1,:,2)),...
                'Marker','.','LineWidth',2,'LineStyle','--','Color', color);
        end
        %end daex
        
        %malt
        %imprime o tempo de vida
        fprintf('\n Configuração:        %-s  \n',upper(cell_leg_text{i}));
        fprintf(' Tempo de vida médio: %10.5f h \n',aveLT);
        if rms_mode; fprintf(' Desvio Padrão:       %10.5f h \n',rmsLT); end;
        
        if i == 1
            flt=figure('OuterPosition',[xi yi xf yf]);
            falt = axes('Parent',flt,'YGrid','on','XGrid','on','FontSize',size_font);
            box(falt,'on');
            hold(falt,'all');
            xlim([0, 52])
            xlabel('Pos [m]','FontSize',size_font);
            ylabel('Momentum Acceptance [%]','FontSize',size_font);
        end
        pllt(i,:) = plot(falt,spos,aveAccep, 'Marker','.','LineWidth',...
            esp_lin,'Color',color, 'LineStyle','-');
        if rms_mode;
            plot(falt,spos,aveAccep + rmsAccep, 'Marker','.','Color', color,'LineWidth',2,'LineStyle','--');
            plot(falt,spos,aveAccep - rmsAccep, 'Marker','.','Color', color,'LineWidth',2,'LineStyle','--');
        end
        %end malt
        
        disp('------------');
        drawnow;
    end
end

title_text = inputdlg('Digite um Título para os Gráficos','Título',1);


%daxy
legend(pl(:,2),'show',cell_leg_text, 'Location','Best');
title(fa,['DAXY - ' title_text{1}]);
%end daxy
%daex
legend(pldp(:,2),'show',cell_leg_text, 'Location','Best');
title(fdpa,['DAEX - ' title_text{1}]);
%end daex
%malt
legend(pllt(:,1),'show',cell_leg_text, 'Location','Best');
title(falt,['MA - ' title_text{1}]);

