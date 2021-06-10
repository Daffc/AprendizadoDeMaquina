#!/usr/bin/env python3
# -*- encoding: iso-8859-1 -*-

import sys
import numpy
import time
from pathlib import Path
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.linear_model import LogisticRegression, Perceptron
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report
from sklearn.datasets import load_svmlight_file
from sklearn.utils import resample


def analisis(X_train, y_train, X_test,  y_test, method, name):

    #Set the chosen model
    model = method
    
    print (f'Fitting {name}')
    model.fit(X_train, y_train)

    # predicao do classificador
    print ('Predicting...')
    y_pred = model.predict(X_test)

    # mostra o resultado do classificador na base de teste
    print ('Accuracy: ',  model.score(X_test, y_test))

    # cria a matriz de confusao
    cm = confusion_matrix(y_test, y_pred)
    print (cm)
    print(classification_report(y_test, y_pred, labels=[0,1,2,3,4,5,6,7,8,9]))


def main():
    
    if len(sys.argv) != 4:
        sys.exit("Use: knn.py <data_train> <data_test> <dt_train_size>")

    ftrain = sys.argv[1]
    ftest = sys.argv[2]
    dt_train_size = int(sys.argv[3])

    # output directory.
    Path("./saidas").mkdir(parents=True, exist_ok=True)

    # loads data
    print ("Loading data...")
    ori_X_train, ori_y_train  = load_svmlight_file(ftrain)
    X_test,  y_test = load_svmlight_file(ftest)

    # loads data
    print ("Resampling...")
    rs_X_train, rs_y_train  = resample(ori_X_train, ori_y_train, n_samples=dt_train_size)
    
    rs_X_train_dense = rs_X_train.todense()
    X_test_dense = X_test.todense()

    # KNN
    with open(f'saidas/knn_{dt_train_size}.txt', 'w') as f_out:
        sys.stdout = f_out
        start_time = time.time()
        analisis(rs_X_train_dense, rs_y_train, X_test_dense,  y_test, KNeighborsClassifier(), 'KNN')
        print(f" tempo : {(time.time() - start_time)}")

    
    # Naive Bayes
    with open(f'saidas/nb_{dt_train_size}.txt', 'w') as f_out:
        sys.stdout = f_out
        start_time = time.time()
        analisis(rs_X_train_dense, rs_y_train, X_test_dense,  y_test, GaussianNB(), 'Naive Bayes')
        print(f" tempo : {(time.time() - start_time)}")

    # Linear Discriminant Analysis
    with open(f'saidas/lda_{dt_train_size}.txt', 'w') as f_out:
        sys.stdout = f_out
        start_time = time.time()
        analisis(rs_X_train_dense, rs_y_train, X_test_dense,  y_test, LinearDiscriminantAnalysis(), 'Linear Discriminant Analysis')
        print(f" tempo : {(time.time() - start_time)}")

    # Logistic Regression
    with open(f'saidas/lr_{dt_train_size}.txt', 'w') as f_out:
        sys.stdout = f_out
        start_time = time.time()
        analisis(rs_X_train_dense, rs_y_train, X_test_dense,  y_test, LogisticRegression(), 'Logistic Regression')
        print(f" tempo : {(time.time() - start_time)}")

    # Perceptron
    with open(f'saidas/perc_{dt_train_size}.txt', 'w') as f_out:
        sys.stdout = f_out
        start_time = time.time()
        analisis(rs_X_train_dense, rs_y_train, X_test_dense,  y_test,  Perceptron(), 'Perceptron')
        print(f" tempo : {(time.time() - start_time)}")


if __name__ == "__main__":
    main()


