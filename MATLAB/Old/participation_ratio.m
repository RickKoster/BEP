%%Import simulated E-field

filename  = 'D:\CST projects\Rick\IBM_no_etching_data\data_pad_e_abs_phase0.txt';
data_efield = importdata(filename);

%% Import model parameters



%% Separate tetrahedral beloning to different interfaces
% Substrate-Air (SA) interface should be at z = 0;
% Pad coordinates must be known to separate Metal-Subtrate (MS) and SA
% interfaces

MA = data_efield(data_efield.zum>0,:);
MA_top = data_efield(data_efield.zum==0.2,:);

S = data_efield(data_efield.zum==0,:);

%finding borders of pad

pad_h = max(data_efield.zum);




