clear all
close all
clc

% Load the Excel file
filename = 'Export0611.xlsx'; % replace with your actual file name
data = readtable(filename);

% Extract data using the column names from your Excel file
time = data.time;
phi1 = data.phi1;
phi2 = data.phi2;
phi3 = data.phi3;
phiF = data.phiF;
xF = data.xF;
yF = data.yF;

% Plot the data for the first 0.5 seconds
time_limit = 0.5;
index_limit = find(time <= time_limit);

% Figure 1: Plot phi angles with new colors
figure;
h1 = plot(time(index_limit), phi1(index_limit), 'Color', [0, 0.75, 0.75], 'LineWidth', 2, 'DisplayName', '\phi^{*}_{1}'); hold on;
h2 = plot(time(index_limit), phi2(index_limit), 'Color', [0.75, 0, 0.75], 'LineWidth', 2, 'DisplayName', '\phi^{*}_{2}');
h3 = plot(time(index_limit), phi3(index_limit), 'Color', [0, 0.5, 0.5], 'LineWidth', 2, 'DisplayName', '\phi^{*}_{3}');
h4 = plot(time(index_limit), phiF(index_limit), 'Color', [0.75, 0.5, 0], 'LineWidth', 2, 'DisplayName', '\phi^{*}_{F}');

% Add large markers for initial values
plot(time(1), phi1(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0, 0.75, 0.75], 'MarkerFaceColor', [0, 0.75, 0.75]);
plot(time(1), phi2(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0.75, 0, 0.75], 'MarkerFaceColor', [0.75, 0, 0.75]);
plot(time(1), phi3(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0, 0.5, 0.5], 'MarkerFaceColor', [0, 0.5, 0.5]);
plot(time(1), phiF(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0.75, 0.5, 0], 'MarkerFaceColor', [0.75, 0.5, 0]);

% Add labels and legend
xlabel('Time (s)');
ylabel('Angle (rad)');
title('Angle vs. Time');

% Manually create a legend to avoid default 'data1, data2, ...' labels
legend([h1, h2, h3, h4], {'\phi^{*}_{1}', '\phi^{*}_{2}', '\phi^{*}_{3}', '\phi^{*}_{F}'}, 'Location', 'northeast');

grid on;

% Annotate initial values with larger and bolder text
text(time(1), phi1(1), sprintf('\\phi^{*}_{1} = %.4f', phi1(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0, 0.75, 0.75], 'FontSize', 12, 'FontWeight', 'bold');
text(time(1), phi2(1), sprintf('\\phi^{*}_{2} = %.4f', phi2(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0.75, 0, 0.75], 'FontSize', 12, 'FontWeight', 'bold');
text(time(1), phi3(1), sprintf('\\phi^{*}_{3} = %.4f', phi3(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0, 0.5, 0.5], 'FontSize', 12, 'FontWeight', 'bold');
text(time(1), phiF(1), sprintf('\\phi^{*}_{F} = %.4f', phiF(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0.75, 0.5, 0], 'FontSize', 12, 'FontWeight', 'bold');

% Set x-axis limits
xlim([-0.15, time_limit]);

% Increase the font size and weight of the labels and legend
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
set(legend, 'FontSize', 12, 'FontWeight', 'bold');

hold off;

% Save the figure as a high-resolution image
saveas(gcf, 'Angle_vs_Time.png');
print(gcf, 'Angle_vs_Time', '-dpng', '-r300'); % Saves as a 300 DPI PNG

% Figure 2: Plot xF and yF
figure;
h5 = plot(time(index_limit), xF(index_limit), 'Color', [0, 0.75, 0.75], 'LineWidth', 2, 'DisplayName', 'x_{F}'); hold on;
h6 = plot(time(index_limit), yF(index_limit), 'Color', [0.75, 0, 0.75], 'LineWidth', 2, 'DisplayName', 'y_{F}');

% Add large markers for initial values
plot(time(1), xF(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0, 0.75, 0.75], 'MarkerFaceColor', [0, 0.75, 0.75]);
plot(time(1), yF(1), 'o', 'MarkerSize', 8, 'MarkerEdgeColor', [0.75, 0, 0.75], 'MarkerFaceColor', [0.75, 0, 0.75]);

% Add labels and legend
xlabel('Time (s)');
ylabel('Position (m)');
title('Position vs. Time');

% Manually create a legend to avoid default 'data1, data2, ...' labels
legend([h5, h6], {'x_{F}', 'y_{F}'}, 'Location', 'northeast');

grid on;

% Annotate initial values with larger and bolder text
text(time(1), xF(1), sprintf('x_{F} = %.4f', xF(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0, 0.75, 0.75], 'FontSize', 12, 'FontWeight', 'bold');
text(time(1), yF(1), sprintf('y_{F} = %.4f', yF(1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', [0.75, 0, 0.75], 'FontSize', 12, 'FontWeight', 'bold');

% Set x-axis limits
xlim([-0.15, time_limit]);

% Increase the font size and weight of the labels and legend
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
set(legend, 'FontSize', 12, 'FontWeight', 'bold');

hold off;

% Save the figure as a high-resolution image
saveas(gcf, 'Position_vs_Time.png');
print(gcf, 'Position_vs_Time', '-dpng', '-r300'); % Saves as a 300 DPI PNG
