clear all
close all
clc

% Load the Excel file
filename = 'Export0611.xlsx'; % replace with your actual file name
data = readtable(filename);

% Extract data using the column names from your Excel file
time = data.time;
dot_phi1 = data.dot_phi1;
dot_yF = data.dot_yF;

% Plot the data for the first 5 seconds
time_limit = 5;
index_limit = find(time <= time_limit);

% Figure 4: Plot time vs. dot_phi1 and dot_yF
figure;
h1 = plot(time(index_limit), dot_phi1(index_limit), 'Color', [0, 0.75, 0.75], 'LineWidth', 2, 'DisplayName', '$\dot{\phi}_{1}^{*}$'); hold on;
h2 = plot(time(index_limit), dot_yF(index_limit), 'Color', [0.75, 0, 0.75], 'LineWidth', 2, 'DisplayName', '$\dot{y}_{F}$');

% Add labels and legend
xlabel('Time (s)', 'Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('$\dot{\phi}_{1}$: rad/s, $\dot{y}_{F}$: m/s', 'Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold');
title('$\dot{\phi}_{1}$ and $\dot{y}_{F}$ vs. Time', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold');

% Manually create a legend to avoid default 'data1, data2, ...' labels
legend([h1, h2], {'$\dot{\phi}_{1}$', '$\dot{y}_{F}$'}, 'Location', 'northeast', 'Interpreter', 'latex');

grid on;

% Increase the font size and weight of the labels and legend
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
set(legend, 'FontSize', 12, 'FontWeight', 'bold');

hold off;

% Save the figure as a high-resolution image
saveas(gcf, 'dot_phi1_and_dot_yF_vs_Time.png');
print(gcf, 'dot_phi1_and_dot_yF_vs_Time', '-dpng', '-r300'); % Saves as a 300 DPI PNG
