% calculate all combinations of the christofell symbols;
% i j and k range: 1 - 7
% matrix D is the inertial values size [7,7]
% initiate matrix of C symbols

load('Inertial_and_kinetic_energy.mat');
Cs = sym(zeros(7,7,7));

for i1 = 1:7
    for j1 = 1:7
        for k1 = 1:7
            diff1 = 1/2*(diff(D(k1,j1),q(i1)));
            diff2 = 1/2*(diff(D(k1,i1),q(j1)));
            diff3 = 1/2*(diff(D(i1,j1),q(k1)));
            Cs(i1,j1,k1) = (diff1+diff2-diff3)*qd(i1);
        end
    end
end

cor = sym(zeros(7,7));

for k1 = 1:7
    for j1 = 1:7 
        for i1 = 1:7
            cor(k1,j1)=cor(k1,j1)+Cs(i1, k1 , j1);
        end
    end
end
Phi = sym(zeros(7,1));

for i1 = 1:7
    Phi(i1) = diff(PE,q(i1));
    Phi = Phi.';
end
    