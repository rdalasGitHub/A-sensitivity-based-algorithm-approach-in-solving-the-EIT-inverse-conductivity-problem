delimiterIn = ' ';
rarray = 0.01:0.01:0.05;
rarray = rarray';
darray = 0.06:0.02:0.2;


for j=1:8
    i=4+2*j;
    myfilename2 = sprintf('R2LHS_d%d.txt', i);
    relation2temp = importdata(myfilename2, delimiterIn);
    relation2 = log(relation2temp(2:6));
    
    plot(rarray,relation2,'-o', 'DisplayName',['Depth = ' num2str(i/100)]);
    xlabel('radius');
    ylabel('LHS of (R2)');
    hold on;
    myfittype = fittype("a*log(x) + b", independent="x",coefficients=["a" "b"]);
    f=fit(rarray, relation2,myfittype)
end