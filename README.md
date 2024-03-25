# Semiconductor-Etching-Tool-Health-Assessment
<br />
A health assessment model is built for detecting anamolus conditions of the given metal etchers. 
<br />
This was done using Squared Predicted Error(SPE), Hotelling's T-squared statistics(T2), and Self-Organising Map Minimum Quantization Error (SOM-MQE).<br />

![Process Flow Chart](/Process_flow_chart_1.PNG)
<br />
From each feature, time domain characteristics like maximum, minimum, mean, kurtosis, standard deviation, skewness, peak to peak are extracted and used for Principal component analysis. First five principal components were selected as they accounted for almost 90% of variation in the data.
<br />

Raw Data Visualization<br />
![Raw Data Visualization](/raw_data_visualization_1.PNG)
<br />
For classification, if any of the three methods SPE, T2, SOM-MQE, predicted that the etcher is faulty then we lablelled that etcher run as faulty.<br />

## **Results for SPE -->**<br />

### SPE for Etcher 1<br />
![SPE for Etcher 1](/SPE_Reuslts_Experiment_1.PNG)
<br />

### SPE for Etcher 2<br />
![SPE for Etcher 2](/SPE_Results_Experiment_2.PNG)
<br />

### SPE for Etcher 3<br />
![SPE for Etcher 3](/SPE_Results_Experiment_3.PNG)
<br />

## **Results for T2 -->**<br />

### T2 for Etcher 1<br />
![T2 for Etcher 1](/T2_Results_Experiment_1.PNG)
<br />

### T2 for Etcher 2<br />
![T2 for Etcher 2](/T2_Results_Experiment_2.PNG)
<br />

### T2 for Etcher 3<br />
![T2 for Etcher 3](/T2_Results_Experiment_3.PNG)
<br />

## **Results for SOM-MQE -->**<br />

### SOM-MQE for Etcher 1<br />
![SOM-MQE for Etcher 1](/SOM_Results_Experiment_1.PNG)
<br />

### SOM-MQE for Etcher 2<br />
![SOM-MQE for Etcher 2](/SOM_Results_Experiment_2.PNG)
<br />

### SOM-MQE for Etcher 3<br />
![SOM-MQE for Etcher 3](/SOM_Results_Experiment_3.PNG)
<br />

## **Classification Results for All the Etchers -->**<br />

### Classification Result for Etcher 1<br />
![Classification Result for Etcher 1](/Results_Etcher_1.PNG)
<br />

### Classification Result for Etcher 2<br />
![Classification Result for Etcher 2](/Results_Etcher_2.PNG)
<br />

### Classification Result for Etcher 3<br />
![Classification Result for Etcher 3](/Results_Etcher_3.PNG)
<br />

From the above results, all the runs for etcher 1 and 3 are correctly classified. For the etcher 2, 1 run is incorrectly classified. Hence an overall accuracy of 97.78% is achieved.<br />

## **Confusion Matrix -->**<br />

### Confusion Matrix for Etcher 1<br />
![Confusion Matrix for Etcher 1](/Confusion_Matrix_for_Etcher_1.PNG)
<br />

### Confusion Matrix for Etcher 2<br />
![Confusion Matrix for Etcher 2](/Confusion_Matrix_for_Etcher_2.PNG)
<br />

### Confusion Matrix for Etcher 3<br />
![Confusion Matrix for Etcher 3](/Confusion_Matrix_for_Etcher_3.PNG)
<br />

## **ROC Curve -->**<br />

### ROC Curve for Etcher 1<br />
![ROC Curve for Etcher 1](/ROC_Curve_for_Etcher_1.PNG)
<br />

### ROC Curve for Etcher 2<br />
![ROC Curve for Etcher 2](/ROC_Curve_for_Etcher_2.PNG)
<br />

### ROC Curve for Etcher 3<br />
![ROC Curve for Etcher 3](/ROC_Curve_for_Etcher_3.PNG)
<br />


