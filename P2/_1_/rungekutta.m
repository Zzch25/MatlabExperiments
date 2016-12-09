%Zachary Job

function rungekutta

%VARS//////////////////////////|
time = 0;
timeStep = 0.5;
stepSol = 0.5;
steps = 6;

intrvl_0 = 0;
intrvl_1 = 0;
intrvl_2 = 0;
intrvl_3 = 0;

i = 0;

xArray = zeros(steps);
yArray = zeros(steps);
%//////////////////////////////|

disp(['0: time = ', num2str(time), ' stepSol = ', num2str(stepSol)]);
xArray(1) = stepSol;
yArray(1) = time;

%DRIVER////////////////////////|
for i = 1:(steps - 1)
	
	%Get intervals
	intrvl_0 = timeStep * f_tw(time, stepSol);
	intrvl_1 = timeStep * f_tw(time + timeStep / 2, stepSol + (intrvl_0 / 2));
	intrvl_2 = timeStep * f_tw(time + timeStep / 2, stepSol + (intrvl_1 / 2));
	intrvl_3 = timeStep * f_tw(time + timeStep, stepSol + intrvl_2);
	
	%Get solution
	stepSol = stepSol + (intrvl_0 + 2*intrvl_1 + 2*intrvl_2 + intrvl_3) / 6;
	time = time + timeStep;
	
	disp([num2str(i), ': time = ', num2str(time), ' stepSol = ', num2str(stepSol)]);
	xArray(i + 1) = stepSol;
	yArray(i + 1) = time;
    
end

hold on;
plot(yArray,xArray,'*-', 'Linewidth', 1.5, 'color', 'blue');
legend('Runge Kutta Test');
xlabel('x');
ylabel('y');
%//////////////////////////////|

%DEFINES///////////////////////|
function intrvlCalc = f_tw(time,var)
intrvlCalc = var * time; %arbitrary
%//////////////////////////////|