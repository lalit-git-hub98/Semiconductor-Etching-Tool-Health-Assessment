%% Loading the data
load('Baseline1DataSet.mat');
load('TestCase1DataSet.mat');

% Build Training Feature Matrix
for k=1:length(Baseline1Run)
    for j=3:length(Baseline1Run{k}.Data(1, :))
        featIn(k, 9*(j-2)-8) = max(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-7) = min(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-6) = mean(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-5) = kurtosis(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-4) = std(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-3) = var(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-2) = rms(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-1) = skewness(Baseline1Run{k}.Data(:, j));
        featIn(k, 9*(j-2)-0) = peak2peak(Baseline1Run{k}.Data(:, j));
    end
end
% Build Testing Feature Matrix
for k=1:length(TestCase1Run)
    for j=3:length(TestCase1Run{k}.Data(1, :))
        test_featIn(k, 9*(j-2)-8) = max(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-7) = min(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-6) = mean(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-5) = kurtosis(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-4) = std(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-3) = var(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-2) = rms(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-1) = skewness(TestCase1Run{k}.Data(:, j));
        test_featIn(k, 9*(j-2)-0) = peak2peak(TestCase1Run{k}.Data(:, j));
    end
end
% Remove RF_Btm_Rfl_Pwr variable due to bad feature values
featIn(:, 28:36) = [];
test_featIn(:, 28:36) = [];

%% Rename for Lalit's Code
A = featIn; % for training data
X = test_featIn; % for testing data