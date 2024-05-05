clear all;
syms d r;
delimiterIn = ' ';

dep = 0.18;
rad = 0.02;
%inputs from artificial data
filename = sprintf('projLHSR2LHSR3_uCM2D_synthetic_d1.8_r0.2.txt');
LHStemp = importdata(filename, delimiterIn);
LHS = LHStemp(5:6);

%fits %does not change
R2slopefit = importdata('a5_R2slopep_5fit.txt');
R3slopefit = importdata('a5_R3slopep_5fit.txt');

R2slopef = 0;
for i=1:size(R2slopefit,2)
    R2slopef = R2slopef + R2slopefit(1,i)*d^(size(R2slopefit,2)-i);
end
R3slopef = 0;
for i=1:size(R3slopefit,2)
    R3slopef = R3slopef + R3slopefit(1,i)*d^(size(R3slopefit,2)-i);
end

[sold, solr] = solve(r*R2slopef == LHS(1).^(1/1.9844), r*R3slopef  == LHS(2).^(1/2));

format long;
%For R1 projection to the boundary of the thorax
Projectiontemp = LHStemp(2:3);
t = sym('t','real');
%thorax boundary
x=@(t) - 0.0012841238435510075530099349805369*cos(4.0*t) - 0.0038830399740377957544523734867425*cos(2.0*t) - 0.0017767291532370648593497364231553*sin(2.0*t) - 0.00074652313387462191328347582697234*sin(4.0*t) + 0.019871511217381013919558441216395*cos(5.0*t) + 0.0075389314173667787422061792312888*sin(5.0*t) - 0.031071941885180434650415293162951*cos(3.0*t) + 0.0010115371376220338474338777956518*sin(3.0*t)  - 1.2331394243466438087608594287303*cos(t) - 0.040589663383760375692244082301841*sin(t) + 1.8648398172495168623186145850923;
y=@(t) 0.0069306653308619653452993247810809*cos(2.0*t) + 0.00083176350874720073741430681479869*cos(4.0*t) + 0.01323399385303617066533821144958*sin(2.0*t) - 0.010315586161017303509779274861557*sin(4.0*t) + 0.0005105940287295522225785582293156*cos(5.0*t) + 0.026294740703020041960868979913357*sin(5.0*t) - 0.0057261186761046814486242340080935*cos(3.0*t) - 0.066462267447447750945421773849375*sin(3.0*t)  + 0.045400754239963821146108813309183*cos(t) - 1.0435542752740996075289103828254*sin(t) + 1.514431292173438858839062959305;
%thorax center
x1 = 1.855276337;
y1 = 1.503403159;
%retrieved from convex combination
x2 = Projectiontemp(1);
y2 = Projectiontemp(2);
%solve
m=(y2-y1)/(x2-x1);
b= y1-m*x1;
S = vpasolve(y(t) == m*x(t) + b, t);

projx = vpa(x(S+pi));
projy = vpa(y(S+pi));
depth = vpa(sold)
deperr = (depth-dep)/dep
radius = vpa(solr)
raderr = (radius-rad)/rad

centerofpert = [2.4144, 2.42141] + dep*([x1,y1] - [2.4144, 2.42141])
centerofpert = [2.4144, 2.42141] + 0.2*([x1,y1] - [2.4144, 2.42141])