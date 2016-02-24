%%IBM_hexa 5.6 GHz

%%Import from .csv file



%%

path(path,'D:\CST projects\Rick\Frequency Domain Solver\IBM_sharp_edge_segmented_pad2\');
filename_par = 'IBM_sharp_edge_segmented_pad2_Parameterlist.txt';
filename_data = 'data_incpad.txt';
filename_data_pads = 'data_pads.txt';
filename_data_substrate = 'data_substrate.txt';
filename_data_ground = 'data_ground.txt';

nrOfPar = 21; %check number of parameters used in CST

data = importdata(filename_data);
data_pads = importdata(filename_data_pads);
data_substrate = importdata(filename_data_substrate);
data_ground = importdata(filename_data_ground);



par = importmodelparameters(filename_par, nrOfPar);

rmpath('D:\CST projects\Rick\Frequency Domain Solver\IBM_sharp_edge_segmented_pad2\');
%% Separating different interfaces
MA_ground = intersect(data, data_ground,'rows');

MS_ground = intersect(data_ground,data_substrate,'rows');

%MS2 = intersect(data_pads,data_substrate,'rows');

MS = data_pads(data_pads.zum == 0, :);
MA = data_pads(data_pads.zum ~= 0, :);

SA_temp = setdiff(data,data_pads);
SA_temp = setdiff(SA_temp,data_ground);
SA = SA_temp(SA_temp.zum == 0,:);
clear SA_temp;

%% Adding E^2 
MA_squared = MA(:,[1,2,3,10]);
[m,n] = size(MA_squared);
MA_temp = MA(:,[4,5,6,7,8,9]);
Esquared = rowfun(@(ExReVm, EyReVm, EzReVm, ExImVm, EyImVm, EzImVm) sumsqr([ExReVm EyReVm EzReVm ExImVm EyImVm EzImVm]),MA_temp, 'InputVariables', {'ExReVm' 'EyReVm' 'EzReVm' 'ExImVm' 'EyImVm' 'EzImVm'}, 'OutputVariableName', 'Esquared');
MA_temp= [MA_temp Esquared];