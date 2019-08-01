function [vector,pipes_found]= shortest_path(N2,RefHeadNodes,Cons,PipeConns,PipeConns1,flows_i,real_position)



%This function calculated shortest path between two nodes in the spanning
%tree


L1(1,1) = RefHeadNodes(1,1);
[m1,n1] =size(Cons);
[m2,n2] =size(PipeConns); 
[m3,n3]=size(PipeConns1);%when i'm using the shortest path from the network m3 = m2
touch(1:m1,1)=0;

contor =1;
stopFlag =0;   
first_time =0;
touch(RefHeadNodes(1,1),1)=1;



while (stopFlag ~=1)   
   
   if first_time ==0
     P1 = 1;
     K = L1(P1,1);
     first_time =1;
     i=0;
   else
     P1 =P1+1;
     K = L1(P1,1);
     i=0;
     
   end   
   while (i ~= m2)   
      i =i+1;
      if (PipeConns(i,1) == K)
         J = PipeConns(i,2);
         if touch(PipeConns(i,2),1) ==0
           touch(PipeConns(i,2),1) =1;
           contor = contor+1;
           L1(contor,1)= PipeConns(i,2);
           L2(J,1) = K;                
           L3(J,1) = i;
           if  J==N2
             stopFlag =1;
             break ;
           end  
         elseif  J==N2
           stopFlag =1;
           break ;
         end   
       elseif (PipeConns(i,2) ==K)
         J = PipeConns(i,1);
         if touch(PipeConns(i,1),1) ==0
           touch(PipeConns(i,1),1) =1;
           contor = contor+1;
           L1(contor,1)= PipeConns(i,1);
           L2(J,1) = K;
           L3(J,1) = i;
           if  J==N2
             stopFlag =1;
             break ;
           end  
          elseif J==N2 
           stopFlag =1;   
           break;
         end   
       end  
   
       %if J == N2
       %   stopFlag =1;
       %   break;
       %end
     end   
     
end


stopFlag =0;
K=N2;



contor =0;
while (stopFlag ~=1)
      contor = contor +1;

      pipes_found(1,contor) =L3(K,1);
   
      K = L2(K,1);   
      if K == RefHeadNodes(1,1)
        stopFlag =1;
      end
       
end    



[t1,t2] = size(pipes_found);
vector(1,1:m3)=0;


if m2 ~= m3
    for j=1:t2
       pipes_found(1,j)=real_position(pipes_found(1,j),1);
    end   
end   



%   pipes_found
for j=t2:-1:1  
     cur_elem = pipes_found(1,j);
     if j==t2
       if flows_i(cur_elem,2)==RefHeadNodes(1,1)                
             vector(1,cur_elem) =1;
       else
             vector(1,cur_elem) =-1;
       end   
     else
       if (flows_i(cur_elem,2)==flows_i(pipes_found(1,j+1),2))|(flows_i(cur_elem,2)==flows_i(pipes_found(1,j+1),3))
           vector(1,cur_elem) =1;
       else
           vector(1,cur_elem) =-1;
       end   
     end     
end
     
[s1,s2]=size(pipes_found);     
for i=1:fix(s2/2)
  temp = pipes_found(1,s2-i+1);
  pipes_found(1,s2-i+1)=pipes_found(1,i);
  pipes_found(1,i)=temp;
end   
   
% vector





