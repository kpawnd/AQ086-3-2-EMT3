%% Question 3: Price vs Sales
% (a) Scatter plot
% (b) Product moment correlation coefficient
% (c) Least-squares regression of Sales on Price (and plot line)
% (d) Brief comments on results

clear; clc; close all;

%% Data
Price = [8.99; 9.50; 9.99; 10.50; 10.99; 11.50; 11.99; 12.50; 12.99];
Sales = [496; 465; 482; 459; 408; 382; 315; 363; 309];

%% (a) Scatter plot
figure('Position', [100, 100, 700, 500]);
scatter(Price, Sales, 80, 'filled', 'MarkerFaceColor', [0.2 0.5 0.8]);
hold on; grid on;
xlabel('Price (GBP)');
ylabel('Sales (units)');
title('Price vs Sales');

%% (b) Product moment correlation coefficient
r = corr(Price, Sales);
fprintf('Correlation (r): %.4f\n', r);

%% (c) Least-squares regression: Sales on Price
mdl = fitlm(Price, Sales, 'VarNames', {'Price','Sales'});
coef = mdl.Coefficients.Estimate; % [intercept; slope]
b0 = coef(1);
b1 = coef(2);

% Regression line for plotting
x_line = linspace(min(Price)-0.2, max(Price)+0.2, 100)';
y_line = b0 + b1 .* x_line;
plot(x_line, y_line, 'r-', 'LineWidth', 2);
legend('Data points', sprintf('Sales = %.2f + %.2f * Price', b0, b1), 'Location', 'northeast');

% Print regression outputs
fprintf('Regression equation: Sales = %.4f + %.4f * Price\n', b0, b1);
fprintf('R-squared: %.4f\n', mdl.Rsquared.Ordinary);

%% (d) Comments (printed)
if r < 0
    trend = 'negative';
else
    trend = 'positive';
end
fprintf('\nComment: r indicates a %s linear relationship between price and sales. ', trend);
fprintf('The slope shows expected change in sales per £1 change in price. Higher |r| and R^2 imply stronger linear association.\n');
