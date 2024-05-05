clear all;
delimiterIn = ' ';
rarray = 0.05:0.05:0.25;
rarray = rarray';
darray = 0.45:0.05:0.8;
darray = darray';

%input average alpha for R2
alphaAve = 3.022375;

for j=1:8
    i=40+5*j;
    myfilename2 = sprintf('R2LHS_d%d.txt',i);
    relation2temp = importdata(myfilename2, delimiterIn);
    relation2 = (relation2temp(2:6)).^(1/alphaAve);


    myfilename3 = sprintf('R3LHS_d%d.txt',i);
    relation3temp = importdata(myfilename3, delimiterIn);
    relation3 = relation3temp(2:6).^(1/3);

rarrayW0 = [0; rarray];
relation2W0 = [0; relation2];
relation3W0 = [0; relation3];

 plot(rarrayW0,relation2W0,'-o', 'DisplayName',['Depth = ' num2str(i/100)]);
 xlabel('radius');
 ylabel('LHS of (R2)');
 hold on; 

    F = @(R2x,rarrayW0) R2x(1)*rarrayW0 + R2x(2);

    R2x0 = [0,0];
    R2x=lsqcurvefit(F,R2x0,rarrayW0,relation2W0);
    
    R3x0 = [0,0];
    R3x=lsqcurvefit(F,R3x0,rarrayW0,relation3W0);

    R2slope(j,1) = R2x(1);
    R2yintercept(j,1) = R2x(2);

    R3slope(j,1) = R3x(1);
    R3yintercept(j,1) = R3x(2);
end

figure('Name', '(R2) slope')
plot(darray, R2slope','b-o');
xlabel('depth');
ylabel('slope (R2)');

figure('Name', '(R2) intercept')
plot(darray, R2yintercept','b-o');
xlabel('depth');
ylabel('intercept (R2)');

figure('Name', '(R3) slope')
plot(darray, R3slope','b-o');
xlabel('depth');
ylabel('slope (R3)');

figure('Name', '(R3) intercept')
plot(darray, R3yintercept','b-o');
xlabel('depth');
ylabel('intercept (R3)');