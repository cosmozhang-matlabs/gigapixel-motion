function [ distances ] = calibrate_lens_distance( L1, L2, offsets1, offsets2, stage1, stage2 )
%CALIBRATE_LENS_DISTANCE calibrate the distance between lens
%   Calibrate according to a working distance change.
%   The 3rd and 4th params can be neither offsets or calculated residuals
%   (of image).
%   Units: L1,L2:cm; offsets1,offsets2:px; stage1,stage2:steps.
%   Output: distances: 3x2 matrix, distances of B,C,D to A

%% pre-defined parameters

res = 1.12 / 1000; % chip resolution (mm/px)
stp = 1/3200; % stage step (mm)
iml = 135; % image distance (mm)
imw = 4208; % px
imh = 3120; % px

%% calculate residuals

residuals1 = offsets1;
if size(offsets1,1) ~= 1;
    residuals1 = calibrate_motion_residual(offsets1);
end
residuals2 = offsets2;
if size(offsets2,1) ~= 1;
    residuals2 = calibrate_motion_residual(offsets2);
end

%% exchange units

L1 = L1 * 10;
L2 = L2 * 10;
residuals1 = residuals1 * res;
residuals2 = residuals2 * res;
stage1 = stage1 * stp;
stage2 = stage2 * stp;

%% calculate motions

% Residuals refers the desired offset of image motion. Stage must move
% towards the opposite direction to make the image moves to the correct
% direction. (because of flipping)

motion1 = stage1 - repmat(stage1(1,:), [size(stage1,1),1]);
motion2 = stage2 - repmat(stage2(1,:), [size(stage2,1),1]);
motion1 = stage1(2:end,:) - transpose(reshape(residuals1,[2,3]));
motion2 = stage2(2:end,:) - transpose(reshape(residuals2,[2,3]));
motiond = motion2 - motion1;

%% calculate the lens distance

distances = motiond;

end

