sigma_theta=1;
simtime_new=20;
ke_new=20;
[e_sigma,ft_sigma,u_sigma,vecV_sigma,x_sigma,f_list_sigma]=DNNSim_Robust(Arch1,k,L,m,n,act,A,omega,vecVinit_opt_res,step_size,simtime_new,xinit,ke_new,ks,Gamma,sigma_theta);

time_new=step_size*(0:simtime_new/step_size);
figure(1)

    
    subplot(2,1,1)
    plot(time_new,vecnorm(e_sigma))
    ylabel('$||e||$','interpreter','latex')
    grid on    

    
    subplot(2,1,2)
    plot(time_new,vecnorm(ft_sigma))
    ylabel('$||\tilde{f}||$','interpreter','latex')
    xlabel('Time (s)')
    grid on



% figure(1)
% 
%     
%     subplot(2,1,1)
%     plot(time,vecnorm(e_res),time,vecnorm(e_sigma))
%     ylabel('$||e||$','interpreter','latex')
%     legend('Sliding-Mode','Sigma Modification')
%     grid on    
% 
%     
%     subplot(2,1,2)
%     plot(time,vecnorm(ft_res),time,vecnorm(ft_sigma))
%     ylabel('$||\tilde{f}||$','interpreter','latex')
%     xlabel('Time (s)')
%     legend('Sliding-Mode','Sigma Modification')
%     grid on
% 
% %     
% % figure(2)
% % 
% %     plot(time,vecV_res(1901:1910,:))
% %     ylabel('ResNet Weight Estimates')
% %     xlabel('Time (s)')
% % %     ylim([-2 2])
% %     grid on
% % 
% % figure(3)
% % 
% %     plot(time,vecV_ful(1901:1910,:))
% %     ylabel('Fully-Connected DNN Weight Estimates')
% %     xlabel('Time (s)')
% %     ylim([-1 1])
% %     grid on
% 
% figure(4)
% 
%     plot(time,vecnorm(u_res),time,vecnorm(u_sigma))
%     ylabel('Normalized Control Inputs')
%     xlabel('Time (s)')
%     legend('Sliding-Mode','Sigma Modification')
%     grid on
% 
% e_rms_res=rms(vecnorm(e_res));
% ft_rms_res=rms(vecnorm(ft_res));
% u_rms_res=rms(vecnorm(u_res));
% 
% 
% e_rms_sigma=rms(vecnorm(e_sigma));
% ft_rms_sigma=rms(vecnorm(ft_sigma));
% u_rms_sigma=rms(vecnorm(u_sigma));



%     Architecture=["ResNet";"Fully-Connected"];
%     RMS_Tracking_Error=[e_rms_res;e_rms_ful];
%     RMS_Approximation_Error=[ft_rms_res;ft_rms_ful];
%     Control_Inputs=[u_rms_res;u_rms_ful];
%     Errors=table(Architecture,RMS_Tracking_Error,RMS_Approximation_Error,Control_Inputs)
    



    
    
    
    