clear all;
syms d r;
delimiterIn = ' ';

%inputs from artificial data
filename = sprintf('projLHSR2LHSR3_CM_sphere_synthetic_h07_d80_r2_-100proj.txt');
LHStemp = importdata(filename, delimiterIn);
LHS = LHStemp(5:6);

%fits %does not change
R2slopefit = importdata('a5_R2slopep_4fit_31082_With0.txt');
R2yinterceptfit = importdata('a5_R2yinterceptp_3fit_31082_With0.txt');
R3slopefit = importdata('a5_R3slopep_3fit_With0.txt');
R3yinterceptfit = importdata('a5_R3yinterceptp_4fit_With0.txt');

R2slopef = 0;
for i=1:size(R2slopefit,2)
    R2slopef = R2slopef + R2slopefit(1,i)*d^(size(R2slopefit,2)-i);
end
R2yinterceptf = 0;
for i=1:size(R2yinterceptfit,2)
    R2yinterceptf = R2yinterceptf + R2yinterceptfit(1,i)*d^(size(R2yinterceptfit,2)-i);
end
R3slopef = 0;
for i=1:size(R3slopefit,2)
    R3slopef = R3slopef + R3slopefit(1,i)*d^(size(R3slopefit,2)-i);
end
R3yinterceptf = 0;
for i=1:size(R3yinterceptfit,2)
    R3yinterceptf = R3yinterceptf + R3yinterceptfit(1,i)*d^(size(R3yinterceptfit,2)-i);
end

%[sold, solr] = solve(r*R2slopef + R2yinterceptf == LHS(1).^(4/3.1082), r*R3slopef + R3yinterceptf == LHS(2));
[sold, solr] = solve(r*R2slopef == LHS(1).^(4/3.1082), r*R3slopef == LHS(2));

format long;
Projection = LHStemp(2:4)
depth = vpa(sold)
radius = vpa(solr)

