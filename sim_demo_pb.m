function [nodal_heads,flows_new,h]=sim_demo_pb(Mlp,Mpl,Nnp,flows_i,R1,R2,R,RefHeadNodes,Conns,chord)
     
     
%Simulation of water networks by using the loop method and Newton-Raphson
%numerical method



%for convergence display


residual_main=[

   0.0060
    0.0023
    0.0010
   -0.0053
    0.0011
   -0.0039
    0.0015
    0.0040
   -0.0137
    0.0006
    0.0011
    0.0112
   -0.0001
   -0.0012
   -0.0064
   -0.0020
    0.0194
   -0.0011
    0.0283
    0.0010
    0.0034
    0.0075
   -0.0077
   -0.0024
    0.0010
   -0.0002
    0.0056
   -0.0015];


stopFlag =1;
count = 0;
flows_i(:,1)=flows_i(:,1).*10^(-3);
flows_old(:,1) = flows_i(:,1);
[l,p]= size(Mlp);
for i=1:l      
    cor_flows_old(i,1) = 0;
end   

flows_new(:,1) =flows_old(:,1);
[v_1,v_2]=size(flows_old);
contor= 0;

[n,p] = size(Nnp);
T= Mlp*R1;
t0=clock;
flows_new(76,1)=0.0001;%chord for loop no. 1 with initial flow zero-> to be able to use spaugment function


for i=1:92
   ONE(i,i)=1;
end   

h = R.*(abs(flows_new(:,1)).^1.85).*sign(flows_new(:,1));
h_old = R.*(abs(flows_new(:,1)).^1.85).*sign(flows_new(:,1));

for i=1:n
   nodal_heads(i,1) = RefHeadNodes(1,2) - Nnp(i,:)*h;
end  

%for i=1:28
%   t12_old(i,1) =nodal_heads(chord(i,3),1)-nodal_heads(chord(i,2),1);       
%end  

%fi = flows_i;
%save data Mlp fi R;
%exit(1);

 while (stopFlag~=0)
   
  
    
        
  
      contor = contor+1;
   
   
	  h = R.*(abs(flows_new(:,1)).^1.85).*sign(flows_new(:,1));
   	  for i=1:n
      	  nodal_heads(i,1) = RefHeadNodes(1,2) - Nnp(i,:)*h;
	  end  
    
  
                            
	  for i=1:28
   	    t12(i,1) = nodal_heads(chord(i,2),1)-nodal_heads(chord(i,3),1);       
      end   
        
      for i=1:28
       
           flows_new(chord(i,1),1)= (sign(t12(i,1))*( (abs(t12(i,1))/R(chord(i,1),1))^(1/1.85) )+flows_new(chord(i,1),1))/2;

      end   
        
     for i=1:v_1 
   	    A(i,i)=R2(i,i)*(abs(flows_new(i,1))^0.85); 
	  end
        
           
      %Mlp*ONE*h;
      EX = A*Mpl;
        
      h_old=h;
      t12_old=t12; 
        
      jacob = Mlp*EX; 
        
        
      cor_flows_new = cor_flows_old - inv(jacob)*Mlp*ONE*h;  
      %format longcle
      cor_flows_new'
      count=0;
      for i=1:l
         if abs( abs(cor_flows_new(i,1))-abs(cor_flows_old(i,1)) ) < (10^(-9))
            count = count+1;
         end
      end 
    
    
    dddd
    % for convergence display
       residual =cor_flows_new; 
       %for i=1:l   
       %   dif_res(i,1)=abs(abs(residual_main(i,1)) - abs(residual(i,1)));
       %end   
       %max_res = dif_res(1,1);
       %for i=1:l
       %   if max_res <dif_res(i,1)
       %      max_res =dif_res(i,1);
       %   end   
       %end 
       %grh(contor,1) = max_res;
       %contor
       if count ==l
       %if contor==20
       stopFlag =0; 
       flows_new = flows_old + Mpl*cor_flows_new;
        %throw out the pipes that are not in any loops to minimize Mlp
       
     else
       cor_flows_old = cor_flows_new;
       flows_new = flows_old + Mpl*cor_flows_old;
     end
end


time =etime(clock,t0);
contor
for i=1:p
   if sign(flows_new(i,1)) ==1
      flows_new(i,2) = flows_i(i,2);
      flows_new(i,3) = flows_i(i,3);
   else
      flows_new(i,2) = flows_i(i,3);
      flows_new(i,3) = flows_i(i,2);
   end   
end

flows_i;
flows_new;

h = R.*(abs(flows_new(:,1)).^1.85).*sign(flows_new(:,1));

for i=1:n
 nodal_heads(i,1) = RefHeadNodes(1,2) - Nnp(i,:)*h;
end     

%-jacob*cor_flows_new

h;
nodal_heads
Mlp*h;


time;


 








