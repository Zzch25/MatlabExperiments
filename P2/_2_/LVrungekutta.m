%Zachary Job

function LVrungekutta

%Cleanup
clear all;

%SOMAIN>>>>>>>>>>>>>>>>>>>>>>>>>
%VARS//////////////////////////|
h = 0.1; %increments
steps = 1500; %seconds from time 0

%The settings
%change below
%alpha_v = 1.0;
%beta_v = 0.1;
%gamma_v = 0.5;
%delta_v = 0.02;

%temporary variables to
%collect interval returns
intrvl_0A = 0;
intrvl_1A = 0;
intrvl_2A = 0;
intrvl_3A = 0;
intrvl_0B = 0;
intrvl_1B = 0;
intrvl_2B = 0;
intrvl_3B = 0;

%Temporary variables
i = 1;
tempA = 0;
tempB = 0;

%Result stores
xArrayA = zeros(steps);
xArrayB = zeros(steps);
yArray = zeros(steps);
%//////////////////////////////|

%initial populations and time
xArrayA(1) = 100;
xArrayB(1) = 10;
yArray(1) = 0;

%DRIVER////////////////////////|

disp([num2str(i), ': time = ', num2str(yArray(1)), ' stepSolA = ', num2str(xArrayA(1)), ' stepSolB = ', num2str(xArrayB(1))]);

for i = 1:(steps - 1)
	
	%Get intervals at the current step
    tempA = xArrayA(i);
    tempB = xArrayB(i);
	intrvl_0A = f_twA(tempA, tempB);
	intrvl_0B = f_twB(tempA, tempB);
	
	tempA = xArrayA(i) + ((intrvl_0A * h) / 2);
	tempB = xArrayB(i) + ((intrvl_0B * h) / 2);
	intrvl_1A = f_twA(tempA, tempB);
	intrvl_1B = f_twB(tempA, tempB);
	
	tempA = xArrayA(i) + ((intrvl_1A * h) / 2);
	tempB = xArrayB(i) + ((intrvl_1B * h) / 2);
	intrvl_2A = f_twA(tempA, tempB);
	intrvl_2B = f_twB(tempA, tempB);
	
	tempA = xArrayA(i) + (intrvl_2A * h);
	tempB = xArrayB(i) + (intrvl_2B * h);
	intrvl_3A = f_twA(tempA, tempB);
	intrvl_3B = f_twB(tempA, tempB);
	
	%Get solution at the current step
	xArrayA(i + 1) = xArrayA(i) + (h * ((intrvl_0A + 2*intrvl_1A + 2*intrvl_2A + intrvl_3A) / 6));
	xArrayB(i + 1) = xArrayB(i) + (h * ((intrvl_0B + 2*intrvl_1B + 2*intrvl_2B + intrvl_3B) / 6));
	yArray(i + 1) = yArray(i) + h;
	
	disp([num2str(i + 1), ': time = ', num2str(yArray(i + 1)), ' stepSolA = ', num2str(xArrayA(i + 1)), ' stepSolB = ', num2str(xArrayB(i + 1))]);
    
end

%Plot pre-exit

figure;

hold on;
plot(yArray,xArrayA,'-', 'Linewidth', 1, 'color', 'blue');
plot(yArray,xArrayB,'-', 'Linewidth', 1, 'color', 'red');
legend('LV_RK4');
xlabel('TIME');
ylabel('POPULATION');

figure;

plot(xArrayA,xArrayB,'-', 'Linewidth', 1, 'color', 'blue');
legend('LV_RK4_AVB');
xlabel('POPULATION_A');
ylabel('POPULATION_B');
%//////////////////////////////|
%EOMAIN<<<<<<<<<<<<<<<<<<<<<<<<<

%DEFINES///////////////////////|
function calcPopA = f_twA(popA, popB)

alpha_v = 1.0;
beta_v = 0.1;

calcPopA = ((alpha_v * popA) - (beta_v * popA * popB));

function calcPopB = f_twB(popA, popB)

gamma_v = 0.5;
delta_v = 0.02;

calcPopB = ((delta_v * popA * popB) - (gamma_v * popB));
%//////////////////////////////|