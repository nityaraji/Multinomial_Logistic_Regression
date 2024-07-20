path<-"C:/Users/nitya/OneDrive/Documents/Multinomial_Logistic_Regression/HepatitisCdata.csv"
HepCdataset=read.csv(path)
head(HepCdataset)
HepCdataset$Age[is.na(HepCdataset$Age)]<-mean(HepCdataset$Age,na.rm=TRUE)
HepCdataset$ALB[is.na(HepCdataset$ALB)]<-mean(HepCdataset$ALB,na.rm=TRUE)
HepCdataset$ALP[is.na(HepCdataset$ALP)]<-mean(HepCdataset$ALP,na.rm=TRUE)
HepCdataset$ALT[is.na(HepCdataset$ALT)]<-mean(HepCdataset$ALT,na.rm=TRUE)
HepCdataset$AST[is.na(HepCdataset$AST)]<-mean(HepCdataset$AST,na.rm=TRUE)
HepCdataset$BIL[is.na(HepCdataset$BIL)]<-mean(HepCdataset$BIL,na.rm=TRUE)
HepCdataset$CHE[is.na(HepCdataset$CHE)]<-mean(HepCdataset$CHE,na.rm=TRUE)
HepCdataset$CHOL[is.na(HepCdataset$CHOL)]<-mean(HepCdataset$CHOL,na.rm=TRUE)
HepCdataset$CREA[is.na(HepCdataset$CREA)]<-mean(HepCdataset$CREA,na.rm=TRUE)
HepCdataset$GGT[is.na(HepCdataset$GGT)]<-mean(HepCdataset$GGT,na.rm=TRUE)
HepCdataset$PROT[is.na(HepCdataset$PROT)]<-mean(HepCdataset$PROT,na.rm=TRUE)

HepCdataset$Sex = factor(HepCdataset$Sex,
                     levels = c('f','m'),
                     labels = c(0,1))


HepCdataset$Category = factor(HepCdataset$Category,
                          levels = c('0=Blood Donor',
                                     '0s=suspect Blood Donor',
                                     '1=Hepatitis',
                                     '2=Fibrosis',
                                     '3=Cirrhosis'),
                          labels = c('Blood Donor', 'suspect Blood Donor', 'Hepatitis', 'Fibrosis', 'Cirrhosis'))
HepCdataset=subset(HepCdataset,select=-c(X))
head(HepCdataset)



library(tidyverse)
library(caret)
theme_set(theme_bw())
# Inspect the data
sample_n(HepCdataset, 3)
# Split the data into training and test set
set.seed(123)
training.samples <- HepCdataset$Category %>% 
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- HepCdataset[training.samples, ]
test.data <- HepCdataset[-training.samples, ]

library(nnet)
# Setting the reference
train.data$Category <- relevel(train.data$Category,ref = "Blood Donor")
# Training the multinomial model
multinom_model <- multinom(Category ~ ., data = HepCdataset)
# Checking the model
summary(multinom_model)


exp(coef(multinom_model))
#head(round(fitted(multinom_model), 2))


# Predicting the values for train dataset
train.data$CategoryPredicted <- predict(multinom_model, newdata = train.data, "class")
# Building classification table
acc_train <- table(train.data$Category, train.data$CategoryPredicted)
# Calculating accuracy - sum of diagonal elements divided by total obs
round((sum(diag(acc_train))/sum(acc_train))*100,2)



# Predicting the class for test dataset
test.data$CategoryPredicted <- predict(multinom_model, newdata = test.data, "class")
# Building classification table
acc_test <- table(test.data$Category, test.data$CategoryPredicted)
round((sum(diag(acc_test))/sum(acc_test))*100,2)

