function [ params, gapH, gapV, deltaH, deltaV ] = ingroup_errors( offsets, image_size )

gr = 2; % rows of groups
gc = 2; % cols of groups
ir = 2; % rows in per group
ic = 2; % cols in per group
tr = size(offsets,1); % total rows
tc = size(offsets,2); % total cols

% group_row, group_col, chip_in_group_row, chip_in_group_col, x/y
gapH = zeros(gr,gc,ir,ic-1);
gapV = zeros(gr,gc,ir-1,ic);
deltaH = zeros(gr,gc,ir-1,ic);
deltaV = zeros(gr,gc,ir-1,ic);

for r = 1:gr
    for c = 1:gc
        gapH(r,c,:,:) = image_size(1)*(ic-1) + diff( offsets(r:gr:tr, c:gc:tc, 1), 1, 2 );
        gapV(r,c,:,:) = image_size(2)*(ir-1) + diff( offsets(r:gr:tr, c:gc:tc, 2), 1, 1 );
        deltaH(r,c,:,:) = diff( offsets(r:gr:tr, c:gc:tc, 1), 1, 1 );
        deltaV(r,c,:,:) = diff( offsets(r:gr:tr, c:gc:tc, 2), 1, 2 );
    end
end

params = struct();
params.gapH = gapH;
params.gapV = gapV;
params.deltaH = deltaH;
params.deltaV = deltaV;
