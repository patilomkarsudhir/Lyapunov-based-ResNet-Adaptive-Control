function y=st(x)
y=x;
for i=1:length(x)
if(x(i)>=0)
    y(i)=1;
%     y(i)=tanh(x(i));
else
    y(i)=0.1;
end
end