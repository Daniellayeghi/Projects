% Lab 5.1 PID joint control
% Random gain variables
k_p = 230;
k_d = 78.004;
k_i = 0.0001;
% Define variables for the closed loop system
j =10;
b = 5;
% set s to laplace value
s = tf('s');
% disturbance and desired angle value not required in the TF sibce they are
% the input therefore should be set into the TF using step input
% D = 50;
% th_d = 50;

%closed loop TF with respect to disturbance derived from handouts pg 78
G_d = (-s)/((j*s^3)+(b+k_d)*s^2+k_p*s+k_i);
%closed loop TF with respect to angle derived from handouts pg 78
G_th = ((k_p*s+k_i))/((j*s^3)+(b+k_d)*s^2+k_p*s+k_i);
%closed loop TF with respect to disturbance and angle derived from handouts pg 78
G = (((k_p*s+k_i))-s)/((j*s^3)+(b+k_d)*s^2+k_p*s+k_i);
% step response of the system with respect to a 50 degree angle and
% disturbance with magnitude of 50, since both values for theta_d and D are
% 50 we can just apply step input of 50 to the overall TF G if the value
% for G and theta)d were different then step input should be applied to G_d
% and G_th seperatley
sys = step(50*G);
step(50*(G));
% use this info to estimate Kp Kd and Ki to the desied requirments of:
% ST < 5s OS< 1% and no ss error
info = stepinfo(step(50*G));
disp(info)
% this problem can also be soled using the pid tuner in matlab bu using
% pidtune(sys,'pid') where the system is just the model of the motor and
% not the full closed loop with kp kd and ki therefore the G model above
% does not work here.

ylabel('Position, \theta (radians)')
title('Response to a Step Reference with Different Values of K_p ')

