function [ pos, R ] = RPR_fk( theta1, d2, theta3 )
% The input to the function will be the joint
%    angles of the robot in radians, and the extension of the prismatic joint in inches.
%    The output includes: 
%    1) The position of the end effector and the position of 
%    each of the joints of the robot, as explained in the question.
%    2) The rotation matrix R_03, as explained in the question.

    pos = zeros(4, 3);
    %DH sequence
    frame_0 = compute_dh_matrix(0,0,0,0);
    pos(1,:) = frame_0(1:3,end);
    frame_1 = compute_dh_matrix(0,-2.3562,10,theta1);
    pos(2,:) = frame_1(1:3,end);
    frame_2 = compute_dh_matrix(0,-1.5708,d2,-1.5708);
    frame_2 = frame_1*frame_2;
    pos(3,:) = frame_2(1:3,end);
    %arbitary axis
    frame_3 = compute_dh_matrix(5,0,0,-0.7854+theta3);
    frame_3 = frame_2*frame_3;
    frame_4 = compute_dh_matrix(0,0,0,1.5708);
    frame_4 = frame_3*frame_4;
    frame_5 = compute_dh_matrix(0,1.5708,0,0);
    frame_5 = frame_4*frame_5;
    frame_6 = compute_dh_matrix(0,0,0,1.5708);
    frame_6 = frame_5*frame_6;
    %final output 
    pos(4,:) = frame_6(1:3,end); 
    R = frame_6(1:3,1:3);        
    

end