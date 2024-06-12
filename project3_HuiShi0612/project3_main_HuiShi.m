clear all
close all
clc

%% 1. Calculate the number of degrees of freedom N of the linkage by applying the Gr¨ubler criterion;
m = 6;
c1 = 7;
c2 = 0;
N = 3*(m-1)-2*c1-c2;
disp('dof N: ');
disp(N);

%% 2. Decompose the linkage into a base mechanism and a number of dyads;
% base mechanism : AB
% 2 dyads : RRR (BDC), RRP(EF)

%% 3. Define the position-difference vectors used to solve the kinematic analysis of the linkage;
% Lengths of the links in m
AB = 1.6;
BD = 2.1;             
CE = 5.2; 
DC = 1.9;
EF = 6.3;              
CA = 2.3; % Distance AC
AG = 6.3; % Distance AG
theta = deg2rad(180);   % Generalized coordinate (g.c.) [rad]
dtheta = -20;             % [rad/s]
ddtheta = 0;            % [rad/s^2]

% Definition of known and unknown position-difference vectors
z1 = AB;               
z2 = BD;               
z3 = DC;               
z4 = CA; %  z_1 - z_4 forms the first kinematic loop  
z5 = AG;
% z6 = GF; unknown
z7 = EF; % F to E
z8 = CE; % E to C % z_5 - z_8 and z_4 forms the second kinematic loop  
phi1 = theta;          
% phi2 = unknown;            
% phi3 = unknown;
phi4 = pi/2;
phi5 = pi;
phi6 = pi*(3/2);
% phi7 = unknown;
% phi8 = phi3; % phi_3 = unknown;

%% 4. Solve the complete kinematic analysis of the linkage (position, velocity and acceleration analysis) when the angle θ is equal to 180◦;
% 2 linearly independent loop closure euqations :
% z1+z2+z3+z4 = 0          (1)
% z5+z6+z7+z8+z4 = 0      (2)

%% position analysis
% solution of the first loop closure euqation
% z1*cos(phi1)+z2*cos(phi2)+z3*cos(phi3)+z4*cos(phi4) = 0
% z1*sin(phi1)+z2*sin(phi2)+z3*sin(phi3)+z4*sin(phi4) = 0
% phi2, phi3 = unknown

% z9 is vector between CB
xB = -1.6;
yB = 0;
xC = 0;
yC = -2.3;
z9 = sqrt((xC-xB)^2+(yC-yB)^2);
% z4^2 = z1^2+z9^2-2*z1*z9*cos(gamma19)
gamma19 = acos((z1^2+z9^2-z4^2)/(2*z1*z9));
disp('gamma19: ');
disp(gamma19);
% z3^2 = z2^2+z9^2-2*z2*z9*cos(gamma29)
gamma29 = acos((z2^2+z9^2-z3^2)/(2*z2*z9));
disp('gamma29: ');
disp(gamma29);
phi2 = phi1+(pi-gamma19-gamma29);
disp('phi2: ');
disp(phi2);

gamma49 = pi/2 - gamma19;
disp('gamma49: ');
disp(gamma49);
% z2^2 = z3^2+z9^2-2*z3*z9*cos(gamma39)
gamma39 = acos((z3^2+z9^2-z2^2)/(2*z3*z9));
disp('gamma39: ');
disp(gamma39);
phi3 = 2*pi-(pi/2-gamma49-gamma39);
disp('phi3: ');
disp(phi3);

% solution of the second loop closure euqation
% z5*cos(phi5)+z6*cos(phi6)+z7*cos(phi7)+z8*cos(phi8)+z4*cos(phi4) = 0
% z5*sin(phi5)+z6*sin(phi6)+z7*sin(phi7)+z8*sin(phi8)+z4*sin(phi4) = 0
% z6, phi7 unknown
phi8 = phi3;
% phi6 = pi*(3/2); cos(phi6)=0, sin(phi6)=-1
phi7 = acos((-z5*cos(phi5)-z8*cos(phi8)-z4*cos(phi4))/z7);
disp('phi7: ');
disp(phi7);

z6 = z5*sin(phi5)+z7*sin(phi7)+z8*sin(phi8)+z4*sin(phi4);
disp('z6: ');
disp(z6);

