A = [0
1
1
0
0
1
0
0
1
0
0
1
1
0
0
];
a = A';%Predicted Labels
B = [0
1
1
0
0
1
0
0
1
0
0
1
1
0
0
];
b = B';%Actual Labels
Confusion_mat = confusionmat(b,a);
confusionchart(C);
[X,Y,T,AUC] = perfcurve(b,a,'1');
plot(X,Y)
xlabel('False Positive Rate')
ylabel('True Positive Rate')
title('ROC Curve for Etcher 3')
