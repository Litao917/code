function r = calctwiss(varargin)
% r = calctwiss(varargin)
%
% calcula par?metros de twiss da rede.
% Inputs opcionais: 
% 1) the_ring, 
% 2) 'n+1' : calcula twiss no final do modelo tambem.
%
% 2013-04-24 parametro 'n+1' adicional.
% 2011-??-?? versao original.


global THERING;

np1_flag = false;

if isempty(varargin)
    the_ring = THERING;
else
    for i=1:length(varargin)
        if iscell(varargin{i})
            the_ring = varargin{i};
        elseif ischar(varargin{i})
            if strcmpi(varargin{i}, 'N+1')
                np1_flag = true;
            end
        end
    end
end

if np1_flag
    [TD, tune, chrom] = twissring(the_ring,0,1:length(the_ring)+1, 'chrom',1e-8);
else
    [TD, tune, chrom] = twissring(the_ring,0,1:length(the_ring), 'chrom',1e-8);
end

for i=1:length(TD)
    the_ring{i}.Twiss = TD(i);
end

r.pos = cat(1,TD.SPos);

beta = cat(1, TD.beta);
r.betax = beta(:,1);
r.betay = beta(:,2);

alpha = cat(1, TD.alpha);
r.alphax = alpha(:,1);
r.alphay = alpha(:,2);

mu = cat(1, TD.mu);
r.mux = mu(:,1);
r.muy = mu(:,2);

disp = cat(1,TD.Dispersion);
r.etax  = disp(1:4:end);
r.etaxl = disp(2:4:end);
r.etay  = disp(3:4:end);
r.etayl = disp(4:4:end);

co = cat(1,TD.ClosedOrbit);
r.cox  = co(1:4:end);
r.coxp = co(2:4:end);
r.coy  = co(3:4:end);
r.coyp = co(4:4:end);

r.chromx = chrom(1);
r.chromy = chrom(2);

if isempty(varargin)
    THERING = the_ring;
else
    r.THERING = the_ring;
end






