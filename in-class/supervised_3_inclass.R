set.seed(1984)
ids_train <- createDataPartition(1:nrow(news_dfm), p = 0.7, list = FALSE, times = 1)
train_x <- news_dfm[ids_train, ] %>% as.data.frame() # train set data
train_y <- news_samp$class[ids_train] %>% as.factor()  # train set labels
test_x <- news_dfm[-ids_train, ]  %>% as.data.frame() # test set data
test_y <- news_samp$class[-ids_train] %>% as.factor() # test set labels

# baseline
baseline_acc <- max(prop.table(table(test_y)))

# B. define training options (we've done this manually above)
trctrl <- trainControl(method = "none")
#trctrl <- trainControl(method = "LOOCV", p = 0.8)
# ?trainControl
# C. train model (caret gives us access to even more options)
# see: https://topepo.github.io/caret/available-models.html

# svm - linear
svm_mod_linear <- train(x = train_x,
                        y = train_y,
                        method = "svmLinear",
                        trControl = trctrl)

svm_linear_pred <- predict(svm_mod_linear, newdata = test_x)
svm_linear_cmat <- confusionMatrix(svm_linear_pred, test_y)

# svm - radial
svm_mod_radial <- train(x = train_x,
                        y = train_y,
                        method = "svmRadial",
                        trControl = trctrl)

svm_radial_pred <- predict(svm_mod_radial, newdata = test_x)
svm_radial_cmat <- confusionMatrix(svm_radial_pred, test_y)

cat(
  "Baseline Accuracy: ", baseline_acc, "\n",
  "SVM-Linear Accuracy:",  svm_linear_cmat$overall[["Accuracy"]], "\n",
  "SVM-Radial Accuracy:",  svm_radial_cmat$overall[["Accuracy"]]
)

# Original with .8 

# Baseline Accuracy:  0.6502463 
# SVM-Linear Accuracy: 0.7721675 
# SVM-Radial Accuracy: 0.6724138

# With .7
# 
# Baseline Accuracy:  0.6581967  (.8 pp increase)
# SVM-Linear Accuracy: 0.7655738  (.7 pp decrease (?))
# SVM-Radial Accuracy: 0.6680328 (.4 pp decrease (?))

# With .6

# Baseline Accuracy:  0.6674877 (1.7 pp increase)
# SVM-Linear Accuracy: 0.7740148 (.2 pp increase)
# SVM-Radial Accuracy: 0.671798 (.01 pp increase)

# With .5

# Baseline Accuracy:  0.6707677  (2 pp increase)
# SVM-Linear Accuracy: 0.7647638  (1 pp decrease)
# SVM-Radial Accuracy: 0.6732283 (.1 pp increase)

# With .3

# Baseline Accuracy:  0.6631505 (1.3 pp increase)
# SVM-Linear Accuracy: 0.7457806 (3 pp decrease)
# SVM-Radial Accuracy: 0.6631505 (1.4 pp decrease)


# Best performance seems to be partitioning around the original class distribution
# Still confused by the .7 accuracy dip!