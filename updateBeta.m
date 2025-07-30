function [beta_bk] = updateBeta(para, W, alpha_bk, htilde_ak)
% 更新辅助变量beta
beta_bk = zeros(para.K, 1);
for k=1:para.K
    inter = 0;
    for i=1:para.K
        inter = inter + abs(htilde_ak(:,k)'*W(:,i))^2;
    end 
    beta_bk(k, 1) = sqrt(1+alpha_bk(k, 1)) * htilde_ak(:,k)'*W(:,k) / (inter + 1.0);
end
end