clear; clc;

%% Load data
filePath = fullfile('data', 'DATA_housing_PT_1(in).csv');
T = readtable(filePath);
y = T.house_value;

n = numel(y);
mu_hat = mean(y);
std_hat = std(y);

fprintf('Sample size n       : %d\n', n);
fprintf('Sample mean         : %.2f\n', mu_hat);
fprintf('Sample std (n-1)    : %.2f\n\n', std_hat);

%% (a) One-sided t-test: mu > 205,000
alpha_a = 0.05;
mu0_a = 205000;
[h_a, p_a, ci_a, stats_a] = ttest(y, mu0_a, 'Alpha', alpha_a, 'Tail', 'right');

fprintf('Test (a): H0: mu <= 205000, H1: mu > 205000 (alpha=0.05)\n');
fprintf('t statistic         : %.4f\n', stats_a.tstat);
fprintf('df                  : %d\n', stats_a.df);
fprintf('p-value             : %.4g\n', p_a);
fprintf('Reject H0?          : %d\n', h_a);
fprintf('95%% CI for mean     : [%.2f, %.2f]\n\n', ci_a(1), ci_a(2));

%% (b) Two-sided z-test with known sigma = 115,000: mu != 208,000
alpha_b = 0.01;
mu0_b = 208000;
sigma_known = 115000;
se_known = sigma_known / sqrt(n);
z_b = (mu_hat - mu0_b) / se_known;
p_b = 2 * (1 - normcdf(abs(z_b)));
reject_b = p_b < alpha_b;

fprintf('(b): H0: mu = 208000, H1: mu != 208000 (alpha=0.01, sigma known=115000)\n');
fprintf('z statistic         : %.4f\n', z_b);
fprintf('p-value             : %.4g\n', p_b);
fprintf('Reject H0?          : %d\n', reject_b);

z_crit = norminv(1 - alpha_b/2);
ci_b = [mu_hat - z_crit*se_known, mu_hat + z_crit*se_known];
fprintf('99%% CI for mean     : [%.2f, %.2f]\n', ci_b(1), ci_b(2));
