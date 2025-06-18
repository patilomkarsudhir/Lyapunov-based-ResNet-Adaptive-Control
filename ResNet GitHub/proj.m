function [output] = proj(Lambda,thetahat,thetabar)



f=norm(thetahat)^2-thetabar^2;
delf=2*(thetahat);
prjscl=delf*delf'/norm(delf)^2;

if((f<0)||(delf'*Lambda<=0))
    output=Lambda;
%     proj=0;
else
    output=(eye(length(thetahat))-prjscl)*Lambda;

%     proj=1;
end