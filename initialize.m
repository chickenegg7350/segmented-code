function [W, phi, Gamma] = initialize(para, ch)
% 初始化

% 分块RIS相位
phi = ones(para.S, 1);

temp = eye(para.S,para.S);

Gamma = repmat(temp, para.N/para.S,1);


% MRT初始化基站发射波束W
W = zeros(para.M, para.K);
for k=1:para.K
    Hk = zeros(para.N, para.M);
    for n=1:para.N
        Hk(n,:) = ch.hrk(n, k)'*ch.G(n,:);
    end
    htemp = ch.hak(:,k)' + phi'*Gamma'*Hk;
    W(:,k) = sqrt(para.Pmax/para.K) * htemp' / norm(htemp);
end
% W = zeros(para.M, para.K);
% for k=1:para.K
%     temp = randn(para.M, 1) +1i*randn(para.M, 1);
%     W(:,k) = sqrt(para.Pmax/para.K) * conj(temp) / norm(temp);
% end


end