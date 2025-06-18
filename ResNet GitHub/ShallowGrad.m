function [Phi,Phi_prime] = ShallowGrad(L_in,L,L_out,x,theta)


L_vec=L_in*L+L_out*L;

V0=unvec(theta(1:L_in*L),L_in,L);
V1=unvec(theta(L_in*L+1:L_vec),L,L_out);

phi_1=tanh(V0'*tanh(x));
phi_prime_1=diag(sech2(V0'*tanh(x)));

Phi=V1'*phi_1;
Phi_prime_0=V1'*phi_prime_1*kron(eye(L),x');
Phi_prime_1=kron(eye(L_out),phi_1');

Phi_prime=[Phi_prime_0 Phi_prime_1];

end