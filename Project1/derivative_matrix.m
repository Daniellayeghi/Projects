
function D = derivative_matrix(n)
% function dependant on the degree of the differential n
% introducing coefficients and t as time
    syms t c1 c2 c3 c4 c5 c6 c7 c0 real; 
% matrix for t components  , dm , has n rows and 8 cols
    dm = sym ('a' , [n , 8]);
    k = 8;
    % your implementation...
    for i = 1:8 
%   firt row for matrix dm*coeffcients is x and the components are the
%   powers of t 
        dm(1,i) = t^(k-1);
        k = k-1;
    end
%      other rows of the dm matrix represent nth order differential of x
%      wrt to t 
    for j = 2:n
        for m = 1:8
            dm(j,m) = diff(dm(j-1,m),t);
        end 
    end 
    coefficient = [c0;c1;c2;c3;c4;c5;c6;c7];
    D = fliplr(dm);
%     the state i.e. the differentials of x can be calculated as shown
%     below in order to check the validity of the process.
    states = D*coefficient;
    return;
end