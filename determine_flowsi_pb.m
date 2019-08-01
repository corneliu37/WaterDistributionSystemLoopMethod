function [Anp,Mlp,Mpl,Nnp,flows_i,N,P,loop_found,pipes_found,chord] = determine_flowsi_pb(RefHeadNodes,Conns,PipeConns,Inflows,R);

%This function uses Depth First search to calculate the below variables.

%This function determines the loop incidence matrix Mlp, the topological
%incidence matrix Anp, initial pipe flows flows_i, chord/co-tree pipes (chord)

%Nnp is a matrix which contains the shortest path between the main reference node and
%other nodes/fixed head nodes in the water network (i.e. by using the tree)



[m1,m2] = size(RefHeadNodes);
[n1,n2] = size(Conns);
[t1,t2] = size(PipeConns);
[r1,r2] = size(Inflows);

%depth search

for i=1:n1
  initial_field =0; 
  TEMP =0; 
  for j=1:t1   
     
     if i ==PipeConns(j,1)
          
          if initial_field ==0         
               
             initial_field =1;
             TEMP(1,1)=j;
             TEMP(1,2)=PipeConns(j,2);
             TEMP(1,3)=R(j,1);
             eval(['N',sprintf('%i',i),'=','TEMP;']);
           else     
             flag =0;
             [size_1,size_2]= size(TEMP);
             for t=1:size_1
                if (TEMP(t,3) >R(j,1))
                   TEMP(t+1:size_1+1,:)=TEMP(t:size_1,:);
                   TEMP(t,3)=R(j,1);
                   TEMP(t,2)=PipeConns(j,2);
                   TEMP(t,1)=j;
                   eval(['N',sprintf('%i',i),'=','TEMP;']);
                   flag =1;
                   break
                 end   
             end   
             if (t ==size_1)&(flag~=1)
                TEMP(t+1,1)=j;          
                TEMP(t+1,2)= PipeConns(j,2);
                TEMP(t+1,3)= R(j,1);
                eval(['N',sprintf('%i',i),'=','TEMP;']);
              end
           end   
      elseif i == PipeConns(j,2)   
        if initial_field ==0
          
         initial_field =1;  
         TEMP(1,1)=j;
         TEMP(1,2)=PipeConns(j,1);
         TEMP(1,3)=R(j,1); 
         eval(['N',sprintf('%i',i),'=','TEMP;']);

        else   
          flag=0; 
          [size_1,size_2]= size(TEMP);
          for t=1:size_1
             if (TEMP(t,3) >R(j,1))
                TEMP(t+1:size_1+1,:)=TEMP(t:size_1,:);
                TEMP(t,3)=R(j,1);
                TEMP(t,2)=PipeConns(j,1);
                TEMP(t,1)=j;
                flag=1;
                eval(['N',sprintf('%i',i),'=','TEMP;']);
                break
             end   
          end   
        
          if (t ==size_1)&(flag~=1)
             TEMP(t+1,1)=j;          
             TEMP(t+1,2)= PipeConns(j,1);
             TEMP(t+1,3)= R(j,1);
             eval(['N',sprintf('%i',i),'=','TEMP;']);
          end
        end  
      end   
  end 
end





