function out = DistSixLink (x1, x2)
% Compute the distance between two sets of six link coordinates
% Note we assume all angular coordinates are between 0 and 360
% Use sum of the absolute value of angle difference (L1 norm) as the
% distance.
% Note this is angle difference.
% i.e. DistSixLink([0, 0, 0, 0, 0, 0], [360, 360, 360, 360, 360, 360]) = 0
[nrow1 , ~] = size(x1);
[nrow2 , ncols2] = size(x2);
%used for RPM
for i = 1 : nrow1
    if x1(i) > 180 
        x1 (i) = abs(x1(i) - 360);
    end 
end 
for i = 1: nrow2 
    if x2(i) > 180 
        x2(i) = abs (x2(i) - 360);
    end 
end 

for i = 1 : ncols2
    out(1 , i) = sum(abs(x1 - x2(:,i)));
end
    
end
    
