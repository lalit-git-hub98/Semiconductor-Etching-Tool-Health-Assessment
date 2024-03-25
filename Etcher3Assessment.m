%% Clear Workspace and Load Data
clear; clc; close all;
load('Baseline3DataSet.mat');
load('TestCase3DataSet.mat');

%% Develop Feature Matrices
% Build Training Feature Matrix
for k=1:length(Baseline3Run)
    s4Data = Baseline3Run{k}.Data(Baseline3Run{k}.Data(:, 2)==4, :);
    s5Data = Baseline3Run{k}.Data(Baseline3Run{k}.Data(:, 2)==5, :);
    for j=3:length(s4Data(1, :))
        featIn_s4(k, 7*(j-2)-6) = max(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-5) = min(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-4) = mean(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-3) = kurtosis(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-2) = std(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-1) = skewness(s4Data(:, j));
        featIn_s4(k, 7*(j-2)-0) = peak2peak(s4Data(:, j));
    end
    for j=3:length(s5Data(1, :))
        featIn_s5(k, 7*(j-2)-6) = max(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-5) = min(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-4) = mean(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-3) = kurtosis(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-2) = std(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-1) = skewness(s5Data(:, j));
        featIn_s5(k, 7*(j-2)-0) = peak2peak(s5Data(:, j));
    end
end
featIn = [featIn_s4, featIn_s5];

% Build Testing Feature Matrix
for k=1:length(TestCase3Run)
    s4Data_T = TestCase3Run{k}.Data(TestCase3Run{k}.Data(:, 2)==4, :);
    s5Data_T = TestCase3Run{k}.Data(TestCase3Run{k}.Data(:, 2)==5, :);
    for j=3:length(s4Data_T(1, :))
        test_featIn_s4(k, 7*(j-2)-6) = max(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-5) = min(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-4) = mean(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-3) = kurtosis(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-2) = std(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-1) = skewness(s4Data_T(:, j));
        test_featIn_s4(k, 7*(j-2)-0) = peak2peak(s4Data_T(:, j));
    end
    for j=3:length(s5Data_T(1, :))
        test_featIn_s5(k, 7*(j-2)-6) = max(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-5) = min(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-4) = mean(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-3) = kurtosis(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-2) = std(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-1) = skewness(s5Data_T(:, j));
        test_featIn_s5(k, 7*(j-2)-0) = peak2peak(s5Data_T(:, j));
    end
end
test_featIn = [test_featIn_s4, test_featIn_s5];

% Remove RF_Btm_Rfl_Pwr variable due to bad feature values
% featIn(:, 28:36) = [];
% test_featIn(:, 28:36) = [];

% Dynamically remove bad features
badFeat_train = var(featIn) == 0 | sum(isnan(featIn)) ~= 0 | sum(isinf(featIn)) ~= 0;
badFeat_test = var(test_featIn) == 0 | sum(isnan(test_featIn)) ~= 0 | sum(isinf(test_featIn)) ~= 0;
badFeat = logical(badFeat_train + badFeat_test);
featIn(:, badFeat) = [];
test_featIn(:, badFeat) = [];

