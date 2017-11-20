n = 7; % degrees of freedom of Sawyer

% initial conditions for the configuration of Sawyer shown in Figure 1.

q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
a10 = 81;

% symbolic variables
q = sym('q', [n 1], 'real'); % generalized coordinates (joint angles)
d = sym('d', [n 1], 'real'); % link offsets
syms a1 real

% loads Ti - the homogeneous transformations solved for previously
load('transforms.mat');

% Initialize angular velocity jacobian as an nx1 cell array where each element is
% an 3xn symbolic matrix
Jw = arrayfun(@(x) sym(zeros(3,n)), 1:n, 'UniformOutput', 0)';
z =sym(zeros(3,n));
z1 = [0; 0; 1];
z(1:3,1) = z1;
for kl = 2:n
    z_t = Ti{kl-1};
    z (1:3,kl) = z_t(1:3 ,3);
end 
% base = sym(zeros(3,n));
    
  for i = 1:n
      if i ~= n
       Jw{i} = [z(1:3,1:i),sym(zeros(3,7-i))];
      else 
       Jw{i} = z(1:3,1:i);
      end
  end
  celldisp(Jw)