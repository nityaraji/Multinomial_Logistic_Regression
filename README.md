# Description
A multinomial logistic regression (or multinomial regression for short) is used when the outcome variable being predicted is nominal and has more than two categories that do not have a given rank or order. This model can be used with any number of independent variables that are categorical or continuous.

# Hepatitis C Data Analysis

This project involves the analysis and classification of Hepatitis C data using a multinomial logistic regression model.

## Project Overview

The aim of this project is to clean the Hepatitis C dataset, handle missing values, encode categorical variables, and build a multinomial logistic regression model to classify the category of the patients.

## Dataset

The dataset used in this project is stored in a CSV file named `HepatitisCdata.csv`. The dataset contains various medical and demographic features such as Age, ALB, ALP, ALT, AST, BIL, CHE, CHOL, CREA, GGT, PROT, Sex, and Category.

## Data Cleaning and Preparation

1. Handling Missing Values: Missing values in the numerical columns were replaced with the mean of the respective columns.
2. Encoding Categorical Variables:*
   - The `Sex` column was converted into a binary factor (0 for female, 1 for male).
   - The `Category` column was converted into a factor with levels `Blood Donor`, `suspect Blood Donor`, `Hepatitis`, `Fibrosis`, and `Cirrhosis`.
3. Dropping Unnecessary Columns: The `X` column was removed from the dataset.

## Model Building

The multinomial logistic regression model was built using the `nnet` package in R. The data was split into training and test sets with an 80-20 split. The model was trained on the training set, and predictions were made on both the training and test sets to evaluate the model's performance.

## Evaluation

The accuracy of the model was calculated for both the training and test sets. The results were as follows:
- Training Set Accuracy: 95.95%
- Test Set Accuracy: 95.87%
