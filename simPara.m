function para = simPara()
%% 仿真参数

% Alice天线数
para.M = 8;

% Bobs个数
para.K = 4;

% RIS单元个数
para.N = 256;

% RIS分块个数
para.S = 4;

% 单位距离路损, -30 dB
para.C0 = db2pow(-30);

% 路损因子
para.alphaAB = 4.2; % Alice-> Bob直接链路路损
para.alphaAW = 4.2; % Alice-> Willie直接链路路损
para.alphaAR = 2.0; % Alice-> RIS链路路损
para.kappaAR = db2pow(10); % Alice-> RIS莱斯因子
para.alphaRB = 2.0; % RIS-> Bob链路路损
para.kappaRB = db2pow(8); % RIS-> Bob莱斯因子
para.alphaRW = 2.0; % RIS-> Willie链路路损
para.kappaRW = db2pow(3); % RIS-> Willie莱斯因子

% Alice位置
para.AliceLoc = [0;0];

% Bobs位置
BobAngle = linspace(0, 2*pi, para.K+1);
BobAngle = BobAngle(1:end-1);

para.R = 20;
para.BobCenter = [80; 0];

para.BobsLoc = para.BobCenter + [para.R*cos(BobAngle); para.R*sin(BobAngle)];

% Willie位置
para.WillieLoc = [100; -20];

% RIS位置
para.RISLoc = [80;30];

% 噪声功率
para.sigma = db2pow(-90);

% 基站最大发射功率
para.Pmax = db2pow(20);

% 隐蔽约束
para.epsilon = 0.1;
end