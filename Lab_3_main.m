clear 
clc
close all

%% Constants 
% Base
K_g = 33.3;
K_m = 0.0401; % [Nm/amp]
R_m = 19.2;   % [ohms]
K_1=[10 20 5 10 10 10];         % [K_p] btwn -2 and 50 Neg values mean unstable 
K_3=[0 0 0 1 -1 -0.5];         % [K_d] btwn -1.5 and 1.5 Neg values mean unstable 
% Rigid Arm 
J_hub = 0.0005;          % [kgm^2]
J_extra = 0.2*(.2794^2); % [kgm^2]
J_load = 0.0015;         % [kgm^2]

J_total= J_hub+J_load+J_extra;

% Flexible Link 
L = 0.45;       % [m]
M_arm = 0.06;   % [kg]
J_arm = 0.004;  % [kgm^2] 
M_tip = 0.05;   % [kg]
J_M = 0.01;     % [kgm^2]
fc = 1.8;       % [Hz]
J_L = J_arm+J_M;
K_arm = (2*pi*fc)^2*(J_L); 


%% Closed Loop System
for n=1:6
d0 = (K_1(n).*K_g.*K_m)./(J_total.*R_m);
d1 = (((K_g.^2).*(K_m.^2)+K_3(n).*K_g.*K_m)./(J_total.*R_m));
d2 = 1; 
n1 = d0;
num = n1;
den = [d2 d1 d0];
sysTF = tf(num,den);
%% Step Response
t= 0:0.01:4;
u=max(0,min(t-1,1));
%lsim(sysTF,u,t)
[x,t] = step(sysTF);


figure(n);
plot(t,x-0.5);
figure(n+6);
plot(t,x-1);
end
