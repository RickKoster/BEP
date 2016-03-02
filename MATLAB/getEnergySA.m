function [ E_energy_SA ] = getEnergySA( Data, layer_thickness, epsilon )
%Calculate total Electric energy in a lossy layer
%   Data must contain columns Areaum2 and Esquared

E_energy_per_element = rowfun(@(Areaum2, EsquaredNormal, EsquaredTangential) epsilon*.5*layer_thickness*EsquaredTangential*Areaum2*(10^-12)+(1/epsilon)*.5*layer_thickness*EsquaredNormal*Areaum2*(10^-12) , Data, 'InputVariables', {'Areaum2' 'EsquaredNormal' 'EsquaredTangential'}, 'OutputVariableName', 'Energy');
E_energy_SA = sum(E_energy_per_element.Energy);


end
