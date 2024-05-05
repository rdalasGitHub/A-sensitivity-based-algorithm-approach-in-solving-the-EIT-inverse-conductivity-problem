clear all;
addpath('ffmatlib');
delimiterIn = ' ';
syms d r;
format long;

numberOfElectrodes = 71;
origproj = [-1; 0; 0];
alphaAve = 3.02827; %for (-304);

%inputs:
de=0.8;
ra=0.2;

%For Graphing electrodes R1
[p,b,t,nv,nbe,nt,labels]=ffreadmesh('ball70.mesh');
[electrodestemp]=ffreaddata('electrodesInd70.txt');
electrodes = electrodestemp(2:size(electrodestemp), 1) +1 ; %position of the electrodes on the mesh

%fits %does not change %For R2 and R3
R2slopefit = importdata('a5_R2slopep_3fit_With0_-304.txt');
R2yinterceptfit = importdata('a5_R2yinterceptp_3fit_With0_-304.txt');
R3slopefit = importdata('a5_R3slopep_3fit_With0_-304.txt');
R3yinterceptfit = importdata('a5_R3yinterceptp_3fit_With0_-304.txt');

%SyntheticData
filename = strcat('CEM_sphere_synthetic_h07_d',num2str(de*100),'_r',num2str(ra*10),'_-100proj.txt');
Utemp = importdata(filename, delimiterIn);
U = Utemp(2:72, 1);
exp=1;
[Usort,ksort] = sort(U);

lahat=size(electrodes,1);
%plotting: para sa tatlong max at tatlong min lang
for i=1:lahat
     if electrodes(i) == ksort(71,1);
         electrodes(i)= Usort(71,1);
     else if electrodes(i) == ksort(70,1);
         electrodes(i)= Usort(70,1);
     else if electrodes(i) == ksort(69,1);
         electrodes(i)= Usort(69,1);    
     else if electrodes(i) == ksort(1,1);
         electrodes(i)= Usort(1,1);
     else if electrodes(i) == ksort(2,1);
         electrodes(i)= Usort(2,1);
     else if electrodes(i) == ksort(3,1);
         electrodes(i)= Usort(3,1);  
     else if electrodes(i) == 0;
         electrodes(i) = 0;
     else electrodes(i) = 0;
     end
     end
     end
     end
     end
     end
     end
end

%plotting: sensitivity sa buong electrodes
% for i=1:lahat
%     if electrodes(i) ~= 0
%     index = electrodes(i);
%     electrodes(i) = U(index,1);
%     end
% end

absmaxmin = [abs(Usort(1,1)), abs(Usort(71,1))];
aa= max(absmaxmin);
map = multigradient([1 0 0; 0.9 0.9 0.9; 0 0 1]);

figure('Name','(Conductivity) Sensitivity On Electrodes','NumberTitle','off');
ffpdeplot3D(p,b,t, 'XYZData',electrodes,'ColorRange',[-aa,aa],'ColorMap',map,'Mesh', 'off');
xlabel('x'); ylabel('y'); zlabel('z'); colorbar;


%--------------------------------------------------------(R1)
%positive part: name of xyz file
max1=strcat('xyz',num2str(ksort(71,1)),'_',num2str(70));
max2=strcat('xyz',num2str(ksort(70,1)),'_',num2str(70));
max3=strcat('xyz',num2str(ksort(69,1)),'_',num2str(70));
%(x,y,z) values on 3 max
xyz1= importdata(max1, delimiterIn);
xyz2= importdata(max2, delimiterIn);
xyz3= importdata(max3, delimiterIn);
%constant for convex combination
alpha1 = abs(Usort(71,1))^exp/(abs(Usort(71,1))^exp+abs(Usort(70,1))^exp+abs(Usort(69,1))^exp);
alpha2 = abs(Usort(70,1))^exp/(abs(Usort(71,1))^exp+abs(Usort(70,1))^exp+abs(Usort(69,1))^exp);
maxreptemp = alpha1*xyz1(2:4,1) + alpha2*xyz2(2:4,1) + (1-alpha1-alpha2)*xyz3(2:4,1);
%maximum point representative
maxrep=maxreptemp/norm(maxreptemp);

%negative part
min1=strcat('xyz',num2str(ksort(1,1)),'_',num2str(70));
min2=strcat('xyz',num2str(ksort(2,1)),'_',num2str(70));
min3=strcat('xyz',num2str(ksort(3,1)),'_',num2str(70));
%(x,y,z) values on 3 min
xyz11= importdata(min1, delimiterIn);
xyz22= importdata(min2, delimiterIn);
xyz33= importdata(min3, delimiterIn);
%constant for convex combination
alpha11 = abs(Usort(1,1))^exp/(abs(Usort(1,1))^exp+abs(Usort(2,1))^exp+abs(Usort(3,1))^exp);
alpha22 = abs(Usort(2,1))^exp/(abs(Usort(1,1))^exp+abs(Usort(2,1))^exp+abs(Usort(3,1))^exp);
minreptemp = alpha11*xyz11(2:4,1) + alpha22*xyz22(2:4,1) + (1-alpha11-alpha22)*xyz33(2:4,1);
%minimum point representative
minrep=minreptemp/norm(minreptemp);

%(R1) Convex combination of max rep and min rep to recover projection
alphaalpha = (abs(Usort(71,1))+abs(Usort(70,1))+abs(Usort(69,1)))/((abs(Usort(71,1))+abs(Usort(70,1))+abs(Usort(69,1)))+(abs(Usort(1,1))+abs(Usort(2,1))+abs(Usort(3,1))))
%alphaalpha = (abs(Usort(71,1))+abs(Usort(70,1)))/((abs(Usort(71,1))+abs(Usort(70,1)))+(abs(Usort(1,1))+abs(Usort(2,1))));

Projectiontemp = alphaalpha*maxrep+(1-alphaalpha)*minrep;
Projection = Projectiontemp/norm(Projectiontemp)
err = norm(origproj-Projection)
%plot3(Projection(1), Projection(2), Projection(3), '-o')


%--------------------------------------------------------(R2) and (R3)
%Recreating polynomial fits from saved coefficients
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
%solving for the left-hand sides
%getting the affected electrodes and values
numberofaffected = 0;
for k=1:71
    if abs(Usort(k)) >= 0.2*max(abs(Usort))
        numberofaffected = numberofaffected + 1;
        Uaffected(numberofaffected,1) = abs(Usort(k));
    end
end
LHS1 = norm(Uaffected)/numberofaffected;
LHS2 = norm(Usort);


%solving for radius and depth
[sold, solr] = solve(r*R2slopef == LHS1.^(1/alphaAve), r*R3slopef == LHS2.^(1/3));
format long;
depth = vpa(sold)
depthErr = (depth-de)/de
radius = vpa(solr)
radiusErr = (radius-ra)/ra

hold on; 
plot3(origproj(1), origproj(2), origproj(3), '-o');
plot3(Projection(1), Projection(2), Projection(3), '-*');