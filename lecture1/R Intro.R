###################################################
### Intro to R (Parallel Stata Intro)           ###
### https://grodri.github.io/stata/tutorial.pdf ###
###################################################


# Set Working Directory #

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# Libraries #
library(ggplot2)

# Read-in CSV file to work with 

d1 <- read.csv("LFS_July17_21.csv", header = TRUE)

## Can also read-in data from web 

#d1 <- read.csv("https://raw.githubusercontent.com/MMaroto729/SOC-509/main/data/LFS_July17_21.csv", header=TRUE)

# Inspect the data

summary(d1) # Data summary #
dim(d1) # Data dimensions #
names(d1) # Variable names #
head(d1) # Fist six values #

# Change variable names to all lowercase (to match Stata code)

names(d1) <- tolower(names(d1))
names(d1)

# Generate and manipulate variables

d1$ontario <- rep(0,length(d1$prov))
d1$ontario[d1$prov == 35] <- 1
table(d1$ontario)

table(d1$ontario, d1$prov)

d1$edcat <- ifelse(d1$educ == 0, 0, 1)
table(d1$edcat)


# Descriptive statistics

summary(d1$educ)
summary(d1$hrlyearn)

table(d1$educ)

table(d1$educ[is.na(d1$hrlyearn)])

# Scatterplots

## Base R plot function 
plot(d1$educ, d1$hrlyearn, 
     main = "Education and Earnings",
     xlab = "Education",
     ylab = "Hourly Earnings")

## GGplot R function
ggplot(data = d1, aes(x=educ, y=hrlyearn)) +
  geom_point() +
      labs(y = "Dollars per hour", 
       x = "Education", 
       title = "Education and Earnings")

## GGplot with jittered points
ggplot(data = d1, aes(x=educ, y=hrlyearn)) +
  geom_point(position = "jitter", alpha = 1/5) +
      labs(y = "Dollars per hour", 
       x = "Education", 
       title = "Education and Earnings")

# Regression 

reg1 <- lm(d1$hrlyearn ~ d1$educ)
summary(reg1)

## Base R plot function 
plot(d1$educ, d1$hrlyearn, 
     main = "Education and Earnings",
     xlab = "Education",
     ylab = "Hourly Earnings")
abline(reg1)

## GGplot R function
ggplot(data = d1, aes(x=educ, y=hrlyearn)) +
  geom_point(position = "jitter", alpha = 1/5) +
  geom_smooth(method=lm) +
      labs(y = "Dollars per hour", 
       x = "Education", 
       title = "Education and Earnings")

# Use R as a calculator
2+2
2+2

