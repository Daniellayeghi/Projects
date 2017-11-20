function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);
current_pos  = sub2ind (size(f) , start_coords(2) , start_coords(1));
buffer = 2;
x_pos = start_coords(1);
y_pos = start_coords(2);
route (1,1) = y_pos;
route (1,2) = x_pos;
[nrows, ncols] = size(f);

while buffer <= max_its
%   find the gradient values of the current points  
    
    gx_point = gx(current_pos);
    gy_point = gy(current_pos); 
    
%    uncomment to debug gx and gy values
%     gx_point_c(buffer , 1) = gx(current_pos);
%     gy_point_c(buffer , 1) = gy(current_pos);

    grad_vec = [gx_point ; gy_point];
    
%     uncomment to debug the gradient vectoer values
%     grad_vec_c(buffer , 1) = gx_point;
%     grad_vec_c(buffer , 2) = gy_point;


    step = norm(grad_vec);
    step_x = grad_vec(1)/ step;
    step_y = grad_vec(2)/step;

    
    
%   increasing y
    y_pos = y_pos +step_y;
     
%   incresing x 
    
    x_pos = x_pos + step_x;
    
%   round values of x and y positions to fit the table
    r_y_pos = round(y_pos);
    r_x_pos = round(x_pos);
    

%   check if the rounded values are out of the map range
%   if so set them to the limits
    if r_y_pos < 1 
        r_y_pos = 1; 
    elseif r_y_pos > nrows
        r_y_pos = nrows;
    end 
    
    if r_x_pos < 1 
        r_x_pos  = 1;
    elseif r_x_pos > ncols
        r_x_pos = ncols;
    end 
    
%   find the current position using the updated positions
    current_pos  = sub2ind(size(f) , r_y_pos , r_x_pos); 
    
%   updating route todecimal acuracy since the graph can be accurate
%   decimal places and 
    route(buffer, 1) = y_pos;
    route(buffer, 2) = x_pos;
    if ((y_pos - end_coords(2))^2+(x_pos - end_coords(1))^2) <= 4 
        disp('here');
        break;
    end    
    buffer = buffer+1;
end
%   flip route for i and j to fit the maps x and y 
route = fliplr(route);

end
