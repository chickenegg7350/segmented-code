function [rateVec] = segmentedRIS(para, ch, W, phi, Gamma)

max_iter = 60;
rateVec = [];
for ii=1:max_iter
    %% 优化基站波束
    W = AliceBeamformingOpt(para, ch, W, phi, Gamma);
    
    rate = rateCal(para, ch, W, phi, Gamma);
    rateVec = [rateVec rate];

    %% 分块RIS反射系数优化
    phi = RISThetaOpt(para, ch, W, phi, Gamma);

    %% 优化分块矩阵
    Gamma = segmentedDiscretePSO1(para, ch, W, phi, Gamma);

%     if ii>10
%         if  abs(rateVec(ii) - rateVec(ii-1))/rateVec(ii-1)<1e-4
%             break
%         end
%     end

end
end