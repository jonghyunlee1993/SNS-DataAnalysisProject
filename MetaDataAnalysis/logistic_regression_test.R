rm(list=ls())

library(pscl)

data = read.csv("~/Downloads/meta_data_result.csv")

model = glm(IsDepress ~ X0 + X1 +  X2 +  X3 +  X4 + X5 + X6 + X7 + X8 + X9 + X10 +
              X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 + X21 + X23, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model)
exp(model$coefficients)

anova(model, test="Chisq")

model2 = glm(IsDepress ~ X0 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X11 + X13 +
               X15 + X19 + X20 + X21 + X23, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model2)

anova(model, model2)

model3 = glm(IsDepress ~ X0 + X1 + X2 + X5 + X6 + X7 + X8 + X13 + X15 + X19 + X20 + X21,
             family = "binomial"(link = "logit"), data=data)
summary(model3)

model4 = glm(IsDepress ~ X1 + X2 + X5 + X8 + X15 + X20 + X21, 
             family = "binomial"(link = "logit"), data=data)
summary(model4)
anova(model4, test="Chisq")
pR2(model4)


model5 = glm(IsDepress ~ X1 + X2 + X8 + X15 + X20 + X21, 
             family = "binomial"(link = "logit"), data=data)
summary(model5)
pR2(model5)

model6 = glm(IsDepress ~ X1 + X2 + X20 + X21,
             family = "binomial"(link = "logit"), data=data)
summary(model6)
pR2(model6)

model7 = glm(IsDepress ~ X1 + X20 + X21,
             family = "binomial"(link = "logit"), data = data)
summary(model7)
pR2(model7)
