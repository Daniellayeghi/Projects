function [ h ] = plot_line( start, finish, color )
%PLOT_LINE Plots a line in 3D from start to finish

    h = plot3([start(1) finish(1)], [start(2) finish(2)], [start(3) finish(3)], color);

end