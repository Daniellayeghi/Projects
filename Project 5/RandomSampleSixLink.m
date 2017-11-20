function x = RandomSampleSixLink (obstacle)
% Generate a random freespace configuration for the robot
% Hint: use CollisionCheck(fv, obstacle) to check if the configuration is
% in freespace.
while true 
    % generate 6 angles for the 6 DOF of the robot 
    cspace = 360 * rand(1,6);
    % generate polygons with the shape of the robot using the cspace
    % parameters
    Robot_polygon = SixLinkRobot(cspace);
    
    % using the triangle_intersection func used in wk 10 if no collision
    % then robot is in free space therefore configuration x is valid
    if CollisionCheck(obstacle, Robot_polygon) == false
        % return x as cspace
        x = cspace;
        break; 
    end 


end

