function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
% x = [rand*5,rand*5,rand*5];
% y = [rand*5,rand*5,rand*5];
% P1 = [x;y]';
% 
% x = [rand*5,rand*5,rand*5];
% y = [rand*5,rand*5,rand*5];
% P2 = [x;y]';
% 
% plot([P1(1,1), P1(2,1),P1(3,1),P1(1,1)],[P1(1,2), P1(2,2),P1(3,2),P1(1,2)]);
% hold on;
% plot([P2(1,1), P2(2,1),P2(3,1),P2(1,1)],[P2(1,2), P2(2,2),P2(3,2),P2(1,2)]);
% % flag = triangle_intersection(P1, P2);
check1 = zeros (3,3);
check2 = zeros (3,3);
check3 = zeros (1,3);

s =0;
while s<=2 
   
    for p = 1:3
        if abs(sum(check1(1:3,p)) - sum(check2(1:3,p))) == 3 
           check3(p) = 0;
        else 
           check3(p) = 1;
        end
    end
    if min(check3(:)) == 0
        flag = false;
        return;
        %s = 3;
    elseif s == 2 %&& max(check3(:)) == 1
        flag = true;
        return;        
        %s = 3;
    end 
    
    
        if s == 0
            a = P1;
            b = P2;
        elseif s == 1
            a = P2;
            b = P1;
        end 
        if s <2
            for i = 1:3

                if i == 3
                    v = 1;
                else 
                    v = i+1;
                end 
                l = 6 - (i+v);
                if (a(i,1)- a(v,1)) == 0 

                    if a(l,1) <= a(i,1) 
                        check1(1+(i-1)*3) = 0;
                        check1(2+(i-1)*3) = 0;
                        check1(3+(i-1)*3) = 0;
                    else                 
                        check1(1+(i-1)*3) = 1;
                        check1(2+(i-1)*3) = 1;
                        check1(3+(i-1)*3) = 1;
                    end
                    for j = 1:3
                        if b(j,1) <= a(i,1)                       
                            check2(j+(i-1)*3) = 0;
                        else 

                            check2(j+(i-1)*3) = 1;          
                        end
                    end
                %end

                elseif (a(i,2)- a(v,2)) == 0 
                    if a(l,2) <= a(i,2) 
                        check1(1+(i-1)*3) = 0;
                        check1(2+(i-1)*3) = 0;
                        check1(3+(i-1)*3) = 0;
                    else                 
                        check1(1+(i-1)*3) = 1;
                        check1(2+(i-1)*3) = 1;
                        check1(3+(i-1)*3) = 1;
                    end
                    for j = 1:3
                        if b(j,2) <= a(i,2)                       
                            check2(j+(i-1)*3) = 0;   
                        else 

                            check2(j+(i-1)*3) = 1;
                        end
                    end 
                %end
                elseif (a(i,2)- a(v,2)) ~= 0 && (a(i,1)- a(v,1)) ~= 0
                    m= (a(i,2)-a(v,2))/(a(i,1)-a(v,1));
                    y  = m * (a(l,1)-a(i,1)) + a(i,2);
                    if y <=  (a(l,2))
                        check1(1+(i-1)*3) = 0;
                        check1(2+(i-1)*3) = 0;
                        check1(3+(i-1)*3) = 0;  
                    else 
                        check1(1+(i-1)*3) = 1;
                        check1(2+(i-1)*3) = 1;
                        check1(3+(i-1)*3) = 1;
                    end 
                    for j = 1:3
                        y  = m * (b(j,1)-a(i,1)) + a(i,2);
                        if y <= b(j,2)
                            check2(j+(i-1)*3) = 0;
%                             check2(2+(i-1)*3) = 0;
%                             check2(3+(i-1)*3) = 0;
                        else
                              check2(j+(i-1)*3) = 1;
%                             check2(2+(i-1)*3) = 1;
%                             check2(3+(i-1)*3) = 1;
                        end
                    end
                end
            end
        end
        s = s+1;
end



end

                        
                    
                
                    
                
                   
% *******************************************************************

