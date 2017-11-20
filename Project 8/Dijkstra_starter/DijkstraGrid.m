function [route,numExpanded] = DijkstraGrid (input_map, start_coords, dest_coords, drawMap)
% input_map = false(2);
% 
% % Add an obstacle
% %input_map (1, 2) = true;
% start_coords = [1, 1];
% 
% dest_coords  = [2, 2];
cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0; ...
	0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = drawMap;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows, ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distanceFromStart = Inf(nrows, ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows, ncols);

distanceFromStart(start_node) = 0;

% keep track of number of nodes expanded 
numExpanded = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distanceFromStart(:));
    
    
    if ((current == dest_node) || isinf(min_dist))
        break
    end
    
    % Update map
    map(current) = 3;         % mark current node as visited
    
    distanceFromStart(current) = Inf; % remove this node from further consideration
    numExpanded = numExpanded+1;
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current);
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
 
    disp('current: ')
    disp(current);
    for v = [1 -1]
        for k = (1:2)
            if k == 1 
                if i + v <= nrows && i + v > 0
                       
                    if map (i+v , j) == 1 || map(i+v, j) == 6 
%                                                
                        if distanceFromStart(i+v , j)> min_dist+1
                            distanceFromStart(i+v , j) = min_dist+1;
                            parent(i+v , j) = current;
                            disp('numExpanded');
                            disp (numExpanded);    
                            disp(sub2ind(size(input_map),i+v,j));                                 
                        end 
                    end
                end 
            end 
            if k == 2
                if j + v <= ncols && j+v > 0 
                    if map(i, j+v) == 1 || map(i, j+v) == 6 

                        if distanceFromStart(i , j+v)> min_dist+1
                            distanceFromStart(i , j+v) = min_dist+1;
                            parent(i , j+v) = current;
                            disp('numExpanded');
                            disp (numExpanded);
                            disp(sub2ind(size(input_map),i,j+v));
                        end 
                    end
                end
            end                          
        end
    end 


    %*********************************************************************

end

%% Construct route from start to dest by following the parent links
if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    route = dest_node;
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
    
    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end



end
