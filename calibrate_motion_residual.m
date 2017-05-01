function [motion_residual] = calibrate_motion_residual (offsets)

%% symbols

% motion residuals to be optimized
% HA = 0;
% VA = 0;
syms HB;
syms VB;
syms HC;
syms VC;
syms HD;
syms VD;

%% calculate optimize items

overlapH = -diff(offsets(:,:,1), 1, 2);
overlapV = -diff(offsets(:,:,2), 1, 1);
deltaH = diff(offsets(:,:,1), 1, 1);
deltaV = diff(offsets(:,:,2), 1, 2);

% overlapH:
%   H_A1_B1  H_A2_B1  H_A2_B2
%   H_C1_D1  H_C2_D1  H_C2_D2
%   H_A3_B3  H_A4_B3  H_A4_B4
%   H_C3_D3  H_C4_D3  H_C4_D4
%
% overlapV:
%   V_A1_C1  V_B1_D1  V_A2_C2  V_B2_D2
%   V_A3_C1  V_B3_D1  V_A4_C3  V_B4_D3
%   V_A3_C3  V_B3_D3  V_A4_C4  V_B4_D4
%
% deltaH:
%   dh_A1_C1  dh_B1_D1  dh_A2_C2  dh_B2_D2
%   dh_A3_C1  dh_B3_D1  dh_A4_C3  dh_B4_D3
%   dh_A3_C3  dh_B3_D3  dh_A4_C4  dh_B4_D4
%
% deltaV:
%   dV_A1_B1  dV_A2_B1  dV_A2_B2
%   dV_C1_D1  dV_C2_D1  dV_C2_D2
%   dV_A3_B3  dV_A4_B3  dV_A4_B4
%   dV_C3_D3  dV_C4_D3  dV_C4_D4

% H_A_B
optHAB_ = mean(mean(overlapH([1,3],:))) - HB/3;
optHAB1 = overlapH(1,1) - HB - optHAB_;
optHAB2 = overlapH(1,2) + HB - optHAB_;
optHAB3 = overlapH(1,3) - HB - optHAB_;
optHAB4 = overlapH(3,1) - HB - optHAB_;
optHAB5 = overlapH(3,2) + HB - optHAB_;
optHAB6 = overlapH(3,3) - HB - optHAB_;

% deltaV_A_B
optdVAB1 = deltaV(1,1) + VB;
optdVAB2 = deltaV(1,2) + VB;
optdVAB3 = deltaV(1,3) + VB;
optdVAB4 = deltaV(3,1) + VB;
optdVAB5 = deltaV(3,2) + VB;
optdVAB6 = deltaV(3,3) + VB;

% V_A_C
optVAC_ = mean(mean(overlapV(:,[1,3]))) - VB/3;
optVAC1 = overlapV(1,1) - VC - optVAC_;
optVAC2 = overlapV(2,1) + VC - optVAC_;
optVAC3 = overlapV(3,1) - VC - optVAC_;
optVAC4 = overlapV(1,3) - VC - optVAC_;
optVAC5 = overlapV(2,3) + VC - optVAC_;
optVAC6 = overlapV(3,3) - VC - optVAC_;

% deltaH_A_C
optdHAC1 = deltaH(1,1) + HC;
optdHAC2 = deltaH(2,1) + HC;
optdHAC3 = deltaH(3,1) + HC;
optdHAC4 = deltaH(1,3) + HC;
optdHAC5 = deltaH(2,3) + HC;
optdHAC6 = deltaH(3,3) + HC;

% H_C_D
optHCD_ = mean(mean(overlapH([2,4],:))) + HC/3 - HD/3;
optHCD1 = overlapH(2,1) + HC - HD - optHCD_;
optHCD2 = overlapH(2,2) - HC + HD - optHCD_;
optHCD3 = overlapH(2,3) + HC - HD - optHCD_;
optHCD4 = overlapH(4,1) + HC - HD - optHCD_;
optHCD5 = overlapH(4,2) - HC + HD - optHCD_;
optHCD6 = overlapH(4,3) + HC - HD - optHCD_;

% V_B_D
optVBD_ = mean(mean(overlapV(:,[2,4]))) + VB/3 - VD/3;
optVBD1 = overlapV(1,2) + VB - VD - optVBD_;
optVBD2 = overlapV(2,2) - VB + VD - optVBD_;
optVBD3 = overlapV(3,2) + VB - VD - optVBD_;
optVBD4 = overlapV(1,4) + VB - VD - optVBD_;
optVBD5 = overlapV(2,4) - VB + VD - optVBD_;
optVBD6 = overlapV(3,4) + VB - VD - optVBD_;

% deltaH_B_D
optdHBD1 = deltaH(1,2) - HB + HD;
optdHBD2 = deltaH(2,2) - HB + HD;
optdHBD3 = deltaH(3,2) - HB + HD;
optdHBD4 = deltaH(1,4) - HB + HD;
optdHBD5 = deltaH(2,4) - HB + HD;
optdHBD6 = deltaH(3,4) - HB + HD;

% deltaV_C_D
optdVCD1 = deltaV(2,1) - VC + VD;
optdVCD2 = deltaV(2,2) - VC + VD;
optdVCD3 = deltaV(2,3) - VC + VD;
optdVCD4 = deltaV(4,1) - VC + VD;
optdVCD5 = deltaV(4,2) - VC + VD;
optdVCD6 = deltaV(4,3) - VC + VD;

%% calculate loss function

loss = optHAB1^2  + optHAB2^2  + optHAB3^2  + optHAB4^2  + optHAB5^2  + optHAB6^2  ...
     + optdVAB1^2 + optdVAB2^2 + optdVAB3^2 + optdVAB4^2 + optdVAB5^2 + optdVAB6^2 ...
     + optVAC1^2  + optVAC2^2  + optVAC3^2  + optVAC4^2  + optVAC5^2  + optVAC6^2  ...
     + optdHAC1^2 + optdHAC2^2 + optdHAC3^2 + optdHAC4^2 + optdHAC5^2 + optdHAC6^2 ...
     + optVBD1^2  + optVBD2^2  + optVBD3^2  + optVBD4^2  + optVBD5^2  + optVBD6^2  ...
     + optHCD1^2  + optHCD2^2  + optHCD3^2  + optHCD4^2  + optHCD5^2  + optHCD6^2  ...
     + optdHBD1^2 + optdHBD2^2 + optdHBD3^2 + optdHBD4^2 + optdHBD5^2 + optdHBD6^2 ...
     + optdVCD1^2 + optdVCD2^2 + optdVCD3^2 + optdVCD4^2 + optdVCD5^2 + optdVCD6^2;

%% calculate partials

pHB = diff(loss, HB);
pVB = diff(loss, VB);
pHC = diff(loss, HC);
pVC = diff(loss, VC);
pHD = diff(loss, HD);
pVD = diff(loss, VD);

%% solve the maximum

[sHB,sVB,sHC,sVC,sHD,sVD] = solve( pHB, pVB, pHC, pVC, pHD, pVD, HB, VB, HC, VC, HD, VD );

motion_residual = double([sHB,sVB,sHC,sVC,sHD,sVD]);

end