function [ ik_sol ] = RPR_ik( x, y, z, R )
%The input to the function will be the position of
%    the end effector (in inches) in the world frame, and the 
%    Rotation matrix R_30 as described in the question.
%    The output must be the joint angles and extensions of the robot to achieve 
%    the end effector position and orientation.


ik_sol = ones(1, 3);
%checking inverse kinematics

ctheta1 = R(1,1);
stheta1 = R(2,1); 
% calculating theta 1
theta1_2 = atan2(stheta1,ctheta1);

if cos(theta1_2) > 0
    theta3_2 = atan2(R(2,2),R(2,3));
end 
if cos (theta1_2) <0 
    theta3_2 = atan2(-R(2,2),-R(2,3));
end
d3 = (z-((-sin(-2.3562)*5*cos(deg2rad(-45)+theta3_2))-(cos(-2.3562)*5*sin(deg2rad(-45)+theta3_2))+10))/(cos(-2.3562));
ik_sol = [theta1_2 d3 theta3_2];
end