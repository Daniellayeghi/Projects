n = 7; % degrees of freedom of Sawyer

% initial conditions for the configuration of Sawyer shown in Figure 1.
% you can use these values to sense check your work
q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
a10 = 81;

% symbolic variables
q = sym('q', [n 1], 'real'); % generalized coordinates (joint angles)
d = sym('d', [n 1], 'real'); % link offsets
syms a1 real
m = sym('m', [n 1], 'real'); % mass of each link
syms g real % gravity

% loads Ti - the homogeneous transformations solved for previously
load('transforms.mat');

% the center of mass of each link measured relative to the link fixed frame.
% like Ti and Jw, c is an nx1 cell array where each element is a symoblic vector/matrix
% for example: c{3} = [c3x c3y c3z]' is the center of mass of link 3 measured relative to frame 3
c = arrayfun(@(x) [sym(['c' num2str(x) 'x'], 'real'), sym(['c' num2str(x) 'y'], 'real'), ...
    sym(['c' num2str(x) 'z'], 'real')]', 1:n, 'UniformOutput', 0)';

d_c = sym(zeros(3,n));
for k = 1:n
    Trans = Ti{k};
    d_c(1:3,k) = Trans(1:3,:) * [c{k};1];
end 

for i = 1:n
    PE = m(i)*[0 ; 0; g].'*d_c(1:3,i) + PE;
end
disp(PE);