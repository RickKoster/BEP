%%IBM_hexa 5.6 GHz

%%Import from .csv file
%note: integral of electric energy on pad face (MA) by CST:
%3.128545333e-008 multiply by layer thickness > 
%3.128545333e-008 * 3*10^(-9) = 9.3856e-17



%%
path_to_folder = 'C:\Users\rick\Documents\School\15-16\BEP\BEP\Raw Data\IBM_sharp_edge_segmented_pad2\';
%path_to_folder = 'D:\CST projects\Rick\Frequency Domain Solver\IBM_sharp_edge_segmented_pad2\';
path(path,path_to_folder);
filenames = {};
filenames.par = 'IBM_sharp_edge_segmented_pad2_Parameterlist.txt';
filenames.data_top = 'data_incpad.txt';
filenames.data_pads = 'data_pads.txt';
filenames.data_substrate = 'data_substrate.txt';
filenames.data_substrate_normal = 'data_substrate_normal.txt';
filenames.data_substrate_tangential = 'data_substrate_tangential.txt';
filenames.data_ground = 'data_ground.txt';

nrOfPar = 21; %check number of parameters used in CST

%Store all data tables in cell array
Data = {};
Data.Top = importdata(filenames.data_top);
Data.Ground = importdata(filenames.data_ground);
Data.Pads = importdata(filenames.data_pads);
Data.Substrate = importdata(filenames.data_substrate);
Data.Substrate_normal = importdata(filenames.data_substrate_normal);
Data.Substrate_tangential = importdata(filenames.data_substrate_tangential);





par = importmodelparameters(filenames.par, nrOfPar);
rmpath('C:\Users\rick\Documents\School\15-16\BEP\BEP\Raw Data\IBM_sharp_edge_segmented_pad2\');
%rmpath('D:\CST projects\Rick\Frequency Domain Solver\IBM_sharp_edge_segmented_pad2\');
%% Separating different interfaces
MA_ground = intersect(Data.Top, Data.Ground,'rows');

MS_ground = intersect(Data.Ground,Data.Substrate,'rows');

%MS2 = intersect(data_pads,data_substrate,'rows');

MS = Data.Pads(Data.Pads.zum == 0, :);
MA = Data.Pads(Data.Pads.zum ~= 0, :);

SA_temp = setdiff(Data.Top,Data.Pads);
SA_temp = setdiff(SA_temp,Data.Ground);
SA = SA_temp(SA_temp.zum == 0,:);
clear SA_temp;

%% Adding material list
%removing material from struct: Materials = rmfield(Materials, material);
Materials = struct;
Materials(1).vacuum = 1;
Materials(2).vacuum = 1;
Materials(1).silicon = 11.48;
Materials(2).silicon = 1;

%% Adding E^2 and Energy per m
MA_temp = MA(:,[4,5,6,7,8,9]);
%Esquared = rowfun(@(ExReVm, EyReVm, EzReVm, ExImVm, EyImVm, EzImVm) sumsqr([ExReVm EyReVm EzReVm ExImVm EyImVm EzImVm]),MA_temp, 'InputVariables', {'ExReVm' 'EyReVm' 'EzReVm' 'ExImVm' 'EyImVm' 'EzImVm'}, 'OutputVariableName', 'Esquared');
Esquared = getEsquared(MA_temp);
MA_squared = [MA Esquared];
%E_energy = getEnergy(MA_squared,3,Materials(1).vacuum);
E_energy_perm = rowfun(@(Areaum2, Esquared) Materials(1).vacuum*.5*Areaum2*(10^-12)*Esquared,MA_squared, 'InputVariables', {'Areaum2' 'Esquared'}, 'OutputVariableName', 'Energyperm');
MA_squared = [MA_squared E_energy_perm];

Energy_MA = sum(MA_squared.Energyperm)*3*10^-9;

