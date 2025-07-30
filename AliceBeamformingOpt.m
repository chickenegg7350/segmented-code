function W_new = AliceBeamformingOpt(para, ch, W, phi, Gamma)

%% 求解方程
t = solvet(para);

%%  基站波束优化
% 构造组合信号 htilde, htilde_aw
[htilde_ak, htilde_aw, ~, ~] = hak2htilde_ak(para,ch, phi, Gamma);

[alpha_bk] = updateAlpha(para, W, htilde_ak);

[beta_bk] = updateBeta(para, W, alpha_bk, htilde_ak);


cvx_begin quiet
    variable W_new(para.M, para.K) complex

    % 目标函数
    obj = 0;
    
    for k=1:para.K
        inter = 0;
        for i=1:para.K
            inter = inter + square_abs(htilde_ak(:,k)'*W_new(:,i));
        end

        obj = obj + 2*sqrt(1+alpha_bk(k, 1))*real(conj(beta_bk(k))* htilde_ak(:,k)'*W_new(:,k))...
            - abs(beta_bk(k))^2*(inter + 1.0);
    end

    maximize(obj)

    subject to 
        norm(W_new,'fro') <= sqrt(para.Pmax)

        WilliePower = 0;
        for k=1:para.K
            WilliePower = WilliePower + square_abs(htilde_aw'*W_new(:,k));
        end

         WilliePower <= t

cvx_end



end