%% velocity analysis
% Velocity analysis of the first kinematic loop
dz1 = 0;
dz2 = 0;
dz3 = 0;
dz4 = 0;
dphi1 = dtheta;
% dphi2 unknown
% dphi3 unknown
dphi4 = 0;
% z1*cos(phi1)+z2*cos(phi2)+z3*cos(phi3)+z4*cos(phi4) = 0
% z1*sin(phi1)+z2*sin(phi2)+z3*sin(phi3)+z4*sin(phi4) = 0
% -z1*sin(phi1)*dphi1-z2*sin(phi2)*dphi2-z3*sin(phi3)*dphi3 = 0
% z1*cos(phi1)*dphi1+z2*cos(phi2)*dphi2+z3*cos(phi3)*dphi3 = 0
% dphi2 , dphi3 unknown

% Jacobian matrix
J1 = [-z2*sin(phi2) -z3*sin(phi3);
      z2*cos(phi2) z3*cos(phi3)];
% dx1 = [dphi2;
%     dphi3];
A1 = [-z1*sin(phi1);
    z1*cos(phi1)];
dq1 = dphi1;

dx1 = -inv(J1)*A1*dq1;
dphi2 = dx1(1,1);
dphi3 = dx1(2,1);
disp('dphi2: ');
disp(dphi2);
disp('dphi3: ');
disp(dphi3);

% Velocity analysis of the second kinematic loop
dz5 = 0;
% dz6 unknown
dz7 = 0;
dz8 = 0;
dphi5 = 0;
dphi6 = 0;
% dphi7 unknown
dphi8 = dphi3;
% z5*cos(phi5)+z6*cos(phi6)+z7*cos(phi7)+z8*cos(phi8)+z4*cos(phi4) = 0
% z5*sin(phi5)+z6*sin(phi6)+z7*sin(phi7)+z8*sin(phi8)+z4*sin(phi4) = 0
% dz6*cos(phi6)-z7*sin(phi7)*dphi7-z8*sin(phi8)*dphi8 = 0
% dz6*sin(phi6)+z7*cos(phi7)*dphi7+z8*cos(phi8)*dphi8 = 0
% dz6 , dphi7 unknown

% Jacobian matrix
J2 = [cos(phi6) -z7*sin(phi7);
      sin(phi6) z7*cos(phi7)];
% dx2 = [dz6;
%     dphi7];
A2 = [-z8*sin(phi8);
    z8*cos(phi8)];
dq2 = dphi8;  % dphi8 = dphi3 obtained from the velocity analysis of the first loop
dx2 = -inv(J2)*A2*dq2;
dz6 = dx2(1,1);
dphi7 = dx2(2,1);
disp('dz6: ');
disp(dz6);
disp('dphi7: ');
disp(dphi7);

%% acceleration analysis
% Acceleration analysis of the first kinematic loop
ddz1 = 0;
ddz2 = 0;
ddz3 = 0;
ddz4 = 0;
ddphi1 = 0; % velocity is constant, accel is 0
% ddphi2 unknown
% ddphi3 unknown
ddphi4 = 0;
% -z1*sin(phi1)*dphi1-z2*sin(phi2)*dphi2-z3*sin(phi3)*dphi3 = 0
% z1*cos(phi1)*dphi1+z2*cos(phi2)*dphi2+z3*cos(phi3)*dphi3 = 0
% -z1*cos(phi1)*dphi1^2 -z2*sin(phi2)*ddphi2-z2*cos(phi2)*dphi2^2 -z3*sin(phi3)*ddphi3-z3*cos(phi3)*dphi3^2 = 0
% -z1*sin(phi1)*dphi1^2 +z2*cos(phi2)*ddphi2-z2*sin(phi2)*dphi2^2 +z3*cos(phi3)*ddphi3-z3*sin(phi3)*dphi3^2 = 0
% ddphi2 , ddphi3 unknown
K1 = [-z2*sin(phi2) -z3*sin(phi3);
      z2*cos(phi2) z3*cos(phi3)];
% ddx1 = [ddphi2;
%     ddphi3];
W1 = [-z1*cos(phi1)*dphi1^2-z2*cos(phi2)*dphi2^2-z3*cos(phi3)*dphi3^2;
      -z1*sin(phi1)*dphi1^2-z2*sin(phi2)*dphi2^2-z3*sin(phi3)*dphi3^2];

