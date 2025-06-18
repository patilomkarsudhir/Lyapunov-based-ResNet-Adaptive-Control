function y = drif(x,n,A)
tanhz=tanh(x);
sinz=sin(x);
sechz=sech(x);
squarez=x.^2;
cubez=x.^3;

y=A*[x;tanhz;sinz;sechz;squarez;cubez];