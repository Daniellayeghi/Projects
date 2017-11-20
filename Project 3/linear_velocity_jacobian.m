n = 7; % degrees of freedom of Sawyer

% initial conditions for the configuration of Sawyer shown in Figure 1.

q0 = [0 3*pi/2 0 pi 0 pi 3*pi/2];
d0 = [317 192.5 400 168.5 400 136.3 133.75];
a10 = 81;

% symbolic variables
q = sym('q', [n 1], 'real'); % generalized coordinates (joint angles)
d = sym('d', [n 1], 'real'); % link offsets
syms a1

% loads Ti - the homogeneous transformations solved for previously
load('transforms.mat');

% the center of mass of each link measured relative to the link fixed frame
% like Ti and Jw, c is an nx1 cell array where each element is a symoblic vector/matrix
% for example: c{3} = [c3x c3y c3z]' is the center of mass of link 3 measured relative to frame 3
c = arrayfun(@(x) [sym(['c' num2str(x) 'x'], 'real'), sym(['c' num2str(x) 'y'], 'real'), ...
    sym(['c' num2str(x) 'z'], 'real')]', 1:n, 'UniformOutput', 0)';

% as with the angular velocity jacobian, the linear velocity jacobian is made of of n 3xn
% symbolic matrices stored in a cell array. Jv{i} is the 3xn angular velocity jacobian of link i
Jv = cell(n,1);

Jv = cell(n,1);
d_c = sym(zeros(3,n));
for m = 1:n
    Trans = Ti{m};
    d_c(1:3,m) = Trans(1:3,:) * [c{m};1];
end 
z =sym(zeros(3,n));
z1 = [0; 0; 1];
z(1:3,1) = z1;
for kl = 2:n
    z_t = Ti{kl-1};
    z (1:3,kl) = z_t(1:3 ,3);
end
p =sym(zeros(3,n));
p1 = [0; 0; 0];
p(1:3,1) = p1;
for pl = 2:n
    p_t = Ti{pl-1};
    p (1:3,pl) = p_t(1:3 ,4);
end
  for l = 1:n
      j_v = sym(zeros(3,n));
      for j_counter = 1:l         
        j_v(1:3,j_counter) = [cross(z(:,j_counter) , (d_c(:,l)-p(:,j_counter)))];
        Jv{l} = j_v;
      end
  end