rm(list=ls())

library(pscl)

data = read.csv("../data/meta_data_result.csv")

model = glm(IsDepress ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 +
              T11 + T12 + T13 + T14 + T15 + T16 + T17 + T18 + T19 + T20 + T21 + T23, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model)
eTp(model$coefficients)

anova(model, test="Chisq")

model2 = glm(IsDepress ~ T0 + T2 + T3 + T4 + T5 + T6 + T7 + T8 + T9 + T11 + T13 +
               T15 + T19 + T20 + T21 + T23, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model2)

anova(model, model2)

model3 = glm(IsDepress ~ T0 + T1 + T2 + T5 + T6 + T7 + T8 + T13 + T15 + T19 + T20 + T21,
             family = "binomial"(link = "logit"), data=data)
summary(model3)

model4 = glm(IsDepress ~ T1 + T2 + T5 + T8 + T15 + T20 + T21, 
             family = "binomial"(link = "logit"), data=data)
summary(model4)
anova(model4, test="Chisq")
pR2(model4)


model5 = glm(IsDepress ~ T1 + T2 + T8 + T15 + T20 + T21, 
             family = "binomial"(link = "logit"), data=data)
summary(model5)
pR2(model5)

model6 = glm(IsDepress ~ T1 + T2 + T20 + T21,
             family = "binomial"(link = "logit"), data=data)
summary(model6)
pR2(model6)

model7 = glm(IsDepress ~ T1 + T20 + T21,
             family = "binomial"(link = "logit"), data = data)
summary(model7)
pR2(model7)

model8 = glm(IsDepress ~ T1 + T20, 
             family = "binomial"(link = "logit"), data = data)
summary(model8)
pR2(model8)
anova(model8, test="Chisq")


find_idx = function(pattern, data){
  res = grep(pattern, colnames(data))
  return(res)
}

ratio = NULL
for (sub in 1:nrow(data)){
  ratio = rbind(ratio, data[sub, find_idx("T0", data):find_idx("T23", data)] / sum(data[sub, find_idx("T0", data):find_idx("T23", data)]))
}

# data = data[-c(5, 15), ]

depress_data = data.frame(y = data$IsDepress, ratio)

# full_model = glm(y ~ ., family = 'binomial'(link = 'logit'), maxit=100, data = depress_data)
# coef(full_model)
# summary(full_model)

model = glm(y ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 + 
              T11 + T12 + T13 + T14 + T15 + T16 + T17 + T18 + T19 + T20 + T21 + T23, 
            family = 'binomial'(link = 'logit'), data = depress_data)
summary(model)

model2 = glm(y ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 + 
               T11 + T12 + T13 + T14 + T15 + T17 + T18 + T19 + T20 + T21 + T23, 
             family = 'binomial'(link = 'logit'), data = depress_data)
summary(model2)

model3 = glm(y ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 + 
               T11 + T12 + T13 + T14 + T15 + T18 + T19 + T20 + T21 + T23, 
             family = 'binomial'(link = 'logit'), data = depress_data)
summary(model3)

model4 = glm(y ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 + 
               T11 + T12 + T13 + T15 + T18 + T19 + T20 + T21 + T23, 
             family = 'binomial'(link = 'logit'), data = depress_data)
summary(model4)

model5 = glm(y ~ T0 + T1 +  T2 +  T3 +  T4 + T5 + T6 + T7 + T8 + T9 + T10 + 
               T11 + T13 + T15 + T18 + T19 + T20 + T21 + T23, 
             family = 'binomial'(link = 'logit'), data = depress_data)
summary(model5)

# step_model = model %>% stepAIC(trace = F)
# coef(step_model)
# summary(step_model)



library(glmnet)
glmnet(x=depress_data[,-1], y = depress_data$y, family = "binomial", data = depress_data)

library(MASS)
library(dplyr)
step_model <- full_model %>% stepAIC(trace = FALSE)
coef(step_model)
summary(step_model)
