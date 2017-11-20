function A = compute_dh_matrix(r, alpha, d, theta)

    %% Your code goes here
    rot_z = [cos(theta) -sin(theta) 0 0; sin(theta) cos(theta) 0 0; 0 0 1 0; 0 0 0 1];
    tran_z = [1 0 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
    tran_x = [1 0 0 r; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    rot_x = [1 0 0 0; 0 cos(alpha) -sin(alpha) 0; 0 sin(alpha) cos(alpha) 0; 0 0 0 1];
    A = eye(4);
    A = rot_z*tran_z*tran_x*rot_x;
    
end