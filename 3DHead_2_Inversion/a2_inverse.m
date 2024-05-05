clear all;
syms d r;
delimiterIn = ' ';

alphaAve = 3.022375;
origproj = [-1; 0; 0];
%inputs:
de=0.5;
ra=0.2;
%inputs from artificial data
filename = strcat('projLHSR2LHSR3_CM_sphere_synthetic_h07_d',num2str(de*100),'_r',num2str(ra*10),'_-100proj.txt');
LHStemp = importdata(filename, delimiterIn);
LHS = LHStemp(5:6);

%fits %does not change
R2slopefit = importdata('a5_R2slopep_3fit_With0.txt');
R3slopefit = importdata('a5_R3slopep_2fit_With0.txt');

R2slopef = 0;
for i=1:size(R2slopefit,2)
    R2slopef = R2slopef + R2slopefit(1,i)*d^(size(R2slopefit,2)-i);
end

R3slopef = 0;
for i=1:size(R3slopefit,2)
    R3slopef = R3slopef + R3slopefit(1,i)*d^(size(R3slopefit,2)-i);
end


[sold, solr] = solve(r*R2slopef == LHS(1).^(1/alphaAve), r*R3slopef == LHS(2).^(1/3));



format long;
Projection = LHStemp(2:4)
err = norm(origproj-Projection)
depth = vpa(sold)
depthErr = (depth-de)/de
radius = vpa(solr)
radiusErr = (radius-ra)/ra