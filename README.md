MATLAB code for reading and writing CIFTI files, v2, alpha testing
==================================================================

This code is intended to be fully compatible with the CIFTI-2 format,
without external dependencies (except cifti-1 files require wb_command
for conversion), returning a matlab structure that exposes the
information contained in the cifti XML with minimal translation, as
well as the data matrix with no extra padding.

Additionally, it provides numerous helper functions to make many common
operations (extracting the data for one structure) into a single line
of intuitive code.

If you want the previous code that was derived from FieldTrip, it is in
the "ft_cifti" folder.

Currently, the cifti structure returned by this library uses 0-based
indices for vertex and voxel indices, 1-based for cifti indices, and
the helper functions return 1-based indices for everything.  Be aware
that this library is in alpha testing, and this convention may change.
