function [ E_energy] = getEnergy( Data, layer_thickness, epsilon )
%Calculate total Electric energy in a lossy layer
%   Data must contain columns Areaum2 and Esquared
%   Give layer_thickness in nanometers
%   epsilon is the electric permittivity of the lossy layer material

epsilon_zero = 8.854e-12;
E_energy_per_element = rowfun(@(Areaum2, Esquared) epsilon_zero*epsilon*.5*layer_thickness*10^-9*Areaum2*(10^-12)*Esquared,Data, 'InputVariables', {'Areaum2' 'Esquared'}, 'OutputVariableName', 'Energyperm');
E_energy = sum(E_energy_per_element.Energyperm);


end

