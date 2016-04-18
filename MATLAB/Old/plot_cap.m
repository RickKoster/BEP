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