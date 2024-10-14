library(shiny)
library(shinydashboard)

library(dplyr)
library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(lubridate)
library(DT)
options(scipen = 100)

supermarket <- read.csv("supermarket.csv", stringsAsFactors = TRUE, encoding = "latin1")

supermarket