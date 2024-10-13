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
vids <- read.csv("data_input/youtubetrends_2023.csv", stringsAsFactors = TRUE, encoding = "latin1")

# cleansing data
vids_clean <- vids %>% 
  
  # deselect kolom yang tidak dibutuhkan
  select(-c(comments_disabled, ratings_disabled, video_error_or_removed)) %>% 
  
  # manipulasi kolom
  mutate(
    
    # mengubah tipe data
    trending_date = ymd(trending_date),
    publish_time = ymd_hms(publish_time),
    title = as.character(title),
    channel_title = as.character(channel_title),
    
    # menambah kolom baru
    likesp = likes/views,
    dislikep = dislikes/views,
    commentp = comment_count/views
    
  )