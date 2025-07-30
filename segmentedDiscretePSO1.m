function Gamma_new1 = segmentedDiscretePSO1(para, ch, W, phi, Gamma)

S = para.S;
N = para.N;
lb = zeros(N,1)+0.01;
ub = S*ones(N,1);

t = solvet(para);

nvars = N;

options = optimoptions('particleswarm','SwarmSize',1000,'HybridFcn',@fmincon);

x = particleswarm(@func,nvars,lb,ub,options);

x = ceil(x);

Gamma_new1 = zeros(N,S);

for n1=1:N
    Gamma_new1(n1, x(n1)) = 1;
end

rate_pre = rateCal(para, ch, W, phi, Gamma);

rate_new = rateCal(para, ch, W, phi, Gamma_new1);

if(rate_new < rate_pre)
    Gamma_new1 = Gamma;
end


function [fitness] = func(P_S)
    x1 = ceil(P_S); 

    Gamma_new = zeros(N,S);

    for n=1:N
        Gamma_new(n, x1(n)) = 1;
    end

    rate = rateCal(para, ch, W, phi, Gamma_new);

    [~, htilde_aw, ~, ~] = hak2htilde_ak(para,ch, phi, Gamma_new);

    % 隐蔽约束
    WillieP = 0;
    for k=1:para.K
        WillieP = WillieP + abs(htilde_aw'*W(:,k))^2;
    end

    fitness = -rate + (WillieP > t) * 10;

end


end