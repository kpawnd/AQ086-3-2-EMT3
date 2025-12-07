%% Q4 (a): Scatter diagrams for correlation types
clear; clc; close all;
figure('Name','Q4a Correlation Types','Position',[100,100,1200,400]);

% (i) No correlation
subplot(1,4,1);
x = rand(1,10)*10;
y = rand(1,10)*10;
scatter(x, y, 60, 'filled'); grid on;
title('No correlation');
xlabel('X'); ylabel('Y');

% (ii) Weak positive correlation
subplot(1,4,2);
x = linspace(1,10,10);
y = x*0.5 + randn(1,10)*2;
scatter(x, y, 60, 'filled'); grid on;
title('Weak positive');
xlabel('X'); ylabel('Y');

% (iii) Perfect positive correlation
subplot(1,4,3);
x = linspace(1,10,10);
y = 2*x;
scatter(x, y, 60, 'filled'); grid on;
title('Perfect positive');
xlabel('X'); ylabel('Y');

% (iv) Moderately strong negative correlation
subplot(1,4,4);
x = linspace(1,10,10);
y = 20 - 1.5*x + randn(1,10)*2;
scatter(x, y, 60, 'filled'); grid on;
title('Moderate negative');
xlabel('X'); ylabel('Y');

%% Q4 (b): Home area/value correlation
area = [1.8 1.6 2.5 2.0 1.2 1.5 2.4]';
value = [100 96 151 121 83 94 140]';
r = corr(area, value);
R2 = r^2;
fprintf('Q4b: r(area,value) = %.4f\n', r);
fprintf('Q4b: R^2 = %.4f\n', R2);
if r > 0
    interp = 'positive';
else
    interp = 'negative';
end
fprintf('Interpretation: %.1f%% of variation in value explained by area. Relationship is %s.\n\n', R2*100, interp);

%% Q5: Spearman rank correlation for employee rankings
A = [2 1 3 4 6 5 8 7 10 9];
B = [3 2 1 4 6 7 5 9 10 8];
[rho, pval] = corr(A', B', 'Type','Spearman');
fprintf('Q5: Spearman rank correlation (A vs B): %.4f\n', rho);
if abs(rho) > 0.8
    interp = 'very strong';
elseif abs(rho) > 0.6
    interp = 'strong';
elseif abs(rho) > 0.3
    interp = 'moderate';
else
    interp = 'weak';
end
fprintf('Interpretation: %s agreement in rankings.\n\n', interp);

%% Q6: Repair times
est = [30 90 15 75 60 40 20 80 45 120];
act = [22 64 36 61 93 45 33 65 50 90];

% (a) Spearman's rank correlation
[rho6, ~] = corr(est', act', 'Type','Spearman');
fprintf('Q6a: Spearman rank correlation: %.4f\n', rho6);

% (b) Product moment correlation
[r6, ~] = corr(est', act', 'Type','Pearson');
fprintf('Q6b: Product moment correlation: %.4f\n', r6);

% (c) Explanation
fprintf('Q6c: Spearman measures monotonic (rank) association, Pearson measures linear association.\n');
fprintf('If ranks agree but relationship is not strictly linear, Spearman can be high while Pearson is lower.\n');
