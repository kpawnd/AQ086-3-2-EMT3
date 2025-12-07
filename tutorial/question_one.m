%% Question 1: Income (X, thousands GBP) vs Savings (Y, thousands GBP)
% (a) Scatter plot
% (b) Least-squares regression of savings on income (and plot line)
% (c) Predict savings when income = 7000 GBP (i.e., X = 7 in thousands)

clear; clc; close all;

%% Data (income X, savings Y) in thousands GBP
X = [8; 11; 9; 6; 5];
Y = [0.6; 1.3; 1.0; 0.7; 0.3];

%% (a) Scatter plot
figure('Position', [100, 100, 700, 500]);
scatter(X, Y, 80, 'filled', 'MarkerFaceColor', [0.2 0.5 0.8]);
hold on; grid on;
xlabel('Income (thousands GBP)');
ylabel('Savings (thousands GBP)');
title('Income vs Savings');

%% (b) Least-squares regression Y on X
mdl = fitlm(X, Y, 'VarNames', {'Income','Savings'});
coef = mdl.Coefficients.Estimate; % [intercept; slope]
b0 = coef(1);
b1 = coef(2);

% Regression line for plotting
x_line = linspace(min(X)-0.5, max(X)+0.5, 100)';
y_line = b0 + b1 .* x_line;
plot(x_line, y_line, 'r-', 'LineWidth', 2);
legend('Data points', sprintf('Y = %.3f + %.3fX', b0, b1), 'Location', 'northwest');

% Print results
fprintf('Regression equation (Y on X): Y = %.4f + %.4f * X\n', b0, b1);
fprintf('Correlation (r): %.4f\n', corr(X, Y));
fprintf('R-squared: %.4f\n\n', mdl.Rsquared.Ordinary);

%% (c) Predict savings when income = 7000 GBP (X = 7)
X_new = 7; % income in thousands GBP
Y_pred = b0 + b1 * X_new;
fprintf('Predicted savings at income = 7000 GBP: %.4f (thousands GBP)\n', Y_pred);
fprintf('That is approximately GBP %.2f\n', Y_pred * 1000);

% Mark the predicted point on the plot
plot(X_new, Y_pred, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'y');
text(X_new, Y_pred, sprintf('  (7, %.1f)', Y_pred), 'VerticalAlignment', 'bottom');
