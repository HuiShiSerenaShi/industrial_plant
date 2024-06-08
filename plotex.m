% % 从 .mat 文件绘制图表
% data = load('your_data.mat');
% time = data.time;
% signal = data.signal;
% 
% figure;
% plot(time, signal);
% xlabel('Time');
% ylabel('Signal');
% title('Signal vs Time');
% saveas(gcf, 'signal_plot_mat.png');

% 从 Excel 文件绘制图表
filename = 'New_Export.xlsx';
data = readtable(filename);
time = data.Time;
signal = data.Signal;

figure;
plot(time, signal);
xlabel('Time');
ylabel('Signal');
title('Signal vs Time');
saveas(gcf, 'signal_plot_excel.png');
