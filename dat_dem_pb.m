NumOfLoadNodes=60;
NumOfFixedNodes=5;

PipeConns=[64 1;1 2;2 3;3 4;4 5;4 6;7 6;8 7;9 8;10 9;11 10;12 11;13 12;14 13;15 14;16 15;17 16;18 17;19 18;20 19;21 17;22 21;23 22;24 23;25 24;26 25;27 24;...
      28 22;29 28;30 29;31 30;32 31;33 32;34 33;35 34;36 31;37 36;38 37;39 38;40 39;41 40;42 41;43 42;44 43;45 44;46 45;47 46;48 32;49 48;50 49;51 50;52 51;53 52;54 53;55 54;56 55;57 56;58 57;59 58;60 59;61 53;62 34;38 63;48 60;...
      4 65;60 49;53 58;30 55;53 13;13 52;15 11;11 19;19 12;20 8;18 10;21 54;21 28;28 54;29 55;36 45;45 31;47 42;43 37;41 43;44 47;1 26;23 16;27 9;5 3;3 26;55 57;63 64];

Length_P=[370 350 770 800 210 270 220 480 380 190 550 610 780 320 710 230 380 320 580 1060 310 270 430 250 260 730 720 550 210 147 120 1510 970 400 800 160 600 1770 3090 410 420 400 150 460 530 1220 600 300 350 710 225 310 590 650 300 430 330 250 200 180 360 400 2200 350 ,...
           440 360 740 420 330 630 520 540 900 660 610 390 280 300 180 340 390 670 1100 350 1470 630 720 700 590 2050 760 270];

Diameter_P=[0.381 0.225 0.225 0.225 0.125 0.225 0.225 0.300 0.225 0.225 0.225 0.225 0.225 0.225 0.250 0.250 0.250 0.168 0.168 0.175 0.250 0.200 0.300 0.300 0.300 0.300 0.200 0.300 0.300 0.300 0.300 0.225 0.300 0.300 0.200 0.225 0.225 0.225 0.356 0.225 0.225 0.150 0.150,...
      0.094 0.150 0.150 0.150 0.225 0.225 0.225 0.225 0.225 0.094 0.200 0.300 0.300  0.300 0.225 0.175 0.125 0.300 0.300 0.356 0.125 0.300 0.150 0.175 0.150 0.175 0.225 0.250 0.250 0.175 0.225 0.125 0.200 0.168 0.150 0.300 0.150 0.200 0.150 0.142 0.094 0.150 0.300,...
      0.250 0.142 0.125 0.150 0.117 0.381];

CHW_P=[50 110 110 110 60 160 160 158 159 145 145 145 80 119 90 80 80 120 120 80 70 145 145 85 85 118 145 229 127 145 145 96 165 165 140 80 60 47 46 80 80 145 116 170 145 139 145 135 171 110 110 90 80 158 145 145 145 158 115 60 80 165 100 60 170 105 115 90 127 104 70,...
       70 80 140 55 145 120 90 112 90 145 116 105 170 81 50 80 137 60 40 60 32];

%reference head node

RefHeadNodes=[64 144.77];
% Accuracy initialy set to 0 mH2O for all refrence nodes
RefHeadNodes(:,3)=0;


% additional reference nodes


AddRefHeadNodes=[ 7 ];
%AddRefHeadNodes=[];

%AddRefHeadNodes=[35;32;51;55;31;36;46;8;16;18;24;29;28;30];


%for i=1:64
%  if i~=64 
%     AddRefHeadNodes(i,1)=i;
%  else
%     AddRefHeadNodes(i,1)=i+1;
%  end   
%end   

% Accuracy initialy set to 0 mH2O for all additional refrence nodes
%AddRefHeadNodes(:,2)=0;



% Inflows: Inflows=[number_of_node inflow_to_this_node accuracy_of_meter]


Inflows=[61 65;62 47.83;65 31.00;64 45.00;63 34.00];

%inflows affected by errors
Inflows_err=[61 65;62 47.83;65 31.00;64 45.00;63 34.00];%51.30 27.70

