clear; clc; close all;

%% INPUT DATA
advertising_cost = [8000, 12000, 11000, 5000, 14000, 3000];
sales = [25000, 35000, 29000, 24000, 38000, 12000];

% For easier reference
x = advertising_cost;
y = sales;

%% DATA VALIDATION
n = length(x);
if length(y) ~= n
    error('Advertising costs and sales must have the same length');
end

fprintf('Sample size (n): %d\n\n', n);

%% PART (A): SCATTERGRAM
% Create a figure for the scattergram
figure('Position', [100, 100, 1000, 700]);
scatter(x, y, 100, 'filled', 'MarkerFaceColor', [0.2, 0.5, 0.8]);
hold on;

xlabel('Advertising Cost ($)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Sales ($)', 'FontSize', 12, 'FontWeight', 'bold');
title('Scattergram: Sales vs Advertising Cost', 'FontSize', 14, 'FontWeight', 'bold');
grid on;
set(gca, 'FontSize', 11);

fprintf('PART (A): Scattergram has been plotted.\n');
fprintf('The scattergram shows the relationship between advertising cost and sales.\n\n');

%% PART (B): CALCULATE REGRESSION EQUATION
fprintf('PART (B): Calculating the regression line equation.\n');

% Calculate means
x_mean = mean(x);
y_mean = mean(y);

% Calculate sums of squares
SS_xx = sum((x - x_mean).^2);
SS_yy = sum((y - y_mean).^2);
SS_xy = sum((x - x_mean).*(y - y_mean));

% Calculate regression coefficients
b1 = SS_xy / SS_xx;  % Slope
b0 = y_mean - b1 * x_mean;  % Intercept

% Predicted values
y_pred = b0 + b1 * x;

% Residuals
residuals = y - y_pred;

% Display regression equation
fprintf('Sales = %.4f + %.4f * Advertising_Cost\n', b0, b1);
fprintf('or\n');
fprintf('Y = %.2f + %.4f * X\n\n', b0, b1);

% Draw the regression line on the scattergram
plot(x, y_pred, 'r-', 'LineWidth', 2.5);
legend('Observed Data', sprintf('Regression Line: Y = %.2f + %.4fX', b0, b1), ...
    'Location', 'northwest', 'FontSize', 11);


%% PART (C): FORECAST SALES FOR SPECIFIC ADVERTISING COSTS
fprintf('PART (C): Forecasting sales for specific advertising costs...\n\n');

% (i) Forecast for $10,000
x_forecast_i = 10000;
y_forecast_i = b0 + b1 * x_forecast_i;

fprintf('(i) When Advertising Cost = $%.0f:\n', x_forecast_i);
fprintf('    Predicted Sales = $%.2f\n', y_forecast_i);

% Check if this is within the data range
x_min = min(x);
x_max = max(x);
if x_forecast_i >= x_min && x_forecast_i <= x_max
    fprintf('    ** This is INTERPOLATION (within data range: $%.0f - $%.0f)\n', x_min, x_max);
    fprintf('    ** Prediction is RELIABLE\n\n');
else
    fprintf('    ** This is EXTRAPOLATION (outside data range: $%.0f - $%.0f)\n', x_min, x_max);
    fprintf('    ** Use with caution\n\n');
end

% Plot the forecast point (i)
plot(x_forecast_i, y_forecast_i, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g', 'LineWidth', 2);

% (ii) Forecast for $1,000
x_forecast_ii = 1000;
y_forecast_ii = b0 + b1 * x_forecast_ii;

fprintf('(ii) When Advertising Cost = $%.0f:\n', x_forecast_ii);
fprintf('     Predicted Sales = $%.2f\n', y_forecast_ii);

% Check if this is within the data range
if x_forecast_ii >= x_min && x_forecast_ii <= x_max
    fprintf('     ** This is INTERPOLATION (within data range: $%.0f - $%.0f)\n', x_min, x_max);
    fprintf('     ** Prediction is RELIABLE\n\n');
else
    fprintf('     ** This is EXTRAPOLATION (outside data range: $%.0f - $%.0f)\n', x_min, x_max);
    fprintf('     ** Use with caution\n\n');
end

% Plot the forecast point (ii)
plot(x_forecast_ii, y_forecast_ii, 'mo', 'MarkerSize', 12, 'MarkerFaceColor', 'm', 'LineWidth', 2);

% Update legend to include forecast points
legend('Observed Data', sprintf('Regression Line: Y = %.2f + %.4fX', b0, b1), ...
    sprintf('Forecast (i): $10,000 → $%.0f', y_forecast_i), ...
    sprintf('Forecast (ii): $1,000 → $%.0f', y_forecast_ii), ...
    'Location', 'northwest', 'FontSize', 10);

hold off;
