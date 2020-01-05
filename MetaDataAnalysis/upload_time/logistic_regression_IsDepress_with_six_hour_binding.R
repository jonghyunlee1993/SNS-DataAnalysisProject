rm(list=ls())

library(pscl)

data = read.csv("../data/upload_time_result_six_hour_binding.csv")

model = glm(IsDepress ~ X0 + X1 + X2 + X3, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model)

model1 = glm(IsDepress ~ X1 + X2 + X3, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model1)

model2 = glm(IsDepress ~ X2 + X3, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model2)

model2 = glm(IsDepress ~ X2, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model2)
