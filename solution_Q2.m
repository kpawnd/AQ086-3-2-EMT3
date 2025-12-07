clear; clc;

%% Load data
filePath = fullfile('data', 'DATA_housing_PT_1(in).csv');
T = readtable(filePath);
house_value = T.house_value;
income = T.income;
housing_age = T.housing_age;
longitude = T.longitude;
latitude = T.latitude;

%% Model A: house_value ~ income
mdlA = fitlm(income, house_value, 'VarNames', {'income','house_value'});
coefA = mdlA.Coefficients; % intercept & slope
R2_A = mdlA.Rsquared.Ordinary;
r_A = corr(income, house_value); % simple correlation

fprintf('Model A: house_value ~ income\n');
fprintf('Equation: house_value = %.4f + %.4f * income\n', coefA.Estimate(1), coefA.Estimate(2));
fprintf('Correlation (r)             : %.4f\n', r_A);
fprintf('R^2 (coefficient of det.)   : %.4f\n', R2_A);
fprintf('\n');

%% Model B: house_value ~ income + housing_age + longitude + latitude
X_B = table(income, housing_age, longitude, latitude, house_value, ...
	'VariableNames', {'income','housing_age','longitude','latitude','house_value'});
mdlB = fitlm(X_B, 'house_value ~ income + housing_age + longitude + latitude');
coefB = mdlB.Coefficients;
R2_B = mdlB.Rsquared.Ordinary;

fprintf('Model B: house_value ~ income + housing_age + longitude + latitude\n');
fprintf('Intercept: %.4f\n', coefB.Estimate(1));
fprintf('income coeff     : %.4f\n', coefB.Estimate(strcmp(coefB.Row, 'income')));
fprintf('housing_age coeff: %.4f\n', coefB.Estimate(strcmp(coefB.Row, 'housing_age')));
fprintf('longitude coeff  : %.4f\n', coefB.Estimate(strcmp(coefB.Row, 'longitude')));
fprintf('latitude coeff   : %.4f\n', coefB.Estimate(strcmp(coefB.Row, 'latitude')));
fprintf('R^2 (coefficient of det.)   : %.4f\n', R2_B);
fprintf('\n');

%% Correlation matrix for Model B predictors and house_value
varsForCorr = [income, housing_age, longitude, latitude, house_value];
[Rmat, Pmat] = corr(varsForCorr);
varNames = {'income','housing_age','longitude','latitude','house_value'};

fprintf('Correlation matrix (rows/cols: income, housing_age, longitude, latitude, house_value):\n');
disp(array2table(Rmat, 'VariableNames', varNames, 'RowNames', varNames));

%% Interpretation notes (printed)
fprintf('Interpretation notes:\n');
fprintf(' - Model A: slope on income shows average change in house_value per unit income; r and R^2 show strength of linear association.\n');
fprintf(' - Model B: coefficients show adjusted effects given other predictors; R^2 indicates variance explained with all predictors.\n');
fprintf(' - Compare R^2: improvement from A to B shows added explanatory power of extra predictors.\n');
