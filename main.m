clc; clear;

%% 仿真参数
para = simPara();

%% 产生信道
ch = chGeneration(para);

%% 传统RIS
fprintf('传统RIS');
para.S = para.N;
[W, phi, Gamma] = initialize(para, ch);
rate_noSegRIS = segmentedTraRIS(para, ch, W, phi, Gamma);

%% S=4
fprintf('S=4');
para.S = 4;
[W, phi, Gamma] = initialize(para, ch);
rate_S4SegRIS = segmentedRIS(para, ch, W, phi, Gamma);

%% S=4, 固定分块
fprintf('S=4, 固定分块');
para.S = 4;
[W, phi, Gamma] = initialize(para, ch);
rate_S4SegRISFixed = fixedSegmentedRIS(para, ch, W, phi, Gamma);
disp(toc)
%% S=8
fprintf('S=8');
para.S = 2;
[W, phi, Gamma] = initialize(para, ch);
rate_S8SegRIS = segmentedRIS(para, ch, W, phi, Gamma);
disp(toc)
%% S=8, 固定分块
fprintf('S=8, 固定分块');
para.S = 8;
[W, phi, Gamma] = initialize(para, ch);
rate_S8SegRISFixed = fixedSegmentedRIS(para, ch, W, phi, Gamma);

%% S=16
fprintf('S=16');
para.S = 16;
[W, phi, Gamma] = initialize(para, ch);
rate_S16SegRIS = segmentedRIS(para, ch, W, phi, Gamma);

%% S=16, 固定分块
fprintf('S=4, 固定分块');
para.S = 16;
[W, phi, Gamma] = initialize(para, ch);
rate_S16SegRISFixed = fixedSegmentedRIS(para, ch, W, phi, Gamma);
disp(toc)

%% 传统RIS，不优化RIS相位
fprintf('传统RIS，不优化RIS相位');
para.S = para.N;
[W, phi, Gamma] = initialize(para, ch);
rate_noSegRISwoPhaseopt = segmentedRISwophaseopt(para, ch, W, phi, Gamma);
disp(toc)



%%
figure;

% 定义颜色方案
noSegColor = [0, 0.4470, 0.7410];  
S4Color = [0.9290, 0.6940, 0.1250];  
S8Color = [0.4940, 0.1840, 0.5560];  
S16Color = [0.4660, 0.6740, 0.1880]; 

% 绘制 No Segmentation (保持原蓝色)
h1 = plot(rate_noSegRIS, '-o', 'LineWidth', 1.2, ...
          'Color', noSegColor, ...
          'MarkerIndices', 1:5:length(rate_noSegRIS));

hold on;

% S4 方案
h2 = plot(rate_S4SegRIS, '-d', 'LineWidth', 1.2, ...
          'Color', S4Color, ...
          'MarkerIndices', 1:5:length(rate_S4SegRIS));
      
h3 = plot(rate_S4SegRISFixed, '--d', 'LineWidth', 1.2, ...
          'Color', S4Color, ... 
          'MarkerIndices', 1:5:length(rate_S4SegRISFixed));

% S8 方案
h4 = plot(rate_S8SegRIS, '-v', 'LineWidth', 1.2, ...
          'Color', S8Color, ...
          'MarkerIndices', 1:5:length(rate_S8SegRIS));
      
h5 = plot(rate_S8SegRISFixed, '--v', 'LineWidth', 1.2, ...
          'Color', S8Color, ...
          'MarkerIndices', 1:5:length(rate_S8SegRISFixed));

% S16 方案
h6 = plot(rate_S16SegRIS, '-p', 'LineWidth', 1.2, ...
          'Color', S16Color, ...
          'MarkerIndices', 1:5:length(rate_S16SegRIS));
      
h7 = plot(rate_S16SegRISFixed, '--p', 'LineWidth', 1.2, ...
          'Color', S16Color, ...  
          'MarkerIndices', 1:5:length(rate_S16SegRISFixed));

h8 = plot(rate_noSegRISwoPhaseopt, '--+', 'LineWidth', 1.2, ...
          'Color', 'b', ... 
          'MarkerIndices', 1:5:length(rate_noSegRISwoPhaseopt));

legend([h1, h2, h3, h4, h5, h6, h7, h8], ...
    'traditional scheme','proposed segmentation, S=4', 'fixed segmentation，S=4', ...
    'proposed segmentation, S=8', 'fixed segmentation，S=8', ...
    'proposed segmentation, S=16', 'fixed segmentation，S=16', ...
    'traditional scheme(random phase)',...
    'Location', 'best');
xlabel('Iteration');
ylabel('Covert sum rate(bps/Hz)');
grid on;

xlim([1, length(rate_noSegRIS)]);

set(gca, 'FontSize', 10);
set(gcf, 'Position', [100, 100, 800, 600]);
