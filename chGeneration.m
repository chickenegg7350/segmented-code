function ch = chGeneration(para)
% 产生信道

% Alice到Bob的直接链路
hak = zeros(para.M, para.K);
for k=1:para.K
    disAk = norm(para.AliceLoc - para.BobsLoc(:,k));
    % 瑞利信道
    hak(:, k) = sqrt(para.C0*disAk^(-para.alphaAB)/para.sigma)*(randn(para.M,1)+1i*randn(para.M, 1)) /sqrt(2);
end

% Alice到Willie的直接链路
disaw = norm(para.AliceLoc - para.WillieLoc);
% 瑞利信道
haw = sqrt(para.C0*disaw^(-para.alphaAW)/para.sigma)*(randn(para.M,1)+1i*randn(para.M, 1)) /sqrt(2);

% Alice到RIS的反射链路
disar = norm(para.AliceLoc - para.RISLoc);
% 莱斯信道
thetaARAoD = asin((para.RISLoc(2)-para.AliceLoc(2))/disar);
thetaARAoA = asin((para.RISLoc(1)-para.AliceLoc(1))/disar);
G = sqrt(para.C0*disar^(-para.alphaAR)/para.sigma)*(sqrt(para.kappaAR/(1+para.kappaAR))*ULA_sv(thetaARAoA, para.N)*...
    ULA_sv(thetaARAoD, para.M)' + sqrt(1/(1+para.kappaAR))*(randn(para.N, para.M)+1i*randn(para.N, para.M))/sqrt(2));

% RIS到Bobs的反射链路
hrk = zeros(para.N, para.K);
for k=1:para.K
    disRb = norm(para.RISLoc - para.BobsLoc(:,k));
    thetaRB = asin((para.RISLoc(1)-para.BobsLoc(1,k))/disRb);
    % 莱斯信道
    hrk(:,k) = sqrt(para.C0*disar^(-para.alphaRB))*(sqrt(para.kappaRB /(1+para.kappaRB ))*ULA_sv(thetaRB, para.N)...
        + sqrt(1/(1+para.kappaRB ))*(randn(para.N, 1)+1i*randn(para.N, 1))/sqrt(2));
end

% RIS到Willie的反射链路
disrw = norm(para.WillieLoc - para.RISLoc);
thetaRW = asin((para.RISLoc(1)-para.WillieLoc(1))/disrw);
% 莱斯信道
hrw = sqrt(para.C0*disrw^(-para.alphaRW))*(sqrt(para.kappaRW /(1+para.kappaRW ))*ULA_sv(thetaRW, para.N)...
        + sqrt(1/(1+para.kappaRW ))*(randn(para.N, 1)+1i*randn(para.N, 1))/sqrt(2));



ch.hak = hak;
ch.haw = haw;
ch.hrk = hrk;
ch.hrw = hrw;
ch.G = G;

end