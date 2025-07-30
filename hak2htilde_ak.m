function [htilde_ak, htilde_aw, Hk_all, Hw] = hak2htilde_ak(para,ch, phi, Gamma)
% 构造组合信道

htilde_ak = zeros(para.M, para.K);
Hk_all = zeros(para.N, para.M, para.K);
for k=1:para.K
    Hk = zeros(para.N, para.M);
    for n=1:para.N
        Hk(n,:) = ch.hrk(n, k)'*ch.G(n,:); % 除RIS反射系数外的级联信道
    end
    htilde_ak(:,k) = (ch.hak(:,k)' + phi'*Gamma'*Hk)'; % Alice到Bobs的组合信道

    Hk_all(:, :, k) = Hk;
end

Hw = zeros(para.N, para.M);
for n=1:para.N
    Hw(n,:) = ch.hrw(n, 1)'*ch.G(n,:);
end
htilde_aw = (ch.haw' + phi'*Gamma'*Hw)';  % Alice到Willie的组合信道
end