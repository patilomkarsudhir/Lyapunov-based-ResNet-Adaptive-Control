function y=relu(x)
y=x;
for i=1:length(x)
if(x(i)>=0)
    y(i)=x(i);
%     y(i)=log(cosh(x(i)));
else
    y(i)=0.1*x(i);
end
end