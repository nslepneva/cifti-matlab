function cifti = cifti_file_dense_replace_surface_data(cifti, data, structure, dimension)
    %function cifti = cifti_file_dense_replace_surface_data(cifti, data, structure, dimension)
    %   Replace the data for one cifti surface structure, taking a full-surface array as input.
    %
    %   The dimension argument is optional except for dconn files.
    %   The cifti object must have exactly 2 dimensions.
    if length(cifti.diminfo) < 2
        error('cifti objects must have 2 or 3 dimensions');
    end
    if length(cifti.diminfo) > 2
        error('this function only operates on 2D cifti, use cifti_dense_get_surf_map instead');
    end
    sanity_check_cdata(cifti);
    if nargin < 4
        dimension = [];
        for i = 1:2
            if strcmp(cifti.diminfo{i}.type, 'dense')
                dimension = [dimension i]; %#ok<AGROW>
            end
        end
        if isempty(dimension)
            error('cifti object has no dense dimension');
        end
        if ~isscalar(dimension)
            error('dense by dense cifti (aka dconn) requires specifying the dimension argument');
        end
    end
    otherdim = 3 - dimension;
    surfinfo = cifti_diminfo_dense_get_surface_info(cifti.diminfo{dimension}, structure);
    if size(data, 1) ~= surfinfo.numverts
        if size(data, 2) == surfinfo.numverts && size(data, 1) == size(cifti.cdata, otherdim)
            warning('input data is transposed, this could cause an undetected error when run on different data'); %accept transposed, but warn
            data = data';
        else
            error('input data has the wrong number of vertices (or is transposed and has the wrong number of maps)');
        end
    end
    if size(data, 2) ~= size(cifti.cdata, otherdim)
        error('input data has the wrong number of maps');
    end
    if dimension == 1
        cifti.cdata(surfinfo.ciftilist, :) = data(surfinfo.vertlist1, :);
    else
        cifti.cdata(:, surfinfo.ciftilist) = data(surfinfo.vertlist1, :)';
    end
end