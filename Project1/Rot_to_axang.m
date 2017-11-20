function [axang] = Rot_to_axang(R)
     
    vec = zeros(1,3);
        
    theta = acos(((trace(R)-1)/2));
    if theta ~= 0 && theta ~= pi
        theta = acos(((trace(R)-1)/2));
        % 9 elements but we only use 6 since in ROT matrix some info is repeated.
        vec(1,1) = 1/(2*sin(theta))*(R(3,2)-R(2,3));
        vec(1,2) = 1/(2*sin(theta))*(R(1,3)-R(3,1));
        vec(1,3) = 1/(2*sin(theta))*(R(2,1)-R(1,2));
    
    end 
    % singularity when theta is 0 
    if theta == 0
        vec = nan(1,3);
    end 
    % singularity when theta is pi 
    if theta == pi
        vec = zeros(2,3);
        % using the idagnal elements of the R matrix we can decompose vec
        
        if R(1,1) == -1 
            vec = zeros(2,3);
            vec(1,2) = sqrt((R(2,2)-cos(theta))/(1-cos(theta)));
            vec(1,1) = R(2,1)/(vec(1,2)*2);
            vec(1,3) = R(2,3)/(vec(1,2)*2);
            vec(2,2) = -vec(1,2);
            vec(2,1) = R(2,1)/(vec(2,2)*2);
            vec(2,3) = R(2,3)/(vec(2,2)*2);
            disp(2);
        end
        if R(1,1) == 1 && R(3,3) == -1 || R(2,2) == -1
            vec = zeros(2,3);
            vec(1,1) = sqrt((R(1,1)-cos(theta))/(1-cos(theta)));
            vec(1,2) = R(1,2)/(vec(1,1)*2);
            vec(1,3) = R(1,3)/(vec(1,1)*2);
            vec(2,1) = -vec(1,1);
            vec(2,2) = R(1,2)/(vec(2,1)*2);
            vec(2,3) = R(1,3)/(vec(2,1)*2);
            disp(3);
        end
        if R(2,2) == 1 && R(1,1) == -1 || R(3,3) == -1
            vec = zeros(2,3);
            vec(1,2) = sqrt((R(2,2)-cos(theta))/(1-cos(theta)));
            vec(1,1) = R(2,1)/(vec(1,2)*2);
            vec(1,3) = R(2,3)/(vec(1,2)*2);
            vec(2,2) = -vec(1,2);
            vec(2,1) = R(2,1)/(vec(2,2)*2);
            vec(2,3) = R(2,3)/(vec(2,2)*2);
            disp(2);
        end
        if R(3,3) == 1 && R(1,1) == -1 || R(2,2) == -1
            vec = zeros(2,3);
            vec(1,3) = sqrt((R(3,3)-cos(theta))/(1-cos(theta)));
            vec(1,1) = R(3,1)/(vec(1,3)*2);
            vec(1,2) = R(3,2)/(vec(1,3)*2);
            vec(2,3) = -vec(1,3);
            vec(2,1) = R(3,1)/(vec(2,3)*2);
            vec(2,2) = R(3,2)/(vec(2,3)*2); 
            disp(1);
        end
          theta = [pi;pi];
    end
    axang = [vec,theta];
    disp(axang);

end