%% Question 2: Orders vs Overtime
% Goal: fit least-squares regression line of overtime (Y) on orders received (X)
% and predict overtime required for 100 orders.

clear; clc; close all;

%% Data
X = [83, 22, 107, 55, 48, 92, 135, 32, 67, 122]';   % orders received
Y = [38, 9, 42, 18, 11, 30, 48, 10, 29, 51]';       % total overtime (hours)

%% Scatter plot
figure('Position', [100, 100, 700, 500]);
scatter(X, Y, 80, 'filled', 'MarkerFaceColor', [0.2 0.5 0.8]);
hold on; grid on;
xlabel('Orders received');
ylabel('Total overtime (hours)');
title('Orders vs Overtime');

%% Least-squares regression (Y on X)
mdl = fitlm(X, Y, 'VarNames', {'Orders','Overtime'});
coef = mdl.Coefficients.Estimate; % [intercept; slope]
b0 = coef(1);
b1 = coef(2);

% Regression line for plotting
x_line = linspace(min(X)-5, max(X)+5, 100)';
y_line = b0 + b1 .* x_line;
plot(x_line, y_line, 'r-', 'LineWidth', 2);
legend('Data points', sprintf('Y = %.3f + %.3fX', b0, b1), 'Location', 'northwest');

% Print regression outputs
r = corr(X, Y);
fprintf('Regression equation: Overtime = %.4f + %.4f * Orders\n', b0, b1);
fprintf('Correlation (r): %.4f\n', r);
fprintf('R-squared: %.4f\n\n', mdl.Rsquared.Ordinary);

%% Prediction at 100 orders
X_new = 100;
Y_pred = b0 + b1 * X_new;
fprintf('Predicted overtime for 100 orders: %.2f hours\n', Y_pred);

% Mark prediction on plot
plot(X_new, Y_pred, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'y');
text(X_new, Y_pred, sprintf('  (100 orders, %.1f hrs)', Y_pred), 'VerticalAlignment', 'bottom');

hold off;