%Inflows_err=[61 0;62 0;65 0;64 0;63 0];%51.30 27.70


% Accuracy initialy set to 0.0001 [m^3/s] for all Inflows

%Inflows=[64 222.83];%63 34.00
%inflows affected by errors
%Inflows_err=[64 222.83];

%Inflows(:,3)=0;
%a=0; %test to see the total inflows in the network 
%for i=1:5
%   a =a+Inflows(i,2);
%end   
%a




% additional reference flows

%RefFlow=[25 24 25;45 31 81;31 36 36];
%RefFlow=[32 48 48;31 32 32];
%RefFlow=[34 33 34];
%RefFlow=[7 8 8];
RefFlow=[ ];

% Accuracy initialy set to 0 m^3/s for all refrence flows
%RefFlow(:,4)=0;


% Consumptions: Cons=[number_of_node value_of_consumtion accuracy_of_meter variability_of_consumption]

Cons=[1 2.88;2 2.94;3 10.46;4 2.15;5 3.84;6 1.87;7 0.67;8 4.54;9 10.83;10 0.78;11 10.80;12 7.40;13 2.71;14 2.58;15 1.89;16 3.51;17 6.77;18 2.98;...
      19 1.10;20 2.95;21 2.13;22 2.36;23 8.03;24 2.73;25 0.16;26 5.68;27 1.74;28 0.65;29 1.92;30 4.52;31 2.35;32 1.64;33 2.09;34 6.77;35 4.85;...
      36 1.91;37 11.51;38 2.18;39 2.77;40 3.75;41 1.32;42 1.16;43 1.35;44 0.42;45 2.64;46 2.79;47 5.37;48 1.16;49 9.64;50 6.54;51 3.18;52 2.01;...
      53 8.51;54 1.73;55 0.47;56 0;57 8.71;58 0.5;59 0.35;60 0.34;61 0.26;62 7.95;63 0.58;64 0;65 2.46];

Cons_err=[1 2.88;2 2.94;3 10.46;4 2.15;5 3.84;6 10.87;7 0.67;8 4.54;9 10.83;10 0.78;11 10.80;12 7.40;13 2.71;14 2.58;15 1.89;16 3.51;17 6.77;18 2.98;...
      19 1.10;20 2.95;21 2.13;22 2.36;23 8.03;24 2.73;25 0.16;26 5.68;27 1.74;28 0.65;29 1.92;30 4.52;31 2.35;32 1.64;33 2.09;34 6.77;35 4.85;...
      36 1.91;37 11.51;38 2.18;39 2.77;40 3.75;41 1.32;42 1.16;43 1.35;44 0.42;45 2.64;46 2.79;47 5.37;48 1.16;49 9.64;50 6.54;51 3.18;52 2.01;...
      53 8.51;54 1.73;55 0.47;56 0;57 8.71;58 0.5;59 0.35;60 0.34;61 0.26;62 7.95;63 0.58;64 0;65 2.46];

%Cons(:,2) = Cons(:,2) +0.1*Cons(:,2);


%for i=1:65
%  if (i~=15)&(i~=64) 
%     Cons_err(i,2)=222.83/63;
%  end
%end 


%b=0;
%for i=1:65
%   b =b+Cons(i,2);/ test to see the total consumption 
%end   
%b;
% Accuracy initialy set to 0%
%Cons(:,3)=0;
%Cons(:,4)=0;

epsilon=1e-6;


Leakage=[];


LeakCov=[];


LeakLev=[]; %0.002:0.003:0.029]


GrossErrorsHead=[]; %[35.8 1];
GrossErrorsFlow=[];


NumOfState=NumOfLoadNodes+2*NumOfFixedNodes;

R=( (10.7*Length_P)./  ( (CHW_P.^(1.852)).*(Diameter_P.^(4.87)) ))';



[v_1,v_2]=size(Length_P);
A =eye(v_2);
for i=1:v_2
  R1(i,i)=A(i,i)*R(i,1); 
end



R2=1.85*R1;

% Reservoirs nodes
Res=[64 63];


