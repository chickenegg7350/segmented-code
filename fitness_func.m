function [fitness] = fitness_func(para, ch, W, phi, particle_pos, t)
% 粒子群算法的适应度函数
Gamma = zeros(para.N, para.S);

for n=1:para.N
    Gamma(n, particle_pos(n)) = 1;
end

rate = rateCal(para, ch, W, phi, Gamma);

[~, htilde_aw, ~, ~] = hak2htilde_ak(para,ch, phi, Gamma);

% 隐蔽约束
WillieP = 0;
for k=1:para.K
    WillieP = WillieP + abs(htilde_aw'*W(:,k))^2;
end


fitness = rate - (WillieP > t) * 10;

end