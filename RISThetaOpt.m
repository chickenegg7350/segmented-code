function phi_new = RISThetaOpt(para, ch, W, phi, Gamma)
% ADMM算法优化分块RIS相位

%% 求解方程
t = solvet(para);


% 构造组合信号 htilde, htilde_aw
[htilde_ak, ~, Hk_all, Hw] = hak2htilde_ak(para,ch, phi, Gamma);

[alpha_bk] = updateAlpha(para, W, htilde_ak);

[omega_bk] = updateBeta(para, W, alpha_bk, htilde_ak);

% ADMM惩罚因子
rho = 1;

% ADMM对偶变量
varphi = phi;

epsilon = zeros(para.S,1);

% 辅助变量b
b = zeros(para.K, para.K);
for k=1:para.K
    for i=1:para.K
        b(k,i) = conj(omega_bk(k)) * ch.hak(:,k)'*W(:,i);
    end
end

% 辅助变量c
c = zeros(para.S, para.K, para.K);
for k=1:para.K
    for i=1:para.K
        c(:,k,i) = conj(omega_bk(k)) * Gamma' * Hk_all(:,:,k) * W(:,i);
    end
end

Pi = zeros(para.S, para.S);
for k=1:para.K
    for i=1:para.K
        Pi = Pi + c(:,k,i)*c(:,k,i)';
    end
end

PHI = zeros(para.S, 1);
for k=1:para.K
    temp = 0;
    for i=1:para.K
        temp = temp + conj(b(k,i))*c(:,k,i);
    end
    PHI = PHI + sqrt(1+alpha_bk(k))*c(:,k,k) - temp;
end

v = zeros(para.S, para.K);
cw = zeros(1, para.K);
for k=1:para.K
    v(:,k) = Gamma'*Hw*W(:,k);
    cw(1, k) = ch.haw'*W(:,k);
end



max_inner_iter = 10;
for inner_iter = 1:max_inner_iter

    cvx_begin quiet
        variable phi_new(para.S, 1) complex

        maximize(-quad_form(phi_new, Pi) + real(2*phi_new'*PHI) - rho/2*square_pos(norm(phi_new - varphi + epsilon/rho)))

        subject to
            WilliePower = 0;
            for k=1:para.K
                WilliePower = WilliePower + square_abs(cw(1, k)+phi_new'*v(:,k));
            end

            WilliePower <= t

            abs(phi_new) <= 1
    cvx_end

    varphi = exp(1i*angle(rho*phi_new+epsilon));

    epsilon = epsilon + rho*(phi_new-varphi);
end



end