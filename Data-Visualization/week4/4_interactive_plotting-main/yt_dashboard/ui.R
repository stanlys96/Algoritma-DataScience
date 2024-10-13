dashboardPage(
  
  # Bagian Header
  dashboardHeader(
    title = "Youtube Analysis"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("video")),
      menuItem("Channel Analysis", tabName = "page2", icon = icon("youtube")),
      menuItem("Dataset", tabName = "page3", icon = icon("server"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1",
              fluidRow(
                infoBox(
                  width = 6,
                  title = "Total Video Count",
                  value = comma(nrow(vids_clean)),
                  icon = icon("youtube"),
                  color = "red"
                ),
                infoBox(
                  width = 6,
                  title = "Total Trending Channel",
                  value = comma(length(unique(vids_clean$channel_title))),
                  icon = icon("headset"),
                  color = "black"
                )
              ),
              fluidRow(
                  box(
                    width = 12,
                    plotlyOutput(outputId = "plot1_bar")
                  )
                )
              ),
      tabItem(tabName = "page2",
              fluidRow(
                box(
                  width = 12,
                  selectInput(
                    inputId = "input_category",
                    label = "Choose video category",
                    choices = unique(vids_clean$category_id),
                    selected = "Gaming"
                  )
                )
              ),
              fluidRow(
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot2_lolipop")
                ),
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot3_line")
                )
              )
              ),
      tabItem(tabName = "page3",
              fluidRow(
                box(
                  width = 12,
                  title = "Data US Youtube Trending 2023",
                  DT::DTOutput(outputId = "dataset")
                )
              ))
    )
  )
)