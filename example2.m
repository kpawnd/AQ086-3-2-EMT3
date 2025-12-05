clear; clc;

% Data from Example 1
advertising_cost = [8000, 12000, 11000, 5000, 14000, 3000]';
sales = [25000, 35000, 29000, 24000, 38000, 12000]';

x = advertising_cost;
y = sales;

% (i) Product moment correlation coefficient
x_mean = mean(x);
y_mean = mean(y);
SS_xx = sum((x - x_mean).^2);
SS_yy = sum((y - y_mean).^2);
SS_xy = sum((x - x_mean).*(y - y_mean));
r = SS_xy / sqrt(SS_xx * SS_yy);

% Interpretation of r
if abs(r) >= 0.9
    strength = 'very strong';
elseif abs(r) >= 0.7
    strength = 'strong';
elseif abs(r) >= 0.5
    strength = 'moderate';
elseif abs(r) >= 0.3
    strength = 'weak';
else
    strength = 'very weak';
end
if r > 0
    direction = 'positive';
else
    direction = 'negative';
end
fprintf('Product moment correlation coefficient (r): %.4f\n', r);
fprintf('Interpretation: There is a %s %s linear relationship between advertising cost and sales.\n\n', strength, direction);

% (ii) Coefficient of determination
R_squared = r^2;
fprintf('Coefficient of determination (R^2): %.4f\n', R_squared);
fprintf('Interpretation: %.2f%% of the variation in sales can be explained by advertising cost using the linear regression model.\n', R_squared*100);
