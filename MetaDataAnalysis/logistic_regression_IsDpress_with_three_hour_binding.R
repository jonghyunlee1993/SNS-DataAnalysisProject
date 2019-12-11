rm(list=ls())

library(pscl)

data = read.csv("../data/upload_time_result_three_hour_binding.csv")

model = glm(IsDepress ~ X0 + X1 + X2 + X3 + X4 + X5 + X6 + X7, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model)

model2 = glm(IsDepress ~ X0 + X1 + X2 + X3 + X4 + X5 + X7, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model2)

model3 = glm(IsDepress ~ X0 + X1 + X2 + X3 + X5 + X7, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model3)

model4 = glm(IsDepress ~ X0 + X1 + X2 + X5 + X7, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model4)

model5 = glm(IsDepress ~ X0 + X1 + X2 + X5, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model5)

model6 = glm(IsDepress ~ X0 + X1 + X2, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model6)

model7 = glm(IsDepress ~ X0 + X2, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model7)

model8 = glm(IsDepress ~ X0, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model8)
pR2(model8)
