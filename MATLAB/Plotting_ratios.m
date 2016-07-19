%% Intitialization

XFingerWidth = [5 10 20];
XFingerWidth10 = [5 10];
XSlotSize = [10 20 50 100 200];
XCornerRadius = [1 2 5 8 10];
XPadSep = [5 10 20 50];
XPadWidth = [300 350 400 450 500];
XIBMCornerRadius = [5 10 15 20 25 29];
XIBMSlotSize = [500 533 566 600 700 800];
XIBMPadSep60fF = [5 10 20 50];


X = XIBMPadSep60fF;
XAxisLabel = 'Pad Separation [\mum]';
Y = IBMPadSep60fF;
%%
figure
clm1 = 'bs-';   clm2 = 'gd-';   clm3 = 'mp-';   clm4 = 'rh-';
prop1 = 'MarkerFaceColor';
col1 = 'b';     col2 = 'g';     col3 = 'm';     col4 = 'r'; 

prop2 = 'LineWidth';
val2 = 2; 

prop3 = 'MarkerSize';
val3 = 8;

PmaSpec = ['''' clm1 ''',''' prop1 ''',''' col1 ''',''' prop2 ''', val2 ,''' prop3 ''', val3 '];
PmsSpec = ['''' clm2 ''',''' prop1 ''',''' col2 ''',''' prop2 ''', val2 ,''' prop3 ''', val3 '];
PsaSpec = ['''' clm3 ''',''' prop1 ''',''' col3 ''',''' prop2 ''', val2 ,''' prop3 ''', val3 '];
PallSpec = ['''' clm4 ''',''' prop1 ''',''' col4 ''',''' prop2 ''', val2 ,''' prop3 ''', val3 ']; 

hold on
eval(['plot(X,Y(:,1),' PmaSpec ')']);
eval(['plot(X,Y(:,2),' PmsSpec ')']);
eval(['plot(X,Y(:,3),' PsaSpec ')']);
eval(['plot(X,Y(:,4),' PallSpec ')']);


legend('P ma', 'P ms', 'P sa', 'P all', 'Location', 'bestoutside');
legend off
xlabel(XAxisLabel);
ylabel('Participation ratio'); 
hold off