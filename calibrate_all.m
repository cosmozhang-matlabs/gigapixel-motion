load('data.mat');

dis1 = calibrate_lens_distance(877,415,off_877,off_415,stage_877,stage_415);
dis2 = calibrate_lens_distance(877,621,off_877,off_621,stage_877,stage_621);

meanH = mean([dis1(1,1),dis1(3,1),dis2(1,1),dis2(3,1)]);
meanV = mean([dis1(2,2),dis1(3,2),dis2(2,2),dis2(3,2)]);