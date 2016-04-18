function [ Esquared ] = getEsquared( Data )
%Calculates E^2
%   Calculates E^2 by taking the squared sum of all components.
if istable(Data)~= 0
    Esquared = rowfun(@(ExReVm, EyReVm, EzReVm, ExImVm, EyImVm, EzImVm) sumsqr([ExReVm EyReVm EzReVm ExImVm EyImVm EzImVm]),Data, 'InputVariables', {'ExReVm' 'EyReVm' 'EzReVm' 'ExImVm' 'EyImVm' 'EzImVm'}, 'OutputVariableName', 'Esquared');
else disp('Input of getEsquared is not a table')


end

