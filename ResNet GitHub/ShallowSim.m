function [e,ftilde,u_list,theta_list,x,f_list,fd_list]=ShallowSim(n,L,theta_init,A,omega,step_size,simtime,xinit,ke,ks,Gamma)


L_in=n;

L_out=n;

L_vec=L_in*L+L_out*L;

time_length=simtime/step_size;

x=xinit;
theta=theta_init;

for i=1:time_length
    
    t=(i-1)*step_size;       %Time
    
    
    xi=x(:,i);               %State
    theta_list(:,i)=theta;

    xdi=0.5+sin(omega*t);  %Desired Trajectory
    xdi_dot=omega.*cos(omega*t);
    

    ei=xi-xdi;
    e(:,i)=ei;
    
    
    %DNN
    xd=xdi;
    
    [Phi,Phi_prime] = ShallowGrad(n,L,n,xi,theta);

    
   
    

    
    
%     thbar=100;
%     vecVdot=proj(Gamma*Phi_prime'*ei,vecV,thbar);

%     Gammadot=-Gamma^2*norm(Phi_prime)^2;
%     Gamma=Gamma+step_size*Gammadot;


    thetadot=Gamma*(Phi_prime')*ei;

%     vecVdot=Gamma*(Phi_prime')*ei/(1+norm(Phi_prime)^2);


    
    theta=theta+step_size*thetadot;
    
    u=xdi_dot-Phi-ke*ei-ks*sign(ei);
    
    
    f=drif(xi,n,A);
    fd=drif(xdi,n,A);
%     mu=10;
%     f=[mu*(xi(1)-(1/3)*xi(1)^2-xi(2));(1/mu)*xi(1)];

    xdot=f+u;
    x(:,i+1)=xi+step_size*xdot; 
    
    u_list(:,i)=u;
    f_list(:,i)=f;
    fd_list(:,i)=fd;
    ftilde(:,i)=f-Phi;
    ftilde_frac(:,i)=(f-Phi)/norm(f);
    Phiplot(:,i)=Phi;
    xd_list(:,i)=xdi;
    
end

theta_list(:,i+1)=theta;
e(:,i+1)=x(:,i+1)-xdi;
ftilde(:,i+1)=ftilde(:,i);
ftilde_frac(:,i+1)=ftilde_frac(:,i);
Phiplot(:,i+1)=Phi;
f_list(:,i+1)=f_list(:,i);
fd_list(:,i+1)=fd_list(:,i);
u_list(:,i+1)=u_list(:,i);
xd_list(:,i+1)=xd_list(:,i);

% e_rms=norm(rms(e'));
% ftilde_rms=norm(rms(ftilde'));


       
    