% Normalize Feature matrix
[featIn_norm, ps] = mapstd(featIn', 0, 1);
test_featIn_norm = mapstd('apply',test_featIn',ps);
featIn_norm = featIn_norm';
test_featIn_norm = test_featIn_norm';

% Get sample lengths
N_train = length(featIn(:, 1));
N_test = length(test_featIn(:, 1));

% Rename for Lalit's Code
A_norm = featIn_norm; % for training data
X_norm = test_featIn_norm; % for testing data

%% PCA feature reduction
C = cov(A_norm); % Covariance matrix for training features
[V,R] = eig(C);
r = diag(R); %
H = V(:,end:-1:1); % eign vector
o = r(end:-1:1); % eign values
PC = A_norm*H; %Principal Component for training features

C_test = cov(X_norm); % Covariance matrix for testing features
[V_test,R_test] = eig(C_test);
r_test = diag(R_test); %
H_test = V_test(:,end:-1:1); % eign vector
o_test = r_test(end:-1:1); % eign values
PC_test = X_norm*H; %Principal Component for testing features

%% Variance Explained
for i = 1:19 % for training set
    variance_explained(i,1) = (o(i)/sum(o))*100;
end
figure()
plot(variance_explained,'*');
title('Variance Explained');
xlabel('Principal Component');
ylabel('Variance Explained');

%% Select number of PC to use
thresh = 40; % Variance Explained Threshold
pcCount = nan;
k=1;
while isnan(pcCount)
    expSum = sum(variance_explained(1:k));
    if expSum>thresh
        pcCount = k;
    end
    k = k+1;
end

%% Perform SPE Health Assessment
% SPE for training set
for i = 1:N_train
    PC_SPE(i,:) = A_norm(i,:)*H(:,1:pcCount);
    E_SPE(i,:) = A_norm(i,:) - PC_SPE(i,:)*(H(:,1:pcCount))';
    SPE(i) = sum(E_SPE(i,:).^2);
   
end
SPE = SPE';

% SPE Limit
for i = 1:pcCount
    theta(i) = sum(o(4:21,:).^i);
end
h0 = 1 - ((2*theta(1,1)*theta(1,3))/(3*theta(1,2)^2));
alpha = 0.001;
C_alpha = norminv(1-alpha);
SPE_alpha = theta(1,1)*(((C_alpha*(2*theta(1,2)*h0^2)^0.5)/(theta(1,1)))+1+((theta(1,2)*h0*(h0-1))/(theta(1,1)^2)))^(1/h0);

% SPE for testing set
for i = 1:N_test
    PC_SPE_test(i,:) = X_norm(i,:)*H(:,1:pcCount);
    E_SPE_test(i,:) = X_norm(i,:) - PC_SPE_test(i,:)*H(:,1:pcCount)';
    SPE_test(i) = sum(E_SPE_test(i,:).^2);
end
SPE_test = SPE_test';

% Plotting SPE data
U = ones(length(SPE_test),1);
SPE_alpha = U.*SPE_alpha;
figure()
plot(SPE_test)
hold on
plot(SPE_alpha)
legend('SPE Testing Data','SPE Threshold')
xlabel('Etcher run');
ylabel('SPE Value');
title('SPE Health Assessment Plot Etcher 3');
hold off

% Results of SPE
result_SPE = SPE_test>SPE_alpha;

%% T Square Health Assessment
COV = C(1:pcCount,1:pcCount); %Covariance matrix
eigMat = R(end:-1:1, end:-1:1); %Get relevant eigen values matrix
for i =1:N_train
    PC1(i,:) = A_norm(i,:)*H(:,1:pcCount);
    t_sr(i,1) = PC1(i,:)*inv(COV)*(PC1(i,:))'; % T square value
end

% T Square Limit
F = finv(1-alpha,pcCount,N_train-pcCount); % F value
t_sr_limit = (pcCount*(N_train-1)/(N_train-pcCount))*F; % T Square Limit

% T Square for testing set
for i =1:N_test
    PC1_test(i,:) = X_norm(i,:)*H(:,1:pcCount);
    t_sr_test(i,1) = PC1_test(i,:)*inv(eigMat(1:pcCount,1:pcCount))*(PC1_test(i,:))'; % T square value
end

% Plotting T Square
Y = ones(length(t_sr_test),1);
t_sr_limit = Y.*t_sr_limit;
figure()
plot(t_sr_test)
hold on
plot(t_sr_limit)
legend('T^2 Testing Data','T^2 Threshold')
xlabel('Etcher run');
ylabel('T^2 Value');
title('T^2 Health Assessment Plot Etcher 3');
hold off

% Result of T Square
result_Tsr = t_sr_test>t_sr_limit;

%% SOM MQE Health Assessment
% Import toolbox
addpath('F:\DOCUMENTS\School\2021 Spring\Industrial Big Data and AI\HW3\somtoolbox');

%Get reduced feature matrix
featTrainReduced = PC(:, 1:pcCount);
featTestReduced = PC_test(:, 1:pcCount);
% Training of SOM
sM=som_make(featTrainReduced);

% Calculate the MQE values for the testing data set
S=size(featTestReduced);
S=S(1);
for i=1:S
    qe=som_quality(sM,featTestReduced(i,:)); % calculate MQE value for each sample
    MQEt(i)=qe;
end
MQEtn=((MQEt)./(max(MQEt))); % normalize MQE
MQEtn=MQEtn';

%Plot MQE
MQE_thresh = 0.5.*ones(length(SPE_test),1);
figure();
hold on;
plot(MQEtn,'-*');
plot(MQE_thresh,'-');
xlabel('Etcher run');
ylabel('MQE Value');
title('MQE Health Assessment Plot Etcher 3');
legend('MQE Testing Data','MQE Threshold')
hold off;

% Generate MQE health assessment
result_MQE = MQEtn>0.5;

%% Generate Results
result_Overall = logical(result_SPE + result_Tsr + result_MQE);

sampleCount = 1:length(result_Overall);
testingResults = table(sampleCount', int8(result_MQE), int8(result_Tsr), int8(result_SPE), int8(result_Overall), 'VariableNames', {'Run Number', 'MQE', 'Tsr', 'SPE', 'Health Assessment'})
if isfile('Etcher3Health.xlsx')
    delete Etcher3Health.xlsx;
end
writetable(testingResults, 'Etcher3Health.xlsx');
fprintf('Principal Components used: %i\n', pcCount');