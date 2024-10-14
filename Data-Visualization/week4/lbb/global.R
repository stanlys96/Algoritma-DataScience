library(shiny)
library(shinydashboard)

# import library
library(dplyr)
library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(lubridate)
options(scipen = 100)

# read data
supermarket <- read.csv("supermarket.csv", stringsAsFactors = TRUE, encoding = "latin1")
supermarket$Date <- as.Date(supermarket$Date, format = "%m/%d/%Y")
supermarket$Month <- format(supermarket$Date, "%B")
supermarket$Month <- factor(supermarket$Month, levels = month.name)

supermarket <- supermarket %>% mutate(Week = week(Date))

week_group <- supermarket %>% group_by(Week) %>% summarise(total = sum(Total)) %>% ungroup()