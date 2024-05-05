clear all;
addpath('ffmatlib');

[p,b,t,nv,nbe,nt,labels,regions]=ffreadmesh('ball_h66.mesh');
[u]=ffreaddata('sensitivity_415_r2.txt');
labels

ub=abs(max(u));
lb=abs(min(u));
ulb=max(ub,lb);

%3 points that determine 2 vectors to create a plane/parallelogram
D1=[ 1  1 0];
D2=[ -1 1 0];
D3=[ 1 -1 0];


%color map (gradient)
map = multigradient([1 0 0; 1 1 1; 0 0 1]);
map2 = multigradient([1 0 0; 0.9 0.9 0.9; 0 0 1]);

figure('Name','Sensitivity','NumberTitle','off');
ffpdeplot3D(p,b,t,'XYZData', u, 'ColorRange',[-ulb, ulb],'ColorMap',map2, 'Mesh', 'off' );
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;

figure('Name','(Conductivity) Sensitivity With Slice','NumberTitle','off');
ffpdeplot3D(p,b,t,'XYZData',u,'ColorRange',[-2,2],'ColorMap',map2, 'Slice',D1,D2,D3, 'Mesh', 'on');
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;