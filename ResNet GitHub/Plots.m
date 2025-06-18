L_shal_1=10;
theta_init_1 = 0.05*(-1 + 2*rand(2*n*L_shal_1,1));
L_shal_2=100;
theta_init_2 = 0.05*(-1 + 2*rand(2*n*L_shal_2,1));
% [e_shal,ftilde_shal,u_shal_list,theta_list,x_shal,f_shal_list,fd_shal_list]=ShallowSim(n,L_shal,theta_init,A,omega,step_size,simtime,xinit,ke,ks,Gamma);
[e_shal_1,ftilde_shal_1,u_shal_list_1,theta_list_1,x_shal_1,f_shal_list_1,fd_shal_list_1]=DNNSim(Arch2,k,L_shal_1,1,n,act,A,omega,theta_init_1,step_size,simtime_new,xinit,ke,ks,Gamma);
[e_shal_2,ftilde_shal_2,u_shal_list_2,theta_list_2,x_shal_2,f_shal_list_2,fd_shal_list_2]=DNNSim(Arch2,k,L_shal_2,1,n,act,A,omega,theta_init_2,step_size,simtime_new,xinit,ke,ks,Gamma);
figure(1)

subplot(2,1,1)
plot(time,vecnorm(e_res),time,vecnorm(e_shal_1),time,vecnorm(e_shal_2))
xlabel('Time (s)')
ylabel('$||e||$','interpreter','latex')
legend('ResNet','Shallow NN with 10 neurons','Shallow NN with 100 neurons')
grid on    


subplot(2,1,2)
plot(time,vecnorm(ft_res),time,vecnorm(ftilde_shal_1),time,vecnorm(ftilde_shal_2))
xlabel('Time (s)')
ylabel('$||e||$','interpreter','latex')
legend('ResNet','Shallow NN with 10 neurons','Shallow NN with 100 neurons')
grid on

figure(2)
plot(time,vecnorm(u_res),time,vecnorm(u_shal_list_1),time,vecnorm(u_shal_list_1))
xlabel('Time (s)')
ylabel('$||u||$','interpreter','latex')
legend('ResNet','Shallow NN with 10 neurons','Shallow NN with 100 neurons')
grid on   