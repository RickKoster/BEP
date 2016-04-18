function  addMaterial( material_name, epsilon, mue )
%Add new material to existing Material structure or create new structure
%   Add a new material with: material_name (string), epsilon and mue

if exist('Materials', 'var');
    if isstruct(Materials)
        Materials(1).(material_name) = epsilon;
        Materials(2).(material_name) = mue;
    else
        disp('Materials exist as a variable but is not a structure!');
        return
    end

else
    Materials = struct;
    Materials(1).(material_name) = epsilon;
    Materials(2).(material_name) = mue;
end
return

