rm(list = ls())

setwd("~/GitRepo/SNS_Data_Analyses/")

# data for characteristic and upload image categories
data = read.csv("./data/sns_res_total.csv")[, -c(8:18)]

# dark ~ trans : 8:18
# dark.1 ~ trans.1 : 22:32

find_idx = function(pattern, data){
  res = grep(pattern, colnames(data))
  return(res)
}

start = find_idx("extraversion", data)
end = find_idx("social_media_2", data)

# make model y is categories
my_character = c("agreeableness", "conscientiousness", "neuroticism", "self_esteem",
                 "openness", "benign", "perceived_stress", "social_phobia",
                 "social_interaction_anxiety", "generalized_anxiety_disorder")

character_idx = NULL

for (idx in my_character){
  res = find_idx(idx, data)
  character_idx = c(character_idx, res)
}

make_model = function(pattern){
  library(MASS)
  model_data = data.frame(y = data[, find_idx(pattern, data)[1]], data[, character_idx])
  # model_data = data.frame(y = data[, find_idx(pattern, data)[1]], data[, start:end])
  model = lm(y ~ ., data = model_data)
  # print(summary(model))
  # return(model)
  
  final_model = stepAIC(model, direction = "both", trace = FALSE)
  return(final_model)
}

my_cateogories = c("dark", "drink", "food", "people", "plant")

dark_model = make_model("dark")
drink_model = make_model("drink")
food_model = make_model("food")
people_model = make_model("people")
plant_model = make_model("plant")

summary(dark_model)
summary(drink_model)
summary(food_model)
summary(people_model)
summary(plant_model)
