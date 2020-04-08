function outmap = cifti_diminfo_make_scalars(nummaps, namelist, metadatalist)
    %function outmap = cifti_diminfo_make_scalars(nummaps, namelist, metadatalist)
    %   Create a new scalars diminfo object.
    %
    %   Only the nummaps argument is required.
    %   The namelist argument, if provided, may be a char vector if nummaps = 1,
    %   or a cell vector of char vectors.
    %   The metadatalist argument, if provided, must be a cell vector of
    %   struct vectors with the same structure as the metadata in a cifti struct.
    outmap = struct('type', 'scalars', 'length', nummaps, 'maps', struct('name', cell(nummaps, 1), 'metadata', cell(nummaps, 1)));
    if nargin >= 2
        if ~iscell(namelist)
            if nummaps ~= 1
                error('namelist is not a cell array, and nummaps is not 1');
            end
        else
            if length(namelist) ~= nummaps
                error('namelist length and nummaps do not match');
            end
        end
    end
    if nargin >= 3
        if ~iscell(metadatalist)
            error('metadatalist must be a cell array');
        end
        if length(metadatalist) ~= nummaps
            error('metadatalist length and nummaps do not match');
        end
    end
    for i = 1:nummaps
        if nargin >= 2
            if ~iscell(namelist)
                outmap.maps(i).name = namelist;
            else
                outmap.maps(i).name = namelist{i};
            end
        else
            outmap.maps(i).name = '';
        end
        if nargin >= 3
            outmap.maps(i).metadata = metadatalist{i};
        end
    end
end