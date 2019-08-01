function wat_dem1

%Simulation of water networks by using the loop method and Newton-Raphson
%numerical method

%There are given the nodal consumptions, the characteristics of the pipes,
%head value of reference main head node, inflows

dat_dem_pb;
[Anp,Mlp,Mpl,Nnp,flows_i,N,P,loop_found,pipes_found,chord] = determine_flowsi_pb(RefHeadNodes,Cons,PipeConns,Inflows,R);
[nodal_heads,flows_new,h]=sim_demo_pb(Mlp,Mpl,Nnp,flows_i,R1,R2,R,RefHeadNodes,Cons,chord);
    
true_nodh(1,:)=nodal_heads';   
true_flow(1,:)=abs(flows_new(:,1)');
true_heads(1,:)=h';

   
   
  





