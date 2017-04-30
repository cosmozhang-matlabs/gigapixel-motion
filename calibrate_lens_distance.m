function [motion_residual] = calibrate_lens_distance (offsets)

%% pre-defined parameters

res = 1.12 / 1000; % chip resolution (mm/px)
stp = 1/3200; % stage step (mm)
imw = 4208; % px
imh = 3120; % px

%% symbols

% motion residuals to be optimized
HA = 0;
VA = 0;
sym HB;
sym VB;
sym HC;
sym VC;
sym HD;
sym VD;

%% calculation

overlapH = -diff(offsets(:,:,1), 1, 2);
overlapV = -diff(offsets(:,:,2), 1, 1);
deltaH = diff(offsets(:,:,1), 1, 1);
deltaV = diff(offsets(:,:,2), 1, 2);

optHB_ = mean(mean(overlapH([1,3],:))) - HB/3;
optHB1 = overlapH(1,1) - HB - optHB_;
optHB2 = overlapH(1,2) + HB - optHB_;
optHB3 = overlapH(1,3) - HB - optHB_;
optHB4 = overlapH(3,1) - HB - optHB_;
optHB5 = overlapH(3,2) + HB - optHB_;
optHB6 = overlapH(3,3) - HB - optHB_;
optdVB1 = deltaV(1,1) + VB;
optdVB2 = deltaV(1,2) + VB;
optdVB3 = deltaV(1,3) + VB;
optdVB4 = deltaV(3,1) + VB;
optdVB5 = deltaV(3,2) + VB;
optdVB6 = deltaV(3,3) + VB;
optVB_ = mean(mean(overlapV([3,1],:))) - VB/3;
optVC1 = overlapV(1,1) - VC - optVC_;
optVC2 = overlapV(2,1) + VC - optVC_;
optVC3 = overlapV(3,1) - VC - optVC_;
optVC4 = overlapV(1,3) - VC - optVC_;
optVC5 = overlapV(2,3) + VC - optVC_;
optVC6 = overlapV(3,3) - VC - optVC_;
optdVC1 = deltaH(1,1) + VC;
optdVC2 = deltaH(2,1) + VC;
optdVC3 = deltaH(3,1) + VC;
optdVC4 = deltaH(1,3) + VC;
optdVC5 = deltaH(2,3) + VC;
optdVC6 = deltaH(3,3) + VC;

end