library(readxl)
restaurant_data <- read_excel("pathh/data.xlsx")
country_code <- read_excel("path/Country-Code.xlsx")

merged_data <- merge(restaurant_data, country_code, by = "Country Code", all.x = TRUE)
# structure of data

str(merged_data)

library(tidyr)

#missing data detection
sapply(merged_data, function(x) sum(is.na(x)))
cleaned_data <- drop_na(merged_data)


# Only 1 missing value in the Restaurant Name column.
# 9 missing values in the Cuisines column.
str(cleaned_data)
library(dplyr)
# Checking for duplicate Records
duplicates <- cleaned_data %>% distinct()
str(duplicates)



# replace wrong city naming 
cleaned_data$City[cleaned_data$City == "Cedar Rapids/Iowa City"] <- "Cedar Rapids"
cleaned_data$City[cleaned_data$City == "Rest of Hawaii"] <- "Hawaii"
cleaned_data$City[cleaned_data$City == "BrasÌ_lia"] <- "Brasília"
cleaned_data$City[cleaned_data$City == "SÌ£o Paulo"] <- "São Paulo"
cleaned_data$City[cleaned_data$City == "€¡stanbul"] <- "Istanbul"
cleaned_data$City[cleaned_data$City == "Tampa Bay"] <- "Tampa"
distinct_cities <- cleaned_data%>%
  distinct(City)
print(distinct_cities)
dim(cleaned_data)

# Rename columns to remove spaces preventing error from names
names(cleaned_data) <- gsub(" ", ".", names(cleaned_data))


distinct_currencies <- cleaned_data%>%
  distinct(Currency)
print(distinct_currencies)


cleaned_data <- cleaned_data %>%
  mutate(Standardized.Price = case_when(
    Currency == "Indian Rupees(Rs.)" ~ `Average.Cost.for.two`,
    Currency == "Dollar($)" ~ `Average.Cost.for.two` * 75,   
    Currency == "Brazilian Real(R$)" ~ `Average.Cost.for.two`* 15,
    Currency == "Indonesian Rupiah(IDR)" ~ `Average.Cost.for.two` * 0.005,
    Currency == "NewZealand($)" ~ `Average.Cost.for.two` * 50,
    TRUE ~ NA_real_  # For any unmatched currency
  ))
print(cleaned_data)
# Explore the geographical distribution of the restaurants
str(cleaned_data)


city_column <- cleaned_data$City  
print(head(city_column))
          
library(dplyr)


city_distribution <- cleaned_data %>%
    count(City = City, sort = TRUE)
View(city_distribution)

max_city <- city_distribution[which.max(city_distribution$n), ]
min_city <- city_distribution[which.min(city_distribution$n), ]
View(max_city)
View(min_city)


#  distribution of overall ratings
library(ggplot2)


summary(cleaned_data$Aggregate.rating)


ggplot(cleaned_data, aes(x = Aggregate.rating)) +
  geom_histogram(binwidth = 0.5, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Restaurant Ratings", 
       x = "Aggregate Rating", 
       y = "Count of Restaurants") +
  theme_minimal()

#franchise with most national presence

franchise_distribution <- cleaned_data %>%
  count(Restaurant.Name, sort = TRUE)

# top 10 franchise
View(head(franchise_distribution,10))


library(dplyr)
library(ggplot2)




#restaurants with table booking vs without table booking
table_booking_ratio <- cleaned_data %>%
  group_by(Has.Table.booking) %>%
  summarize(count = n()) %>%
  mutate(ratio = count / sum(count))

View(table_booking_ratio)

#restaurants providing online delivery
online_delivery_percentage <- cleaned_data %>%
  group_by(Has.Online.delivery) %>%
  summarize(count = n()) %>%
  mutate(percentage = (count / sum(count)) * 100)
cleaned_data$Has.Online.delivery

