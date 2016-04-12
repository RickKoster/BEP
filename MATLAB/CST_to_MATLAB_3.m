%%IBM_hexa 5.6 GHz

%%Import from .csv file
%note: integral of electric energy on pad face (MA) by CST:
%3.128545333e-008 multiply by layer thickness > 
%3.128545333e-008 * 3*10^(-9) = 9.3856e-17



%%
%path_to_folder = 'C:\Users\rick\Documents\School\15-16\BEP\BEP\MATLAB';
path_to_folder = uigetdir;
path(path, path_to_folder);

filenames = {};

filenames.data_pads = 'data_pads.txt';
filenames.data_substrate = 'data_substrate.txt';
filenames.data_ground = 'data_ground.txt';

% disp('Select file containing field data on the pads')
% [a b] = uigetfile('\..\*.txt');
% filenames.data_pads = [b a];
% disp('Select file containing field data on the substrate')
% [a b] = uigetfile('\..\*.txt');
% filenames.data_substrate = [b a];
% disp('Select file containing field data on the ground')
% [a b] = uigetfile('\..\*.txt');
% filenames.data_ground = [b a];



%Store all data tables in cell array

Data = {};
Data.Ground = myimportdata(filenames.data_ground);
Data.Pads = myimportdata(filenames.data_pads);
Data.Substrate = myimportdata(filenames.data_substrate);

% nrOfPar = 21; %check number of parameters used in CST
% par = importmodelparameters(filenames.par, nrOfPar);



%% Separating different interfaces
MA_ground = Data.Ground;

%MS2 = intersect(data_pads,data_substrate,'rows');

MS = Data.Pads(Data.Pads.zum == 0, :);
MA = Data.Pads(Data.Pads.zum ~= 0, :);

SA_temp = setdiff(Data.Substrate,Data.Pads);
SA_temp = setdiff(SA_temp,Data.Ground);
SA = SA_temp(SA_temp.zum == 0,:);
clear SA_temp;

%% Adding material list
%removing material from struct: Materials = rmfield(Materials, material);

% Components are:
% (1) = epsilon.
% (2) = mue.
% (3) = thickness.

%add material: Materials.(string) = value;

Materials = struct;
Materials(1).vacuum = 1;
Materials(2).vacuum = 1;
Materials(1).silicon = 11.48;
Materials(2).silicon = 1;
Materials(1).MA = 10;
Materials(2).MA = 1;
Materials(3).MA = 3*10^-9;
Materials(1).MS = 7.5;
Materials(2).MS = 1;
Materials(3).MS = 3*10^-9;
Materials(1).SA = 3.9;
Materials(2).SA = 1;
Materials(3).SA = 3*10^-9;


%% Work-around
MA = [MA getEsquared(MA)];
E_energy_MA = getEnergy(MA,3,Materials(1).vacuum);

MS = [MS getEsquaredComp(MS, [0 0 1], 'EsquaredNormal')];
MS = [MS getEsquaredComp(MS, [1 1 0], 'EsquaredTangential')];

E_energy_MS = getEnergyMS(MS, Materials(3).MS, Materials(1).silicon, Materials(1).MS);

SA = [SA getEsquaredComp(SA, [0 0 1], 'EsquaredNormal')];
SA = [SA getEsquaredComp(SA, [1 1 0], 'EsquaredTangential')];

E_energy_SA = getEnergySA(SA, Materials(3).SA, Materials(1).SA);

%% Calculate Ratios
C = input('Capacitance of the structure: ');
V = input('Voltage over the incutor: ');

E_tot = .5*C*V^2;
p = struct;
p.MA = E_energy_MA/E_tot;
p.MS = E_energy_MS/E_tot;
p.SA = E_energy_SA/E_tot;

p

save([path_to_folder '\ratio'], 'p', 'E_energy_MA', 'E_energy_MS', 'E_energy_SA', 'E_tot');

%% Exclude junction region
% SA_junction = SA(abs(SA.xum) <= 2,:); % && abs(SA.xum) <= 2 && abs(SA.yum) <= 1.5, :);
% SA_junction = SA_junction(abs(SA_junction.yum) <= 1.5, :);
% E_energy_SA_junction = getEnergySA(SA_junction, Materials(3).SA, Materials(1).SA);
% 

%% remove path
rmpath(path_to_folder);

