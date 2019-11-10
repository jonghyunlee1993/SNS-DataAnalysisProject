rm(list=ls())

library(pscl)

data = read.csv("meta_data_result.csv")

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
