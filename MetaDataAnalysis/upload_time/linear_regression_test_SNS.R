rm(list=ls())

data = read.csv("~/Downloads/meta_data_result.csv")

model = lm(depression ~ X0 + X1 +  X2 +  X3 +  X4 + X5 + X6 + X7 + X8 + X9 + X10 +
             X11 + X12 + X13 + X14 + X15 + X16 + X17 + X18 + X19 + X20 + X21 + X23,
           data = data)
summary(model)

model2 = step(model, direction = "both")
summary(model2)

model3 = lm(depression ~ X2 + X4 + X5 + X6 + X8 + X12 + X13 + X15 +
              X19 + X20 + X21, data = data)
summary(model3)
