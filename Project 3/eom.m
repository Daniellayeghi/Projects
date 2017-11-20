
%complete equation of motion
qdd = sym('qdd', [n 1], 'real'); % "q double dot" - the second derivative of the q's in time (joint accelerations)
eom_lhs = D*qdd+Cor*qd+Phi;