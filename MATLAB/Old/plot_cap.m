load('Capacitances_g5_50.mat')

 %%
 
plot(Cap.five.L,Cap.five.C, 'bd', Cap.ten.L, Cap.ten.C, 'rd', Cap.twenty.L, Cap.twenty.C, 'md', Cap.fifty.L, Cap.fifty.C, 'cd')

legend('w = 5','w = 10','w = 20','w = 50');
xlabel('Finger Length [\mum]')
ylabel('Capacitance [F]')
%%
 coeffs_5 = polyfit(Cap.five.L, Cap.five.C, 1);
 xfit = linspace(0, Cap.five.L(end)+50, 50);
 yfit = polyval(coeffs_5, xfit);
 hold on;
 plot(xfit, yfit, 'b:', 'LineWidth', 1);
 grid on;

% Get value for C = 60fF:
x_five = ((60e-15)-coeffs_5(2))/coeffs_5(1);
plot(x_five,polyval(coeffs_5,x_five),'b*')

%%

coeffs_10 = polyfit(Cap.ten.L, Cap.ten.C, 1);
 xfit = linspace(0, Cap.ten.L(end)+50, 50);
 yfit = polyval(coeffs_10, xfit);
 hold on;
 plot(xfit, yfit, 'r:', 'LineWidth', 1);
 grid on;

% Get value for C = 60fF:
x_10 = ((60e-15)-coeffs_10(2))/coeffs_10(1);
plot(x_10,polyval(coeffs_10,x_10),'r*')

%%
coeffs_20 = polyfit(Cap.twenty.L, Cap.twenty.C, 1);
 xfit = linspace(0, Cap.twenty.L(end)+50, 50);
 yfit = polyval(coeffs_20, xfit);
 hold on;
 plot(xfit, yfit, 'm:', 'LineWidth', 1);
 grid on;

% Get value for C = 60fF:
x_20 = ((60e-15)-coeffs_20(2))/coeffs_20(1);
plot(x_20,polyval(coeffs_20,x_20),'m*')

%%
coeffs_50 = polyfit(Cap.fifty.L, Cap.fifty.C, 1);
 xfit = linspace(0, Cap.fifty.L(end)+10, 50);
 yfit = polyval(coeffs_50, xfit);
 hold on;
 plot(xfit, yfit, 'c:', 'LineWidth', 1);
 grid on;

% Get value for C = 60fF:
x_50 = ((60e-15)-coeffs_50(2))/coeffs_50(1);
plot(x_50,polyval(coeffs_50,x_50),'c*')

%%
yPos = 60e-15;
hold on
plot(get(gca,'xlim'), [yPos yPos], '--'); % Adapts to x limits of current axes
hold off

%% Cap VS Width
i = find(Cap.five.L == 50);
j = find(Cap.ten.L == 50);
k = find(Cap.twenty.L == 50);
l = find(Cap.fifty.L == 50);

Capacitances = [Cap.five.C(i) Cap.ten.C(j) Cap.twenty.C(k) Cap.fifty.C(l)]; 
figure
plot([5 10 20 50], Capacitances,'bs-', 'MarkerFaceColor', 'b', 'LineWidth', 2, 'MarkerSize', 8) 

xlabel('Finger Width [\mum]');
ylabel('Capacitance [F]');
title('L = 50 [\mum]');

%% Cap VS Separation
figure
x = [5:5:60];
plot(x, CapS5_60,'bs', 'MarkerFaceColor', 'b', 'LineWidth', 2, 'MarkerSize', 8)
xlabel('Pad Separation Distance [\mum]');
ylabel('Capacitance [F]');

y = CapS5_60'; 

% Parameter Vector: b(1) = a,  b(2) = b,  b(3) = c
yfit = @(b,x) b(1)./(x + b(2)) + b(3);  % Objective Function

CF = @(b) sum((y-yfit(b,x)).^2);        % Cost Function

b0 = [5e-12,0,3.5e-14];                      % Initial Parameter Estimates
[B, fv] = fminsearch(CF, b0);           % Estimate Parameters

hold on
plot(x,  B(1)./(x + B(2)) + B(3));

%% Cap VS Corner Radius

figure
x = [5 10 15 20 25 29];
plot(x, IBMCapR5_29,'bs-', 'MarkerFaceColor', 'b', 'LineWidth', 2, 'MarkerSize', 8)
xlabel('Corner Radius [\mum]');
ylabel('Capacitance [F]');