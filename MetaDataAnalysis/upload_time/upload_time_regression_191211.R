rm(list=ls())

setwd("~/GitRepo/SNS_Data_Analyses/data")

data = read.csv("upload_time_result_by_sub.csv")

ratio = NULL

for (sub in 1:nrow(data)){
  ratio = rbind(ratio, data[sub, 2:25] / sum(data[sub, 2:25]))
}

View(ratio)

meta_data = read.csv("meta_data_result.csv")
View(meta_data)

# return dataframe index number with index name
find_idx = function(pattern, data){
  res = grep(pattern, colnames(data))
  return(res)
}

find_idx("T0", meta_data)
find_idx("T23", meta_data)

# find participants without upload time data
temp = meta_data[,27:50]
meta_data$Code[which(rowSums(temp) == 0)]
which(rowSums(temp) == 0)

meta_data = meta_data[-c(5, 15), ]

find_idx("Popularity", meta_data)
find_idx("social_media_2", meta_data)

# make model fit data
model_data = data.frame(meta_data[, 8:25], ratio)

library(MASS)
# linear regression function with upload time
find_model = function(pattern){
  data = data.frame(y = model_data[, find_idx(pattern, model_data)], model_data[, find_idx("X0", model_data):find_idx("X23", model_data)])
  model = lm(y ~ ., data = data)
  step_model = stepAIC(model, direction = "both", trace = FALSE)
  print(summary(step_model))
  return(step_model)
}

# find models
start = find_idx("Popularity", model_data)
end = find_idx("social_media_2", model_data)

for (my_pattern in colnames(model_data[, start:end])){
  cat(strrep("-", 60), "\n")
  cat("\t\t\t", my_pattern, "\n")
  cat(strrep("-", 60), "\n")
  find_model(my_pattern)
}
