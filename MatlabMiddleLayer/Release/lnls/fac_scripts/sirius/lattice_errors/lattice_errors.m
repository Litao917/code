function r = lattice_errors(config_folder)

clc; % close('all'); fclose('all'); drawnow;

% apaga variaveis temporarias criadas em appdata por calculos anteriores
clear_appdata();
p = mfilename('fullpath');
[pathstr, ~, ~] = fileparts(p); 
cd(pathstr);


% inicializacoes basicas
% files = dir(); if ~any(strcmpi('lattice_errors.m', {files.name})), cd('../'); end
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_coup2p5'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_ripple'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_studyRespM'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_fofb'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_bpmsmoving'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_SD2Skew'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_SASkew'); end;
%if ~exist('config_folder', 'var'), config_folder = fullfile(pwd, 'CONFIG_V403_AC10_5_SD2SASkew'); end;

AData = getappdata(0, 'AcceleratorData');
if isempty(AData)
    sirius;
end
%path = fileparts(mfilename('fullpath'));
%addpath(path);
cd(config_folder);

% carrega configuracaoo com parametros do calculo
fprintf('< loading configuration parameters... > \n\n');
mfiles = dir('*.m'); config_label = strrep(mfiles(1).name,'.m','');
r = eval(config_label);
selection = 1:r.config.nr_machines;
fprintf('\n');

%selection = 93;

% calcula estruturas auxiliares baseadas nos par??metros de configura????o
fprintf('< initializing data structures... > \n\n');
r.params = initialization(r, 'ReadCODRespM', 'ReadCoupRespM', 'ReadOptRespM');

% gera vetores com erros
fprintf('< generating random errors... > \n\n');
r.errors = generate_errors(r);

% aplica erros a otica nominal e retorna estrutura com as maquinas aleatorias
fprintf('< applying random errors to bare lattice (ramping up) ... > \n\n');

for i=1:length(r.config.errors_delta)
    
    r.machine = apply_errors(r, r.config.errors_delta(i));
    
    % faz calculo da trajetoria distorcida (com sextupolos zerados)
    if r.params.cod_correction_flag
        fprintf('< calculating COD with sextupoles off... > \n\n');
                
        r.init_cod = calc_init_cod(r, selection);
        
        % faz correcao de orbita ligando gradualmente os campos dos sextupolos
        fprintf('< correcting COD with ramping up sextupoles... > \n\n');
        if isfield(r.params, 'cod_fofb_frequency')
            r.machine = correct_cod(r, selection, r.params.cod_sextupoles_ramp, r.params.cod_svs, r.params.cod_nr_iter, r.params.cod_fofb_frequency);
        else
            r.machine = correct_cod(r, selection, r.params.cod_sextupoles_ramp, r.params.cod_svs, r.params.cod_nr_iter);
        end
       
    end
      
end
r = archive_machines(r, 'save', 'machines_cod_corrected');

if r.params.optics_correction_flag
    % faz simetrizacao da rede
    fprintf('< symmetrizing optics of random machines... > \n\n');
    r.machine = correct_optics(r, selection, r.params.optics_svs, r.params.optics_nr_iter);
    r = archive_machines(r, 'save', 'machines_cod_symm_corrected'); % liga IDs antes de salvar
end

if r.params.coup_correction_flag
    % faz correcao de acoplamento
    fprintf('< correcting coupling... > \n\n');
    r.machine = correct_coupling(r, selection, r.params.coup_svs, r.params.coup_nr_iter);
    r = archive_machines(r, 'save', 'machines_cod_symm_coup_corrected'); % liga IDs antes de salvar
end

if r.params.ripple_flag
    fprintf('< calculating effects of power supply ripples on beam parameters > \n\n');
    calc_ripple_effects(r, selection);
end


% salva estruturas de dados
save([r.config.label '.mat'], 'r');

% finalizacoes
fclose('all');
cd('../');