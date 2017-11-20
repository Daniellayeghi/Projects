function [f,M] = getControl(m,J,s,traj,t)
% % given values == m,J,s,traj,t
% % for x y and z maximum derivative for full state is snap ie derivative 5 
% % for si the maximum derivative for state dderevation is 3 i.e.
% % acceleration
% sepaerate states The states to positon orientation...
R = s(7 : 15);
R = reshape(R, [3,3]).';
w = s(16:18);
pos_a = s(1:3);
vel_a = s(4:6);

%trajectory time derivateives for postion and si
p_t = [ 1, t, t^2,   t^3,    t^4,    t^5,     t^6,     t^7;
0, 1, 2*t, 3*t^2,  4*t^3,  5*t^4,   6*t^5,   7*t^6;
0, 0,   2,   6*t, 12*t^2, 20*t^3,  30*t^4,  42*t^5;
0, 0,   0,     6,   24*t, 60*t^2, 120*t^3, 210*t^4;
 0, 0,   0,     0,     24,  120*t, 360*t^2, 840*t^3];

si_t = [ 1, t, t^2,   t^3,    t^4,    t^5,     t^6,     t^7;
0, 1, 2*t, 3*t^2,  4*t^3,  5*t^4,   6*t^5,   7*t^6;
0, 0,   2,   6*t, 12*t^2, 20*t^3,  30*t^4,  42*t^5;];

% seperating trajectory coefficients for position and si 
p_c = traj(:,1:3);
si_c = traj(:,4);

% Polynomial equations for trajectories in position and yaw
p_5 = p_t*p_c;
si_3 = si_t*si_c;

% assemble position velocity and acceleration vectors (desired)
pos_d = [p_5(1,1) ; p_5(1,2) ; p_5(1,3)];
vel_d = [p_5(2,1) ; p_5(2,2) ; p_5(2,3)];
acc_d = [p_5(3,1) ; p_5(3,2) ; p_5(3,3)];

% derive state parametres
% quadrotor body axis
g = 9.81;
z_b = [p_5(1,3), p_5(2,3), p_5(3,3)+g].';
z_b = z_b/norm(z_b);
% rotation matrix assembly
% x axis for the intermidiate orientation between world and quad
x_c = [cos(si_3(1)); sin(si_3(1)) ; 0];

% body frame y axis
y_b = cross(z_b, x_c)/norm(cross(z_b,x_c));

% body frame x axis 

x_b = cross(y_b, z_b);

%flat output derevations
u1 = m*(p_5(3,3)- dot([0; 0; 9.81],z_b));
u1_d = m*p_5(4,3);
p = dot(-((p_5(4,1:3).'-(dot(z_b,p_5(4,1:3).')*z_b))*m/u1),y_b);
q = dot(((p_5(4,1:3).'-(dot(z_b,p_5(4,1:3).')*z_b))*m/u1),x_b);
r = dot(si_3(2)*[0 0 1],z_b);
u1_2d = m*p_5(5,3)+u1*(q^2+r*p);

%Rotation from world to body 
R_b_w = [x_b  , y_b , z_b];
% desired angular velocities 
w_d = [p; q ;r];
% error in angular velocities 
e_w = w_d - w ;
% rotation error between the desired and current
e_R = double(R.'*R_b_w);
% Introduce gains for the position and velocity
kp = [0.00001 0 0; 0 1 0; 0 0 8];
kv = [0.0001 0 0; 0 2 0; 0 0 6];
% errors in pos and vel 
e_p = pos_d - pos_a;
e_v = vel_d - vel_a ;
% position control input
F_des = m*(acc_d + kv*e_v + kp*e_p + g*[0; 0; 1]);
u1_c = double(dot(F_des, z_b));

% introduce gains for the rotation and angular velocity
kr = [0.5 0 0; 0 1 0; 0 0 1.7];
kw = [1 0 0; 0 1 0; 0 0 2.85];
% convert e_R (rotation matrix)to axis angle
if acos((trace(e_R) - 1)/2) ~= 0
    axang = Rot_to_axang(e_R);
    e_axang = axang(4)*axang(1:3).';
else 
    e_axang = [0 ; 0 ; 0];
end
% control input for orientation cotrol
u2_c = double(cross(w,J*w)+J*(kr *e_axang + kw*e_w));
M = u2_c;
f = u1_c;

%display these
% disp('Rotation error:');
% disp(double(R));disp(double(R_b_w));
% disp('angular velocity error:');
% disp(double(e_w));
% disp('position error');
% disp('pos_a:');
% disp(double(pos_a));
% disp('pos_d:');
% disp(double(pos_d));
% disp(double(e_p));
% disp('velocity error');
% disp(double(e_v));
% disp('u1');
% disp(u1_c);
% disp('u2');
% disp(u2_c);
% disp('t');
% disp(t);

% 
%     f = 4.8797;
%     M = [0;0.0051;0];
end 