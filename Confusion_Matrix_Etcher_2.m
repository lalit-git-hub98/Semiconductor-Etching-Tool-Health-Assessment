A = [1
0
0
1
0
1
1
0
0
0
1
0
0
1
1
];
a = A'; %predicted Labels
B = [1
0
0
1
0
1
1
0
0
0
1
0
0
0
1
];
b = B'; %Actual Labels

Confusion_mat = confusionmat(b,a);
confusionchart(C);
[X,Y,T,AUC] = perfcurve(b,a,'0');
plot(X,Y)
xlabel('False Positive Rate')
ylabel('True Positive Rate')
title('ROC Curve for Etcher 2')