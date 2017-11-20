n = 7; % degrees of freedom of Sawyer

% initial conditions for the configuration of Sawyer shown in Figure 1.

q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
a10 = 81;

% symbolic variables
q  = sym('q',  [n 1], 'real'); % generalized coordinates (joint angles)
qd = sym('qd', [n 1], 'real'); % "q dot" - the first derivative of the q's in time (joint velocities)
d  = sym('d',  [n 1], 'real'); % link offsets
m  = sym('m',  [n 1], 'real'); % mass of each link
syms a1

% Jw, Jv - from previous problems
load('angular_velocity_jacobian.mat');
load('linear_velocity_jacobian.mat');

% inertia tensor for each link relative to the inertial frame stored in an nx1 cell array
I = arrayfun(@(x) inertia_tensor(x), 1:n, 'UniformOutput', 0)';
 
D = (m(1)*Jv{1}.'*Jv{1} + Jw{1}.'*I{1}*Jw{1});
for d_counter = 2:n
    D = D + (m(d_counter)*Jv{d_counter}.'*Jv{d_counter} + Jw{d_counter}.'*I{d_counter}*Jw{d_counter});
end

KE = 1/2*([qd(1) qd(2) qd(3) qd(4) qd(5) qd(6) qd(7)]*D*[qd(1) qd(2) qd(3) qd(4) qd(5) qd(6) qd(7)].');