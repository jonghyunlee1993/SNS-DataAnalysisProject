rm(list=ls())

library(pscl)

data = read.csv("../data/upload_time_result_two_hour_binding.csv")

model = glm(IsDepress ~ X0 + X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model)

model1 = glm(IsDepress ~ X0 + X1 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11, 
            family = 'binomial'(link = 'logit'), data = data)
summary(model1)

model2 = glm(IsDepress ~ X0 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model2)

model3 = glm(IsDepress ~ X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model3)

model7 = glm(IsDepress ~ X3 + X4 + X5 + X6 + X8 + X9 + X10 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model7)

model8 = glm(IsDepress ~ X3 + X5 + X6 + X8 + X9 + X10 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model8)

model9 = glm(IsDepress ~ X3 + X5 + X6 + X8 + X10 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model9)

model10 = glm(IsDepress ~ X3 + X5 + X6 + X8 + X11, 
             family = 'binomial'(link = 'logit'), data = data)
summary(model10)

model11 = glm(IsDepress ~ X3 + X5 + X6 + X11, 
              family = 'binomial'(link = 'logit'), data = data)
summary(model11)

model12 = glm(IsDepress ~ X3 + X6 + X11, 
              family = 'binomial'(link = 'logit'), data = data)
summary(model12)

model13 = glm(IsDepress ~ X3 +  X11, 
              family = 'binomial'(link = 'logit'), data = data)
summary(model13)
