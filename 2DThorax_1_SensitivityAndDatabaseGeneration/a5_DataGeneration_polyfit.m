clear all;
%inputs
R2slopefitdeg = 5;      
R2yinterceptfitdeg = 4; 
R3slopefitdeg = 5;      
R3yinterceptfitdeg =4; 

delimiterIn = ' ';
rarray = 0.01:0.01:0.05;
rarray = rarray';
darray = 0.08:0.02:0.2;

for j=1:7
    i=6+2*j;
    myfilename2 = sprintf('R2LHS_d%d.txt',i);
    relation2temp = importdata(myfilename2, delimiterIn);
    relation2 = (relation2temp(2:6)).^(1/1.9844);

    myfilename3 = sprintf('R3LHS_d%d.txt',i);
    relation3temp = importdata(myfilename3, delimiterIn);
    relation3 = (relation3temp(2:6)).^(1/2);

 rarrayW0 = [0; rarray];
 relation2W0 = [0; relation2];
 relation3W0 = [0; relation3];

    
    FR2 = @(R2x,rarrayW0) R2x(1)*rarrayW0 + R2x(2);
    FR3 = @(R3x,rarrayW0) R3x(1)*rarrayW0 + R3x(2);

    R2x0 = [0,0];
    R2x=lsqcurvefit(FR2,R2x0,rarrayW0,relation2W0);
    
    R3x0 = [0,0];
    R3x=lsqcurvefit(FR3,R3x0,rarrayW0,relation3W0);

    R2slope(j,1) = R2x(1);
    R2yintercept(j,1) = R2x(2);

    R3slope(j,1) = R3x(1);
    R3yintercept(j,1) = R3x(2);
end

R2slopep=polyfit(darray,R2slope,R2slopefitdeg);
R2yinterceptp=polyfit(darray,R2yintercept,R2yinterceptfitdeg);
R3slopep=polyfit(darray,R3slope,R3slopefitdeg);
R3yinterceptp=polyfit(darray,R3yintercept,R3yinterceptfitdeg);

x1 = linspace(0.08,0.2);

figure('Name', '(R2) slope')
plot(darray, R2slope','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('slope (R2)');
R2slopey1 = polyval(R2slopep,x1);
hold on;
plot(x1,R2slopey1, 'r--', 'DisplayName',['degree ' num2str(R2slopefitdeg) ' fit']);
legend

figure('Name', '(R2) intercept')
plot(darray, R2yintercept','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('intercept (R2)');
R2yintercepty1 = polyval(R2yinterceptp,x1);
hold on;
plot(x1,R2yintercepty1, 'r--', 'DisplayName',['degree ' num2str(R2yinterceptfitdeg) ' fit']);
legend

figure('Name', '(R3) slope')
plot(darray, R3slope','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('slope (R3)');
R3slopey1 = polyval(R3slopep,x1);
hold on;
plot(x1,R3slopey1, 'r--', 'DisplayName',['degree ' num2str(R3slopefitdeg) ' fit']);
legend

figure('Name', '(R3) intercept')
plot(darray, R3yintercept','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('intercept (R3)');
R3yintercepty1 = polyval(R3yinterceptp,x1);
hold on;
plot(x1,R3yintercepty1, 'r--', 'DisplayName',['degree ' num2str(R3yinterceptfitdeg) ' fit']);
legend

writematrix(R2slopep, 'a5_R2slopep_5fit.txt');
writematrix(R2yinterceptp, 'a5_R2yinterceptp_4fit.txt');
writematrix(R3slopep, 'a5_R3slopep_5fit.txt');
writematrix(R3yinterceptp, 'a5_R3yinterceptp_4fit.txt');