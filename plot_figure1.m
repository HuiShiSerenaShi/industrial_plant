clear all
close all
clc
% Load the Excel file
filename = 'Export0611.xlsx'; % replace with your actual file name
data = readtable(filename);


% Extract data using the column names from your Excel file
time = data.time;
phi1 = data.phi1;
xE = data.xE;
yE = data.yE;

% Plot phi1, xE and yE for 10 seconds
time_limit_10s = 5;
index_limit_10s = find(time <= time_limit_10s);

figure;
h7 = plot(time(index_limit_10s), phi1(index_limit_10s), 'Color', [0, 0.75, 0.75], 'LineWidth', 2, 'DisplayName', '\phi^{*}_{1}'); hold on;
h8 = plot(time(index_limit_10s), xE(index_limit_10s), 'Color', [0.75, 0, 0.75], 'LineWidth', 2, 'DisplayName', 'x_{E}');
h9 = plot(time(index_limit_10s), yE(index_limit_10s), 'Color', [0, 0.5, 0.5], 'LineWidth', 2, 'DisplayName', 'y_{E}');

% Add labels and legend
xlabel('Time (s)');
ylabel('Position (m) / Angle (rad)');
title('\phi_{1} & Position E');

% Manually create a legend to avoid default 'data1, data2, ...' labels
legend([h7, h8, h9], {'\phi_{1} (rad)', 'x_{E} (m)', 'y_{E} (m)'}, 'Location', 'northeast');

grid on;

% Set x-axis limits
xlim([0, time_limit_10s]);

% Increase the font size and weight of the labels and legend
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
set(legend, 'FontSize', 12, 'FontWeight', 'bold');

hold off;

% Save the figure as a high-resolution image
saveas(gcf, 'phi1_and_Position_E.png');
print(gcf, 'phi1_and_Position_E', '-dpng', '-r300'); % Saves as a 300 DPI PNG



