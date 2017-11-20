function x_dot = controller(t, state_vec) % x_dot = f(x)
    
    % sprayer offset
    l = 0.1;
    
    % the position and orientation of the robot
    x = state_vec(1);
    y = state_vec(2);
    theta = state_vec(3);
    y_des = desired_path(t);
    disp(y_des)
    % your code here
    k = 2;
    lgh_inv = [cos(theta)/(cos(theta)^2 + sin(theta)^2), sin(theta)/(cos(theta)^2 + sin(theta)^2);
               -sin(theta)/(l*cos(theta)^2 + l*sin(theta)^2), cos(theta)/(l*cos(theta)^2 + l*sin(theta)^2)];
 

    y_dot_d =  [(pi*cos((pi*t)/10))/2 - 2*pi*sin((pi*t)/5);
              pi*cos((pi*t)/10) + (pi*sin((pi*t)/10))/2];
          
    y_dot = [x+l*cos(theta); y+l*sin(theta)];        
          
    u = lgh_inv*(y_dot_d+k*(y_des-y_dot));
    
    x_dot = [cos(theta) 0; sin(theta) 0; 0 1] * u;
    
end