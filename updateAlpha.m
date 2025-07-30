function [alpha_bk] = updateAlpha(para, W, htilde_ak)
% 更新辅助变量alpha
alpha_bk = zeros(para.K, 1);
for k=1:para.K
    inter = 0;
    for i=1:para.K
        if i~=k
            inter = inter + abs(htilde_ak(:,k)'*W(:,i))^2;
        end
    end
    alpha_bk(k, 1) = abs(htilde_ak(:,k)'*W(:,k))^2 / (inter + 1.0);
end
end