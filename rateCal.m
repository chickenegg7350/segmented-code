function rate = rateCal(para, ch, W, phi, Gamma)
% 计算系统和速率

% 基站波束优化
htilde_ak = zeros(para.M, para.K);
for k=1:para.K
    Hk = zeros(para.N, para.M);
    for n=1:para.N
        Hk(n,:) = ch.hrk(n, k)'*ch.G(n,:); % 除RIS反射系数外的级联信道
    end
    htilde_ak(:,k) = (ch.hak(:,k)' + phi'*Gamma'*Hk)'; % Alice到Bobs的组合信道
end

rate = 0;

for k=1:para.K
    inter = 0;
    for i=1:para.K
        if i~=k
            inter = inter + abs(htilde_ak(:,k)'*W(:,i))^2;
        end
    end
    rate = rate + log2(1+abs(htilde_ak(:,k)'*W(:,k))^2/(inter + 1.0));
end

end