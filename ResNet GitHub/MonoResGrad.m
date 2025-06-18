function [Phi,Phi_prime] = MonoResGrad(k,L,m,n,x,vecV,act)

Phi_p=x;
eta_p=zeros(n,1);
L_vec_p=(n+n+(k-1)*L)*L;
L_vec=m*L_vec_p;

Phi_prime=zeros(n,L_vec);

for p=1:m
    
    eta_p=Phi_p;
    vecV_p=vecV((p-1)*L_vec_p+1:p*L_vec_p);
    
    [Lambda_p,Phi_p,Xi_p]=blockgrads(act,vecV_p,eta_p,k,L,n,n);   
    
    Lambdas(1:n,(p-1)*L_vec_p+1:p*L_vec_p)=Lambda_p;
    Xis(1:n,(p-1)*n+1:p*n)=Xi_p;
    
end

Phi=x+Phi_p;

Prod_p=eye(n);

for p=m:-1:1
    
    Lambda_p=Lambdas(1:n,(p-1)*L_vec_p+1:p*L_vec_p);
    Phi_prime(1:n,(p-1)*L_vec_p+1:p*L_vec_p)=Prod_p*Lambda_p;
    Prod_p=Prod_p*(Xis(1:n,(p-1)*n+1:p*n));

end