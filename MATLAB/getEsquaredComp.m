function [ EsquaredComp ] = getEsquaredComp( Data, Components, ColumnName )
%Calculates E^2 of the normal component.
%   Calculate E^2 for selected Components for a certain Data set
%   Components must be a 1x3 vector containing binary values indicating
%   whether components must be included or not. Example: Components = [1 0
%   1] will include x- and z-components of the E-field.


% switch nargin
%     case 1
%         Components = [1 1 1];
%     case 2
        
if istable(Data)~= 0
    if isvector(Components) ~= 0
        if Components(1) == 1
            if Components(2) == 1
                if Components(3) == 1
                    EsquaredComp = rowfun(@(ExReVm, EyReVm, EzReVm, ExImVm, EyImVm, EzImVm) sumsqr([ExReVm EyReVm EzReVm ExImVm EyImVm EzImVm]),Data, 'InputVariables', {'ExReVm' 'EyReVm' 'EzReVm' 'ExImVm' 'EyImVm' 'EzImVm'}, 'OutputVariableName', ColumnName);
                else
                    EsquaredComp = rowfun(@(ExReVm, EyReVm, ExImVm, EyImVm) sumsqr([ExReVm EyReVm ExImVm EyImVm]),Data, 'InputVariables', {'ExReVm' 'EyReVm' 'ExImVm' 'EyImVm'}, 'OutputVariableName', ColumnName);
                end
            else
                if Components(3) == 1
                    EsquaredComp = rowfun(@(ExReVm, EzReVm, ExImVm, EzImVm) sumsqr([ExReVm EzReVm ExImVm EzImVm]),Data, 'InputVariables', {'ExReVm' 'EzReVm' 'ExImVm' 'EzImVm'}, 'OutputVariableName', ColumnName);
                else
                    EsquaredComp = rowfun(@(ExReVm, ExImVm) sumsqr([ExReVm ExImVm]),Data, 'InputVariables', {'ExReVm' 'ExImVm'}, 'OutputVariableName', ColumnName);
                end
            end
        else
            if Components(2) == 1
                if Components(3) == 1
                    EsquaredComp = rowfun(@(EyReVm, EzReVm, EyImVm, EzImVm) sumsqr([EyReVm EzReVm EyImVm EzImVm]),Data, 'InputVariables', {'EyReVm' 'EzReVm' 'EyImVm' 'EzImVm'}, 'OutputVariableName', ColumnName);
                else
                    EsquaredComp = rowfun(@(EyReVm, EyImVm) sumsqr([EyReVm EyImVm]),Data, 'InputVariables', {'EyReVm' 'EyImVm'}, 'OutputVariableName', ColumnName);
                end
            else
                if Components(3) == 1
                    EsquaredComp = rowfun(@(EzReVm, EzImVm) sumsqr([EzReVm EzImVm]),Data, 'InputVariables', {'EzReVm' 'EzImVm'}, 'OutputVariableName', ColumnName);
                else
                    disp('No components selected!')
                    return 
                end
            end
        end
    else disp('Second argument of getEsquaredComp must be a vector')
    end
else disp('First argmunent of getEsquaredComp must be a table')


end