ddx1 = -inv(K1)*W1;
ddphi2 = ddx1(1,1);
ddphi3 = ddx1(2,1);
disp('ddphi2: ');
disp(ddphi2);
disp('ddphi3: ');
disp(ddphi3);

% Acceleration analysis of the second kinematic loop
ddz5 = 0;
% ddz6 unknown
ddz7 = 0;
ddz8 = 0;
ddphi5 = 0;
ddphi6 = 0;
% ddphi7 unknown
ddphi8 = ddphi3; % ddphi3 obtained from the analysis of the first loop
% dz6*cos(phi6)-z7*sin(phi7)*dphi7-z8*sin(phi8)*dphi8 = 0
% dz6*sin(phi6)+z7*cos(phi7)*dphi7+z8*cos(phi8)*dphi8 = 0
% ddz6*cos(phi6)-z7*sin(phi7)*ddphi7-z7*cos(phi7)*dphi7^2-z8*sin(phi8)*ddphi8-z8*cos(phi8)*dphi8^2 = 0
% ddz6*sin(phi6)+z7*cos(phi7)*ddphi7-z7*sin(phi7)*dphi7^2 +z8*cos(phi8)*ddphi8-z8*sin(phi8)*dphi8^2 = 0
% ddz6 , ddphi7 unknown
K2 = [cos(phi6) -z7*sin(phi7);
      sin(phi6)  z7*cos(phi7)];
% ddx2 = [ddz6;
%         ddphi7];
W2 = [-z7*cos(phi7)*dphi7^2-z8*sin(phi8)*ddphi8-z8*cos(phi8)*dphi8^2;
    -z7*sin(phi7)*dphi7^2+z8*cos(phi8)*ddphi8-z8*sin(phi8)*dphi8^2];
ddx2 = -inv(K2)*W2;
ddz6 = ddx2(1,1);
ddphi7 = ddx2(2,1);
disp('ddz6: ');
disp(ddz6);
disp('ddphi7: ');
disp(ddphi7);

%% 5. Calculate the velocity and acceleration of the slider in F;
% z6 = F - G = [ xF - xG; yF - yG] = [z6*cos(phi6); z6*sin(phi6)] = [0;-z6]
% phi6 = pi*(3/2); cos(phi6)=0, sin(phi6)=-1
%[ dxF - dxG; dyF - dyG] = [0;-dz6]
dxG = 0;
dyG = 0;
dxF = dxG; % dxF = dxG = 0
dyF = dyG -dz6;
disp('velocity of the slider in F: ');
disp('dxF: ');
disp(dxF);
disp('dyF: ');
disp(dyF);

%[ ddxF - ddxG; ddyF - ddyG] = [0;-ddz6]
ddxG = 0;
ddyG = 0;
ddxF = ddxG; % ddxF = ddxG = 0
ddyF = ddyG -ddz6;
disp('acceleration of the slider in F: ');
disp('ddxF: ');
disp(ddxF);
disp('ddyF: ');
disp(ddyF);

%% 6. Calculate the first-order kinematic coefficient
% which relates the velocity of the slider in F and the velocity of the crank AB; 
% Jacobian matrix
J1 = [-z2*sin(phi2) -z3*sin(phi3);
      z2*cos(phi2) z3*cos(phi3)];
A1 = [-z1*sin(phi1);
    z1*cos(phi1)];
% dq1 = dphi1;
K1 = -inv(J1)*A1;
Kphi3_phi1 = K1(2,1);

% Jacobian matrix
J2 = [cos(phi6) -z7*sin(phi7);
      sin(phi6) z7*cos(phi7)];
A2 = [-z8*sin(phi8);
    z8*cos(phi8)];
% dq2 = dphi8;  % dphi8 = dphi3 obtained from the velocity analysis of the first loop
K2 = -inv(J2)*A2;
Kz6_phi8 = K2(1,1);
% dz6 = Kz6_phi8*phi8 = Kz6_phi8*phi3 = Kz6_phi8*Kphi3_phi1*phi1
Kz6_phi1 = Kz6_phi8*Kphi3_phi1;
disp('first-order kinematic coefficient which relates the velocity of the slider in F and the velocity of the crank AB: ');
disp('Kz6_phi1: ');
disp(Kz6_phi1);
KyF_phi1 = dyF/dphi1;
disp('KyF_phi1: ');
disp(KyF_phi1);
