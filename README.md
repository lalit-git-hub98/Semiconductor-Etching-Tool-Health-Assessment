# Semiconductor-Etching-Tool-Health-Assessment
<br />
A health assessment model is built for detecting anamolus conditions of the given metal etchers. 
<br />
This was done using Squared Predicted Error(SPE), Hotelling's T-squared statistics(T2), and Self-Organising Map Minimum Quantization Error (SOM-MQE).
<br />
![Process Flow Chart](/Process_flow_chart.PNG)
<br />
From each feature, time domain characteristics like maximum, minimum, mean, kurtosis, standard deviation, skewness, peak to peak are extracted and used for Principal component analysis. First five principal components were selected as they accounted for almost 90% of variation in the data.
<br />
For classification, if any of the three methods SPE, T2, SOM-MQE, predicted that the etcher is faulty then we lablelled that etcher run as faulty.
<br />
## **Results for SPE -->**
<br />
### SPE for Etcher 1
<br />
![SPE for Etcher 1](/SPE Reuslts - Experiment 1.PNG)
