clear all;
syms d r;
delimiterIn = ' ';

alphaAve = 3.01036; %for -100 fit
%alphaAve = 3.02827; %for 304 fit

%inputs from artificial data
filename = sprintf('PeaksR1LHSR2LHSR3_CEM_sphere_synthetic_h07_d60_r2_-100proj.txt');
LHStemp = importdata(filename, delimiterIn);
LHS = LHStemp(6:7);

%fits %does not change
R2slopefit = importdata('a5_R2slopep_3fit_With0.txt');
R3slopefit = importdata('a5_R3slopep_3fit_With0.txt');

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
depth = vpa(sold)
radius = vpa(solr)
deperr = (depth-0.6)/0.6
raderr = (radius-0.2)/0.2


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%R1
% ElectrodePeaks = LHStemp(2:3);
% ElectrodeValues = LHStemp(4:5);
% 
% namemax=strcat('xyz',num2str(ElectrodePeaks(1,1)));
% namemin=strcat('xyz',num2str(ElectrodePeaks(2,1)));
% maxpeaktemp = importdata(namemax, delimiterIn);
% minpeaktemp = importdata(namemin, delimiterIn);
% 
% maxpeak = maxpeaktemp(2:4,1);
% minpeak = minpeaktemp(2:4,1);
% 
% ValuePercent = ElectrodeValues(1,1)/(ElectrodeValues(1,1) - ElectrodeValues(2,1));
% Projectiontemp = ValuePercent*maxpeak + (1-ValuePercent)*minpeak;
% Projection = Projectiontemp/norm(Projectiontemp)