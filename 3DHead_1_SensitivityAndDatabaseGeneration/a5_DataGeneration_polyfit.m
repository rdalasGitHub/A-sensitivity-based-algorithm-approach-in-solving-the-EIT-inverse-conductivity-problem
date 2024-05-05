%inputs
R2slopefitdeg = 3;      
R3slopefitdeg = 2;      
%input average alpha for R2
alphaAve = 3.022375;

delimiterIn = ' ';
rarray = 0.05:0.05:0.25;
rarray = rarray';
darray = 0.45:0.05:0.8;

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

    FR2 = @(R2x,rarrayW0) R2x(1)*rarrayW0 + R2x(2);
    FR3 = @(R3x,rarrayW0) R3x(1)*rarrayW0 + R3x(2);

    R2x0 = [0,0];
    R2x=lsqcurvefit(FR2,R2x0,rarrayW0,relation2W0);
    
    R3x0 = [0,0];
    R3x=lsqcurvefit(FR3,R3x0,rarrayW0,relation3W0);

    R2slope(j,1) = R2x(1);

    R3slope(j,1) = R3x(1);
end

R2slopep=polyfit(darray,R2slope,R2slopefitdeg);
R3slopep=polyfit(darray,R3slope,R3slopefitdeg);

x1 = linspace(0.45,0.8);

figure('Name', '(R2) slope')
plot(darray, R2slope','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('slope (R2)');
R2slopey1 = polyval(R2slopep,x1);
hold on;
plot(x1,R2slopey1, 'r--', 'DisplayName',['degree ' num2str(R2slopefitdeg) ' fit']);
legend

figure('Name', '(R3) slope')
plot(darray, R3slope','b-o','DisplayName',['data']);
xlabel('depth');
ylabel('slope (R3)');
R3slopey1 = polyval(R3slopep,x1);
hold on;
plot(x1,R3slopey1, 'r--', 'DisplayName',['degree ' num2str(R3slopefitdeg) ' fit']);
legend

writematrix(R2slopep, 'a5_R2slopep_2fit_With0.txt');
writematrix(R3slopep, 'a5_R3slopep_3fit_With0.txt');