%for i=1:n1
%   for j=1:r1
%      if (Conns(i,1) ~=Inflows(j,1))
%        (Cons(i,1 ~= isl_node)
         nod_curent = 64;
%         break
%      end   
%   end
%   break;
%end


mainNode = nod_curent;

for j=1:r1
   N(Inflows(j,1),4)=(-1)*Inflows(j,2);
end   

for i=1:n1
   N(i,1)=0;
   N(i,2)=0;
   N(i,3)=0;
   N(i,6)=0;
end
N(nod_curent,8)=1;

for i=1:t1
   P(i,1)=0;
   P(i,2)=0;
   P(i,3)=0;
   P(i,4)=0;
end


loop_contor=0;
main_node=0;     
while (main_node ~=1)
        

       m_temp_node =eval((['N',sprintf('%i',nod_curent)]));
       [size_1,size_2]=size(m_temp_node);
       
       for k=1:size_1
          if N(m_temp_node(k,2),1) ~=1 
             N(nod_curent,1)= 1;%visited current node 
             N(nod_curent,2)= m_temp_node(k,1);%pipe exists the current node 
             N(nod_curent,6)=N(nod_curent,6)+1;
             %N(m_temp_node(k,2),1)= 1;%visited current node 
             %N(m_temp_node(k,2),2)= m_temp_node(k,1);%pipe exists the current node 
             N(m_temp_node(k,2),8) = N(nod_curent,8)+1;%depth

             
             P(m_temp_node(k,1),1) =nod_curent;%entering node in pipe 
             P(m_temp_node(k,1),2)= m_temp_node(k,2);%exit node from the pipe 
             P(m_temp_node(k,1),4)= 1;%pipe in tree
             nod_curent = m_temp_node(k,2);%current node becomes exit node from the above pipe in the tree
             N(nod_curent,1)= 1;%current node 
             N(nod_curent,3)= m_temp_node(k,1);%pipe into the current node 
             break;
             
          elseif k<size_1
             if (P(m_temp_node(k,1),4)==0 )
                loop_contor=loop_contor+1;
                P(m_temp_node(k,1),4)=1;%chord obtained 
                
                   loops(loop_contor,1)= P(N(nod_curent,3),1);
                   loops(loop_contor,2)= nod_curent;
                   loops(loop_contor,3)= N(nod_curent,3);
                   loops(loop_contor,4)= m_temp_node(k,1);
                   loops(loop_contor,5)= m_temp_node(k,2);

             end   
                                       
          elseif k ==size_1
             
             if (P(m_temp_node(k,1),4)==0 )
                loop_contor=loop_contor+1;
                P(m_temp_node(k,1),4)=1; 
                loops(loop_contor,1)= P(N(nod_curent,3),1);
                loops(loop_contor,2)= nod_curent;
                loops(loop_contor,3)= N(nod_curent,3);
                loops(loop_contor,4)= m_temp_node(k,1);
                loops(loop_contor,5)= m_temp_node(k,2);
                
             end   
                         
              
             if N(nod_curent,4) >0
                   
                   flows_i(N(nod_curent,3),1)= Conns(nod_curent,2)+N(nod_curent,4);%4 -inflow-minus/outflow-plus + 5 - previous imbalance                         

                   if sign(flows_i(N(nod_curent,3),1))==1
                     flows_i(N(nod_curent,3),2) = P(N(nod_curent,3),1);                
                     flows_i(N(nod_curent,3),3) = nod_curent;
                     flows_i(N(nod_curent,3),5) =1;
                  else
                     flows_i(N(nod_curent,3),2) = nod_curent;
                     flows_i(N(nod_curent,3),3) = P(N(nod_curent,3),1); 
                     flows_i(N(nod_curent,3),5) =-1;
                   end   
   
                   N(P(N(nod_curent,3),1),4)= N(P(N(nod_curent,3),1),4)+flows_i(N(nod_curent,3),1);
   
              elseif N(nod_curent,4) <0
                   flows_i(N(nod_curent,3),1)= Conns(nod_curent,2)+N(nod_curent,4);%4 -inflow-minus/outflow-plus + 5 - previous imbalance                         


                   if sign(flows_i(N(nod_curent,3),1))==1
                     flows_i(N(nod_curent,3),2) = P(N(nod_curent,3),1);                
                     flows_i(N(nod_curent,3),3) = nod_curent;
                     flows_i(N(nod_curent,3),5) =1;
                  else
                     flows_i(N(nod_curent,3),2) = nod_curent;
                     flows_i(N(nod_curent,3),3) = P(N(nod_curent,3),1); 
                     flows_i(N(nod_curent,3),5) =-1;
                   end   
                   
                   N(P(N(nod_curent,3),1),4)= N(P(N(nod_curent,3),1),4)+flows_i(N(nod_curent,3),1);
               elseif N(nod_curent,4) ==0
                   flows_i(N(nod_curent,3),1)= Conns(nod_curent,2);%4 -inflow-minus/outflow-plus + 5 - previous imbalance                         


                     flows_i(N(nod_curent,3),2) = P(N(nod_curent,3),1);                
                     flows_i(N(nod_curent,3),3) = nod_curent;
                     flows_i(N(nod_curent,3),5) =1;
                   
                   N(P(N(nod_curent,3),1),4)= N(P(N(nod_curent,3),1),4)+flows_i(N(nod_curent,3),1);
               end   
               nod_curent = P(N(nod_curent,3),1);            
                   
           end   
        end   
        
       count =0;       
       if nod_curent == mainNode

          m_temp_node =eval((['N',sprintf('%i',nod_curent)]));
          [size_1,size_2]=size(m_temp_node);
          for i =1:size_1
             if N(m_temp_node(i,2),1)==1
                 count =count +1;                              
             end   
          end
          if count ==size_1
              main_node =1;      
          end   
       end              
   
          
 end     
 
[loop_contor,size_le]= size(loops);



[e1,e2]=size(flows_i);

if e1<t1
   flows_i(e1+1:t1,:)=0;
end   



%for i=1:t1
%  if flows_i(i,5)==0    
%     flows_i(i,1)=0;    
%     flows_i(i,2)= PipeConns(i,1);
%     flows_i(i,3)= PipeConns(i,2);
%     flows_i(i,5)=1;    

%  end    
%end   


index=0;      
for i=1:t1
    if flows_i(i,5)==0    
     index=index+1; 
     chord(index,1)=i; 
     flows_i(i,1)=0;    
     flows_i(i,2)= PipeConns(i,1);
     chord(index,2)=PipeConns(i,1);
     flows_i(i,3)= PipeConns(i,2);
     chord(index,3)=PipeConns(i,2);;
     flows_i(i,5)=1;    
   end    
end   
   
   
   
   
temp_N=N;
flows_i =abs(flows_i); 
loop_found(1:28,1:31)=0;





%flows_i

for i=1:loop_contor
   stopFlag=0;
   loop_found(i,1) = loops(i,4);   
   k=1;   
   while(stopFlag ~=1)
        node_curent = loops(i,5);
        if N(loops(i,2),8)< N(node_curent,8)
            nod_curent1=node_curent;
            while( N(loops(i,2),8) ~= N(nod_curent1,8) )
               k =k+1;
               loop_found(i,k) = N(nod_curent1,3);
               nod_curent1 = P(N(nod_curent1,3),1);
            end
         else
            nod_curent1=loops(i,2);
            while( N(nod_curent1,8) ~= N(node_curent,8) )
               k =k+1;
               loop_found(i,k) = N(nod_curent1,3);
               nod_curent1 = P(N(nod_curent1,3),1);
            end
         end   
            
       if (node_curent == nod_curent1)|(nod_curent1==loops(i,2))
          stopFlag =1;
       else
          
          if N(nod_curent1,8) == N(node_curent,8)
             node_curent1 = nod_curent1;
             node_curent2 = node_curent;
          elseif N(nod_curent1,8) == N(loops(i,2),8)
             node_curent1 = loops(i,2);
             node_curent2 = node_curent;
          end   
         
          t=0;
          temporary_found=0;
          while (node_curent1 ~= node_curent2)
             t=t+1;
             k=k+1;
             loop_found(i,k) = N(node_curent2,3);
             temporary_found(1,t) = N(node_curent1,3);
             node_curent1 = P(N(node_curent1,3),1);
             node_curent2 = P(N(node_curent2,3),1);
          end
          %          loop_found(i,:) = [loop_found(i,:) temporary_found];
          %loop_found
          %temporary_found
         
          [l1,l2]= size(loop_found(i,:));
          [l3,l4]= size(temporary_found);
          if (temporary_found ~=0) & (l4 >1)
            for index=1:fix(l4/2)           
              temp = temporary_found(1,index);
              temporary_found(1,index) = temporary_found(1,l4-index+1);
              temporary_found(1,l4-index+1) = temp;
            end   
          end   
          TEMP = loop_found(i,:);
          loop_found(i,1:l4)= temporary_found;
          loop_found(i,l4+1:l4+l2)=TEMP;
          stopFlag =1;
       end   
    end
end


%for i=1:loop_contor
%   loop_found(i,1)  = loops(i,3);
%   pipes_found = shortest_loop(loops(i,5),loops(i,1),Conns,PipeConns,flows_i,loops(i,2));
%   [a1,a2]=size(pipes_found);
%   loop_found(i,2:a2+1)= pipes_found;
%   loop_found(i,a2+2)  = loops(i,4);
%end

%loop_found
%loops


%[se1,se2]=size(loop_found);
%Pi(1:92,1)=0;
%for i=1:se1
%   for j=1:se2
%     if loop_found(i,j)~=0 
%        Pi(loop_found(i,j),1)=Pi(loop_found(i,j),1)+1;
%     end   
%   end   
%end   
%Pi




[size_1,size_2]=size(loop_found);



for i=1:size_1
%  matr_temp =eval((['L',sprintf('%i',i)]));
   matr_temp1 = loop_found(i,:)';
   
   for k=1:size_2
      if matr_temp1(k,1)==0
         matr_temp = matr_temp1(1:k-1,1);
         break;  
      elseif (matr_temp1(k,1)~=0)&(k==size_2)         
         matr_temp = matr_temp1(1:k,1);
      end   
   end
   
   [m,n] = size(matr_temp);
   signal=1;
   for j=1:m
     for k=1:92                
        if (matr_temp(j,1)==k)&(k~=65)&(k~=61)&(k~=62)&(k~=35)&(k~=34)&(k~=33)%this part has to be modified so that to work with any water network; however simple to be done/implemented 
          if j~=1 
             if ( (flows_i(k,3) == flows_i(matr_temp(j-1,1),2))&(signal==1) ) | ( (flows_i(k,2) == flows_i(matr_temp(j-1,1),3))&(signal==1) ) |  ( (flows_i(k,3) == flows_i(matr_temp(j-1,1),3))&(signal==0) ) | ( (flows_i(k,2) == flows_i(matr_temp(j-1,1),2))&(signal==0) ),...          
                Mlp(i,k)=1;
                 signal=1;
              else   
                 Mlp(i,k)=-1;
                 signal=0;
              end   
              break;
           else
                 Mlp(i,k)=1;
                 signal=1;
             
           end   
         end   
      end
   end 
end



Mpl = Mlp';
Anp=0;

%for nodal heads i'm using the shortest path from the tree not from the graph
[PipeConns1,real_position] = modified_pipeconns(PipeConns,chord);
pipes_found=zeros(65,24);

for i=1:n1
  if i ~= RefHeadNodes(1,1)
     [Nnp(i,:),pipes_find]=shortest_path(i,RefHeadNodes,Conns,PipeConns1,PipeConns,flows_i,real_position);
     [pf1,pf2]=size(pipes_find);
     pipes_found(i,1:pf2)=pipes_find;
  else
     Nnp(i,:)=0; 
     pipes_found(i,:)=0;
  end   
end   

%preparing later on for estimation
N= temp_N;
lost_val=P(:,2);
P(:,2)=P(:,1);
P(:,3)=lost_val;


%test


