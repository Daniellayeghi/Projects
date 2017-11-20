function C = waypoints(boundary, ps, ts)
    
    % example input: trajectory from r=0 @ t=0 to
    % r=1 @ t=5, with all higher boundary derivatives
    % equal to zero, with waypoints r=2 @ t=1, and
    % r=3 @ t=3
    % boundary = [0; 0; 0; 0; 1; 0; 0; 0];
    % ps = [2; 3];
    % ts = [1; 3; 5];
    
    syms t real
    
    D7 = derivative_matrix(7);
    [size_ts,~] = size(ts);
    [size_ps,~] = size(ps);
    ts_new = zeros(size_ts,1);
    
    ts_new(1) = ts(1);
    for co = 2 : size_ts
        ts_new(co) = ts(co) - ts(co-1);
    end 
    ts_d = zeros(size_ts, 2);
    for b = 1:size_ts
        ts_d(b,2) = ts_new(b);
    end
    
    % generate matrix of coefficients 3 splines = 24 unknowns 
    C_mid = sym('c' , [8,size_ts]);
    % Generate a matrix of qs for each differential in the mid points
    q = sym('qs' , [7 , 2*size_ps]);
    %generate a matrix for the difference between the differential in each
    %mid point
    diff = sym('d', [ 6 , size_ps]);
    % for loop to calculate each of the differentials per mid point note
    % that each point for minim snao has to be differentiated to the order
    % of 6 wrt t 
    full_pt = sym('pts' , [7 , 2*size_ts]);
    for i = 1:(size_ts)
        for cl = 1:2
            D7_new = subs(D7 , t ,ts_d(i,cl));
            if cl == 1
                full_pt(:,2*i-1) = D7_new  * C_mid(:,i);
            else    
                full_pt(:,2*i) = D7_new  * C_mid(:,i);
            end 
        end
    end 
    
    eqs_b = sym('eq_b', [2*size_ps,1]);
    [~ , full_pt_cols] = size(full_pt);
    
    for diff_c = 1 : ((full_pt_cols-2)/2)
        diff(:,diff_c) = full_pt(2:7,2*diff_c+1) - full_pt(2:7,2*diff_c-1+1);
        eqs_b(2*diff_c-1, 1) = full_pt(1,2*diff_c+1-1);
        eqs_b(2*diff_c, 1) = full_pt(1,2*diff_c+1);
    end 
    [rows_diff, cols_diff] = size(diff);
    % set mid  equations to 0 a vector 
    eqs_m = sym('eq_b', [rows_diff,cols_diff]);
    % finding the equations of the mid point
    for eqs_m_c = 1:cols_diff
        for  m = 1 : rows_diff
            eqs_m(m,eqs_m_c) = diff(m,eqs_m_c) == 0;
        end 
    end

    for k = 1: (size_ps)
        eqs_b(2*k) = eqs_b(2*k) - ps(k) == 0 ;
        eqs_b(2*k-1) = eqs_b(2*k-1)-ps(k) == 0 ;
    end

 % solve for th begining using D4 homogenous boundaries
    [size_boundary ,~] = size(boundary);
    eqs_h = sym('eq_h', [(size_boundary)/2,2]);
    % first spline
    eqs_h(:,1) = full_pt(1:4,1) - boundary(1:4) == 0;
    eqs_h(:,2) = full_pt(1:4,end) - boundary(5:8) == 0;
    % putting all the eqs_h into vector
    [rows_h, cols_h] = size(eqs_h);
    eqs_h_v = sym( 'eqs_h_v' , [rows_h * cols_h , 1]);
    for n = 1 : cols_h
        l = rows_h * n;
        eqs_h_v(l-(rows_h-1):l,1) = eqs_h(1:rows_h,n);
    end 
    
    % putting all the eqs_m into vector
    [rows_m, cols_m] = size(eqs_m);
    eqs_m_v = sym( 'eqs_m_v' , [rows_m * cols_m , 1]);  
    
    for o = 1 : cols_m
        l = rows_m * o;
        eqs_m_v(l-(rows_m-1):l,1) = eqs_m(1:rows_m,o);
    end 
    disp('all eqs')
    disp(full_pt)
    disp('boundary for waypoints')
    disp(eqs_b);
    disp('waypoint eqs')
    disp(eqs_m);
    disp(eqs_m_v);
    disp('initial boundary conditions')
    disp(eqs_h);
    disp(eqs_h_v);
% solve for all coefficients Cs using LU factorization    
     all_eqs = [eqs_h_v; eqs_b; eqs_m_v];
     [alleqs_row, ~] = size(all_eqs);
     all_eqs_r = reshape(all_eqs , [1,alleqs_row]);
     [C_mid_row, C_mid_cols] = size(all_eqs);
     C_mid_r = reshape(C_mid, [1,C_mid_row*C_mid_cols]);
     [A,B] = equationsToMatrix(all_eqs_r, C_mid_r.');
     disp(all_eqs);
     sol = A\B;
     sol_i = double(sol);
     disp(sol_i);
     C_mid_i = subs(C_mid ,C_mid_r.',sol_i);
     C_mid_i = double(C_mid_i);
     C = C_mid_i;
end