clear all;
addpath('ffmatlib');
delimiterIn = ' ';

numberOfElectrodes = 71;

[p,b,t,nv,nbe,nt,labels]=ffreadmesh('ball66.mesh');
[u]=ffreaddata('sensitivity_d3_r2.txt');
[electrodes]=ffreaddata('electrodesIndsensitivity_d3_r2.txt');
Utemp= importdata('V1sensitivity_d3_r2.txt', delimiterIn); 


U = Utemp(2:numberOfElectrodes+1,1); %sensitivity on electrodes
lahat=size(electrodes,1);

for i=1:lahat
     if electrodes(i)<=-1
         electrodes(i)=0;
     else electrodenumber = electrodes(i);
         electrodes(i) = U(electrodenumber+1,1);
     end
end


ube=abs(max(electrodes));
lbe=abs(min(electrodes));
ulbe=max(ube,lbe);

%color map (gradient)
map = multigradient([1 0 0; 0.9 0.9 0.9; 0 0 1]);

%figure('Name','(Conductivity) Electrodes','NumberTitle','off');
%ffpdeplot3D(p,b,t, 'XYZData',nonelectrodes,'ColorMap',[0.8 0.8 0.8; 1 1 1],'Mesh', 'off');
%xlabel('x'); ylabel('y'); zlabel('z'); colorbar;

figure('Name','(Conductivity) Sensitivity Without Slice','NumberTitle','off');
ffpdeplot3D(p,b,t,'XYZData',u,'ColorRange',[-ulbe,ulbe],'ColorMap',map, 'Mesh', 'off' );
xlabel('x'); ylabel('y'); zlabel('z'); colorbar; hold on;

figure('Name','(Conductivity) Sensitivity On Electrodes','NumberTitle','off');
ffpdeplot3D(p,b,t, 'XYZData',electrodes,'ColorRange',[-ulbe,ulbe],'ColorMap',map,'Mesh', 'off');
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;