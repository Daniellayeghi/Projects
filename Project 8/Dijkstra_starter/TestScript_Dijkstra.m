%% Define a small map
input_map = false(10);

% Add an obstacle
input_map (1:5, 5) = true;
input_map (5, 6:9) = true;

start_coords = [6, 3];
dest_coords  = [4, 7];

%%
[route, numExpanded] = DijkstraGrid (input_map, start_coords, dest_coords, true);