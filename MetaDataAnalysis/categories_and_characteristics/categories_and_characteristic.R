rm(list=ls())

setwd("~/GitRepo/SNS_Data_Analyses/")
data = read.csv("./data/sns_res_total.csv")

data = data[-c(5,15), ]
uptime = uptime[,-c(1, length(uptime))]

find_idx = function(pattern, data){
  res = grep(pattern, colnames(data))
  return(res)
}

ratio = NULL
for (sub in 1:nrow(uptime)){
  ratio = rbind(ratio, uptime[sub,] / sum(uptime[sub,]))
}

# y for characteristic
library(MASS)
find_model = function(pattern){
  data = data.frame(y = data[, find_idx(pattern, data)], data[, find_idx("abstract", data):find_idx("trans", data)])
  model = lm(y ~ ., data = data)
  step_model = stepAIC(model, direction = "both", trace = FALSE)
  print(summary(step_model))
  return(step_model)
}

start = find_idx("extraversion", data)
end = find_idx("social_media_2", data)

for (my_pattern in colnames(data[, start:end])){
  cat(strrep("-", 60), "\n")
  cat("\t\t\t", my_pattern, "\n")
  cat(strrep("-", 60), "\n")
  find_model(my_pattern)
}

# y for categories
find_model = function(pattern){
  data = data.frame(y = data[, find_idx(pattern, data)[1]], data[, find_idx("extraversion", data):find_idx("social_media_2", data)])
  model = lm(y ~ ., data = data)
  step_model = stepAIC(model, direction = "both", trace = FALSE)
  print(summary(step_model))
  return(step_model)
}

start = find_idx("abstract", data)[1]
end = find_idx("trans", data)[1]

for (my_pattern in colnames(data[, start:end])){
  cat(strrep("-", 60), "\n")
  cat("\t\t\t", my_pattern, "\n")
  cat(strrep("-", 60), "\n")
  find_model(my_pattern)
}

# make model y is categories
start = find_idx("extraversion", data)
end = find_idx("social_media_2", data)

make_full_model = function(pattern){
  model_data = data.frame(y = data[, find_idx(pattern, data)[1]], data[, start:end])
  model_data[model_data[, 1] < 0.0001, 1] = NA
  model_data = na.omit(model_data)
  
  model = lm(y ~., data = model_data)
  
  # step_model = stepAIC(model, direction = "both", trace = FALSE)
  step_model = step(model, direction = "both", trace = 0)
  print(summary(step_model))
  # print(summary(model))
  # return(model)
}

make_full_model("animal")

for (my_pattern in colnames(data[5:18])){
  cat(strrep("-", 60), "\n")
  cat("\t\t\t", my_pattern, "\n")
  cat(strrep("-", 60), "\n")
  make_full_model(my_pattern)
}