ggplot(online_delivery_percentage, aes(x =Has.Online.delivery, y = percentage)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentage of Restaurants Providing Online Delivery", x = "Online Delivery", y = "Percentage")

#  no. of votes for the restaurants that deliver and the restaurant without Delivery
vote_difference <- cleaned_data %>%
  group_by(Has.Online.delivery) %>%
  summarize(avg_votes = mean(Votes))

ggplot(vote_difference, aes(x = Has.Online.delivery, y = avg_votes, fill = `Has.Online.delivery`)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Votes for Restaurants with and without Online Delivery", x = "Online Delivery", y = "Average Votes")

# top 10 cuisines across 10 cities
top_cuisines <- cleaned_data %>%
  count(Cuisines, sort = TRUE) %>%
  head(10)
View(top_cuisines)
# maximum and minimum number of cuisines served

head(cleaned_data$Cuisines)
str(cleaned_data)
 # Count the number of cuisines for each restaurant

cleaned_data <- cleaned_data %>%
  mutate(num_cuisines = sapply(strsplit(Cuisines, ", "), length))


max_cuisines <- max(cuisine_data$num_cuisines)
min_cuisines <- min(cuisine_data$num_cuisines)


cat("Maximum number of cuisines served by a restaurant:", max_cuisines, "\n")
cat("Minimum number of cuisines served by a restaurant:", min_cuisines, "\n")
str(cleaned_data)
# relation between no of cuisines vs Ratings
head(cleaned_data %>% select(num_cuisines , Aggregate.rating))

#scatter plot
ggplot(cleaned_data, aes(x = num_cuisines, y = Aggregate.rating)) +
  geom_point(alpha = 0.6, color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Adding a linear trend line
  labs(title = "Relationship between Number of Cuisines and Aggregate Ratings",
       x = "Number of Cuisines",
       y = "Aggregate Rating") +
  theme_minimal()

correlation <- cor(cleaned_data$num_cuisines, cleaned_data$Aggregate.rating, use = "complete.obs")

cat("Correlation between Number of Cuisines and Aggregate Rating:", correlation, "\n")
str(cleaned_data)
# Correlation between cost and ratings
cor_cost_rating <- cor(cleaned_data$`Standardized.Price`, cleaned_data$Aggregate.rating, use = "complete.obs")

# Correlation between cost and number of cuisines
cor_cost_cuisines <- cor(cleaned_data$`Standardized.Price`, cleaned_data$num_cuisines, use = "complete.obs")

# Print the results
cat("Correlation between Cost and Rating:", cor_cost_rating, "\n")
cat("Correlation between Cost and Number of Cuisines:", cor_cost_cuisines, "\n")

#regression analysis
names(cleaned_data)


rating_model2 <- lm(Aggregate.rating ~ num_cuisines +Standardized.Price+Has.Online.delivery + Votes , data = cleaned_data)
summary(rating_model2)

# Create a new data frame for predictions
prediction_data <- cleaned_data %>%
  mutate(predicted_rating = predict(rating_model2, newdata = cleaned_data))

ggplot(cleaned_data, aes(x = num_cuisines, y = `Aggregate.rating`)) +
  geom_point(alpha = 0.5) +
  geom_line(data = prediction_data, aes(y = predicted_rating), color = "blue", size = 1) +
  facet_wrap(~ `Has.Online.delivery`) +  # Use dots in the variable name here
  labs(title = "Aggregate Rating vs Number of Cuisines",
       x = "Number of Cuisines",
       y = "Aggregate Rating") +
  theme_minimal()

print(prediction_data)

# Fit the model
rating_model <- lm(`Aggregate.rating` ~ num_cuisines + Standardized.Price + `Has.Online.delivery` + Votes, data = cleaned_data)

# Create a new data frame for predictions
prediction_data <- data.frame(
  num_cuisines = c(1, 2, 3),  # Example values
  Standardized.Price = c(700, 800, 900),  # Example values
  `Has.Online.delivery` = c("Yes", "No", "Yes"),  # Example values
  Votes = c(100, 200, 150)  # Example values
)

# Make predictions
prediction_data$predicted_rating <- predict(rating_model, newdata = prediction_data)

# View predictions
print(prediction_data)




model_with_additional_predictors <- lm(
  formula = `Aggregate.rating` ~ poly(num_cuisines, 2) + Standardized.Price + Has.Online.delivery + Votes,
  data = cleaned_data
)

summary(model_with_additional_predictors)

# Create a new data frame for predictions 2
prediction_data2 <- data.frame(
  num_cuisines = c(1, 2, 3),  # Example values
  Standardized.Price = c(700, 800, 900),  # Example values
  `Has.Online.delivery` = c("Yes", "No", "Yes"),  # Example values
  Votes = c(100, 200, 150)  # Example values
)

# Make predictions
prediction_data2$predicted_rating <- predict(
model_with_additional_predictors, newdata = prediction_data2)

# View predictions
print(prediction_data2)

library("writexl")
library(openxlsx)

data <- data.frame(cleaned_data)
setwd("path/Final/Restuarant Analysis")
write.xlsx(data, "cleaned_data.xlsx")