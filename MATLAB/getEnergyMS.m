function [ E_energy_MS ] = getEnergyMS( Data, layer_thickness, epsilonS, epsilonMS )
%Calculate total Electric energy in a lossy layer
%   Data must contain columns Areaum2 and Esquared

E_energy_per_element = rowfun(@(Areaum2, Esquared_Normal) (epsilonS^(2)/epsilonMS)*.5*layer_thickness*Areaum2*(10^-12)*Esquared_Normal,Data, 'InputVariables', {'Areaum2' 'Esquared_Normal'}, 'OutputVariableName', 'Energy');
E_energy_MS = sum(E_energy_per_element.Energy);


end
