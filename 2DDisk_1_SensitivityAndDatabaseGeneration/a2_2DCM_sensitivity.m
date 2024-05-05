%imports sensitivity values from FreeFem++ outputs then graph it
%inputs: mesh (name.msh) and the sensitivity values (name.txt)
%output: graph of sensitivity values

clear all;
addpath('ffmatlib');

%import files
[p,b,t,nv,nbe,nt,labels,regions]=ffreadmesh('Th_1200.msh');
[u]=ffreaddata('sensitivity_d7_r2.txt');

%getting range for the colormap
ub=abs(max(u));
lb=abs(min(u));
ulb=max(ub,lb);
%size(u)

%color map (gradient)
map = multigradient([1 0 0; 1 1 1; 0 0 1]);
map2 = multigradient([1 0 0; 0.9 0.9 0.9; 0 0 1]);

figure('Name','Sensitivity','NumberTitle','off');
ffpdeplot(p,b,t, 'XYData',u,'ColorRange',[-2, 2],'ColorMap',map2, 'Mesh', 'off' );
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;
