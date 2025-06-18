clear all
close all

load('Config')

n=10;

act="tanh";

k=1;
m=10;
L=10;

L_in=n;

L_out=n;

L_vec= (L_out+L_in+(k-1)*L)*L;

L_vec_total= m*(L_out+L_in+(k-1)*L)*L;
% A=0.1*rand(n,6*n);
% omega=rand(n,1);


step_size=0.01;
simtime=10;
time_length=simtime/step_size;
xinit=1*(-1+2*rand(n,1));
x=xinit;
ke=10;
ks=0;
Gamma=5;  %Adaptation Gain

Arch1="Res";
Arch2="Ful";

%%Use Arch3="Mono" for simulating ResNet with a single shortcut connection


N=100;

time=(0:time_length)*step_size;
xd=sin(omega*time);

for i=1:N
i
vecVinit=0.5*(-1+2*rand(L_vec_total,1));


[e_res,ft_res,u_res,vecV_res,x_res,f_list_res]=DNNSim(Arch1,k,L,m,n,act,A,omega,vecVinit,step_size,simtime,xinit,ke,ks,Gamma);
[e_ful,ft_ful,u_ful,vecV_ful,x_ful,f_list_ful]=DNNSim(Arch2,k,L,m,n,act,A,omega,vecVinit,step_size,simtime,xinit,ke,ks,Gamma);

% Use ShallowSim function for comparing with a shallow NN
% Use ZeroSim function for comparison with a controller without the NN term

e_rms_res=norm(rms(e_res'));
ft_rms_res=norm(rms(ft_res'));
u_rms_res=norm(rms(u_res'));
e_rms_ful=norm(rms(e_ful'));
ft_rms_ful=norm(rms(ft_ful'));
u_rms_ful=norm(rms(u_ful'));

cost_res=e_rms_res^2+0.01*u_rms_res^2;
cost_ful=e_rms_ful^2+0.01*u_rms_ful^2;


    if(i==1)
        vecVinit_opt_res=vecVinit;
        cost_min_res=cost_res;
    else
        if(cost_res<=cost_min_res)
            vecVinit_opt_res=vecVinit;
            cost_min_res=cost_res;
        end
    end
    
    if(i==1)
        vecVinit_opt_ful=vecVinit;
        cost_min_ful=cost_ful;
    else
        if(cost_ful<=cost_min_ful)
            vecVinit_opt_ful=vecVinit;
            cost_min_ful=cost_ful;
        end
    end

    
cost_min_res    
end


[e_res,ft_res,u_res,vecV_res,x_res,f_list_res,fd_list_res]=DNNSim(Arch1,k,L,m,n,act,A,omega,vecVinit_opt_res,step_size,simtime,xinit,ke,ks,Gamma);
[e_ful,ft_ful,u_ful,vecV_ful,x_ful,f_list_ful,fd_list_ful]=DNNSim(Arch2,k,L,m,n,act,A,omega,vecVinit_opt_ful,step_size,simtime,xinit,ke,ks,Gamma);


figure(1)


    subplot(2,1,1)
    plot(time,vecnorm(e_res),time,vecnorm(e_ful))
    ylabel('$||e||$','interpreter','latex')
    legend('ResNet','Fully Connected')
    grid on    

    
    subplot(2,1,2)
    plot(time,vecnorm(ft_res),time,vecnorm(ft_ful))
    ylabel('$||\tilde{f}||$','interpreter','latex')
    xlabel('Time (s)')
    legend('ResNet','Fully Connected')
    grid on

    
figure(2)

    plot(time,vecV_res)
    ylabel('ResNet Weight Estimates')
    xlabel('Time (s)')
    ylim([-2 2])
    grid on

figure(3)

    plot(time,vecV_ful)
    ylabel('Fully-Connected DNN Weight Estimates')
    xlabel('Time (s)')
    ylim([-1 1])
    grid on

figure(4)

    plot(time,vecnorm(u_res),time,vecnorm(u_ful))
    ylabel('Normalized Control Inputs')
    xlabel('Time (s)')
    legend('ResNet','Fully Connected')
    grid on

e_rms_res=norm(rms(e_res'));
ft_rms_res=norm(rms(ft_res'));
u_rms_res=norm(rms(u_res));


e_rms_ful=norm(rms(e_ful'));
ft_rms_ful=norm(rms(ft_ful'));
u_rms_ful=norm(rms(u_ful));



    Architecture=["ResNet";"Fully-Connected"];
    RMS_Tracking_Error=[e_rms_res;e_rms_ful];
    RMS_Approximation_Error=[ft_rms_res;ft_rms_ful];
    Control_Inputs=[u_rms_res;u_rms_ful];
    Errors=table(Architecture,RMS_Tracking_Error,RMS_Approximation_Error,Control_Inputs)
    



    
    
    
    