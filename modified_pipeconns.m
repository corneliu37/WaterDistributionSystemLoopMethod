function [PipeConns,real_position] = modified_pipeconns(PipeConns,chord);



[c1,c2]=size(chord);
real_position =[];
[p1,p2]=size(PipeConns);

for i=1:p1
   real_position(i,1)=i;
end


for i=1:c1
   [p1,p2]=size(PipeConns);
   real_position= [real_position(1:chord(i,1)-1,:) ; real_position(chord(i,1)+1:p1,:)];
   PipeConns =[PipeConns(1:chord(i,1)-1,:) ; PipeConns(chord(i,1)+1:p1,:)];
   chord(:,1)=chord(:,1)-1;   
end   

