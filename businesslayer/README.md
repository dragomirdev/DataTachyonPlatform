# DTP-Business AI Layer

## Introduction

The Business Layer provides the visual graphical output by reading the processed and model data generated using AI Techniques and provies insights using different metrics to GUI Layer by converting the data into useful information.

## Machine Learning

 Tom Mitchell from Carnegie Mellon University gave a “well-posed” definition that has proven more useful to engineering types.

 “A computer program is said to learn from experience E with respect to some task T and some performance measure P, if its performance on T, as measured by P, improves with experience E.”

### Machine Learning Software Packags

* Numpy
* Scipy
* SciKit-Learn
* Pandas
* Xgboost
* Gensim

### Machine Learning vs. Traditional Programming

#### Traditional programming

![Traditional-Programming](/businesslayer/ai/images/traditional_programming.png)

* Traditional programming differs significantly from machine learning.
* In traditional programming, a programmer code all the rules in consultation with an expert in the industry for which software is being developed.
* Each rule is based on a logical foundation; the machine will execute an output following the logical statement.
* When the system grows complex, more rules need to be written. It can quickly become unsustainable to maintain.

#### Machine Learning Approach

![Machine Learning](/businesslayer/ai/images/machine_learning.png)

* Machine learning is supposed to overcome this issue.
* The machine learns how the input and output data are correlated and it writes a rule.
* The programmers do not need to write new rules each time there is new data.
* The algorithms adapt in response to new data and experiences to improve efficacy over time.

#### Learning Phase

![Learning Phase](/businesslayer/ai/images/learning_phase.png)

* Machine learning is the brain where all the learning takes place.
* The way the machine learns is similar to the human being. Humans learn from experience.
* The more we know, the more easily we can predict.
* By analogy, when we face an unknown situation, the likelihood of success is lower than the known situation.
* Machines are trained the same. To make an accurate prediction, the machine sees an example.
* When we give the machine a similar example, it can figure out the outcome.
* However, like a human, if its feed a previously unseen example, the machine has difficulties to predict.
* The core objective of machine learning is the learning and inference. * First of all, the machine learns through the discovery of patterns.
* This discovery is made thanks to the data. One crucial part of the data scientist is to choose carefully which data to provide to the machine.
* The list of attributes used to solve a problem is called a feature vector.
* One can think of a feature vector as a subset of data that is used to tackle a problem.
* The machine uses some fancy algorithms to simplify the reality and transform this discovery into a model.
* Therefore, the learning stage is used to describe the data and summarize it into a model.

#### Inferring

![Inferring](/businesslayer/ai/images/inference_from_model.png)

* When the model is built, it is possible to test how powerful it is on never-seen-before data.
* The new data are transformed into a features vector, go through the model and give a prediction.
* This is all the beautiful part of machine learning. There is no need to update the rules or train again the model.
* One can use the model previously trained to make inference on new data.

#### Machine Learning Stages

![ML-Stages](/businesslayer/ai/images/machine_learning_works.png)

The life of Machine Learning programs is straightforward\
and can be summarized in the following points:

* Define a question
* Collect data
* Visualize data
* Train algorithm
* Test the Algorithm
* Collect feedback
* Refine the algorithm
* Loop 4-7 until the results are satisfying
* Use the model to make a prediction

Machine learning can be grouped into two broad learning tasks

* Supervised
* Unsupervised.

There are many other algorithms

#### Supervised Learning

* An algorithm uses training data and feedback from humans to learn the relationship of given inputs to a given output. 
* For instance, a practitioner can use marketing expense and weather forecast as input data to predict the sales of cans.
* One can use supervised learning when the output data is known. 
* The algorithm will predict new data.

There are two categories of supervised learning

* Classification task
* Regression task

|Algorithm Name|  Description |  Type |
|---|---|---|
| Linear regression | Finds a way to correlate each feature to the output to help predict future values. | Regression
| Logistic regression | Extension of linear regression that's used for classification tasks. The output variable 3is binary (e.g., only black or white) rather than continuous (e.g., an infinite list of potential colors)| Classification
| Decision tree | Highly interpretable classification or regression model that splits data-feature values into branches at decision nodes (e.g., if a feature is a color, each possible color becomes a new branch) until a final decision output is made| Regression Classification
| Naive Bayes|The Bayesian method is a classification method that makes use of the Bayesian theorem. The theorem updates the prior knowledge of an event with the independent probability of each feature that can affect the event. | Regression Classification
| Support vector machine | Support Vector Machine, or SVM, is typically used for the classification task. SVM algorithm finds a hyperplane that optimally divided the classes. It is best used with a non-linear solver. | Regression (not very common) Classification
| Random forest | The algorithm is built upon a decision tree to improve the accuracy drastically. Random forest generates many times simple decision trees and uses the 'majority vote' method to decide on which label to return. For the classification task, the final prediction will be the one with the most vote; while for the regression task, the average prediction of all the trees is the final prediction. | Regression Classification
| AdaBoost | Classification or regression technique that uses a multitude of models to come up with a decision but weighs them based on their accuracy in predicting the outcome. | Regression Classification
| Gradient-Boosting Trees | Gradient-boosting trees is a state-of-the-art classification/regression technique. It is focusing on the error committed by the previous trees and tries to correct it. | Regression Classification

#### Unsupervised Learning

* In unsupervised learning, an algorithm explores input data without being given an explicit output variable.
  (e.g., explores customer demographic data to identify patterns)
* You can use it when you do not know how to classify the data,
  and you want the algorithm to find patterns and classify the data for you.

|Algorithm Name|  Description |  Type |
|---|---|---|
|K-means clustering | Puts data into some groups (k) that each contains data with similar characteristics (as determined by the model, not in advance by humans) | Clustering |
|Gaussian mixture model | A generalization of k-means clustering that provides more flexibility in the size and shape of groups (clusters) | Clustering |
| Hierarchical clustering | Splits clusters along a hierarchical tree to form a classification system. Can be used for Cluster loyalty-card customer | Clustering |
| Recommender system | Help to define the relevant data for making a recommendation. | Clustering |
| PCA/T-SNE | Mostly used to decrease the dimensionality of the data. The algorithms reduce the number of features to 3 or 4 vectors with the highest variances. | Dimension Reduction |

#### Areas for Application of Machine learning

* Augmentation
* Automation
* Finance Industry
* Government organization
* Healthcare industry
* Marketing


## Deep Learning
