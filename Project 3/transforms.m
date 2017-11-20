
n = 7; % DOF

% DH parameters
q = sym('q', [n 1], 'real'); % generalized coordinates (joint angles)
x = sym('x', [n 1], 'real'); % generalized coordinates (joint angles)
d = sym('d', [n 1], 'real');
a = sym('a', [n 1], 'real'); % link offsets
syms a1 I real


% initial conditions for the configuration of Sawyer shown in Figure 1.

q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
x0 = [-pi/2 -pi/2 -pi/2 -pi/2 -pi/2 -pi/2 0];
a0 = [81 0 0 0 0 0 0]; 
I0 = 1;

% cell array of your homogeneous transformations; each Ti{i} is a 4x4 symbolic transform matrix
Ti = cell(n+1,1);
Ti(1) = {[1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1]};
% Ti{i-1} *
for i = 2:n+1
    Ti{i} =  Ti{i-1} * ([cos(q(i-1)) -sin(q(i-1)) 0 0; sin(q(i-1)) cos(q(i-1)) 0 0; 0 0 1 0; 0 0 0 1] *[1 0 0 0; 0 1 0 0; 0 0 1 d(i-1); 0 0 0 1]*[1 0 0 a(i-1); 0 1 0 0; 0 0 1 0; 0 0 0 1]*[1 0 0 0; 0 cos(x(i-1)) -sin(x(i-1)) 0 ; 0 sin(x(i-1)) cos(x(i-1)) 0; 0 0 0 1]);
end
Ti = {Ti(2:8 , 1)};
Ti = subs(Ti, [x], [x0].');
Ti = subs(Ti, a(2:n), a0(2:n).');
Ti = subs(Ti, a(1), 'a1');
Ti_c = cell (n,1);
for k = 1:n 
    Ti_c{k} = Ti(4*k-3:4*k,1:4); 
end 
Ti = cell(n,1);
Ti = Ti_c;