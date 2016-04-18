function [ E_energy_MS ] = getEnergyMS( Data, layer_thickness, epsilonS, epsilonMS )
%Calculate total Electric energy in a lossy layer
%   Data must contain columns Areaum2 and Esquared
%   Give layer_thickness in meters
%   epsilonS is the electric permittivity of the substrate
%   epsilon MS is the electric permittivity of the MS interface material.

epsilon_zero = 8.854e-12;
E_energy_per_element = rowfun(@(Areaum2, EsquaredNormal) epsilon_zero*(epsilonS^(2)/epsilonMS)*.5*layer_thickness*Areaum2*(10^-12)*EsquaredNormal,Data, 'InputVariables', {'Areaum2' 'EsquaredNormal'}, 'OutputVariableName', 'Energy');
E_energy_MS = sum(E_energy_per_element.Energy);


end
