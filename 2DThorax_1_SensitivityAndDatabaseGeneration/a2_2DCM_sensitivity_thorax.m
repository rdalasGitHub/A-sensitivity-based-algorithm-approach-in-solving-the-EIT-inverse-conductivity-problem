clear all;
addpath('ffmatlib');

[p,b,t,nv,nbe,nt,labels,regions]=ffreadmesh('Th_ThoraxDatabase.msh');
[u]=ffreaddata('sensitivity_d1_r0.4.txt');


ub=abs(max(u));
lb=abs(min(u));
ulb=max(ub,lb);
size(u)

%color map (gradient)
map = multigradient([1 0 0; 1 1 1; 0 0 1]);
map2 = multigradient([1 0 0; 0.9 0.9 0.9; 0 0 1]);

figure('Name','Sensitivity','NumberTitle','off');
ffpdeplot(p,b,t, 'XYData',u,'ColorRange',[-0.4, 0.4],'ColorMap',map2, 'Mesh', 'off');
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;
