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