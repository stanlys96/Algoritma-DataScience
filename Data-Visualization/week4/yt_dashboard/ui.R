dashboardPage(
  
  skin = "red",
  
  
  # ------- Bagian Header -------
  dashboardHeader(
    title = "Youtube Analysis"
  ),
  
  
  # ------- Bagian Sidebar -------
  dashboardSidebar(
    
    sidebarMenu(
      
      # ---- Tab 1: Overview ----
      menuItem("Overview", tabName = "page1", icon = icon("video")),
      
      # ---- Tab 2: Channel Analysis ----
      menuItem("Channel Analysis", tabName = "page2", icon = icon("youtube")),
      
      # ---- Tab 3: Dataset ----
      menuItem("Dataset", tabName = "page3", icon = icon("server"))
    
      )
    
    
    
  ),
  
  
  # ------- Bagian Body -------
  dashboardBody(
    
    
    
    tabItems(
      # ----- Tab 1 ----
      tabItem(tabName = "page1",
              
              # ------- Tab 1, Row 1
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
                  value =  comma(length(unique(vids_clean$channel_title))),
                  icon = icon("headset"),
                  color = "black"
                )
                
                
                
              ),
              
              # ------- Tab 1, Row 2
              fluidRow(
                
                box(
                  width = 12,
                  
                  plotlyOutput(outputId = "plot1_bar")
                  
                )
                
              )
              
              
              ),
      
      # ----- Tab 2 ----
      tabItem(
        tabName = "page2",
        
        # ----- Page 2 Row 1
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
        
        # ----- Page 2 Row 2
        
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
      
      # ----- Tab 3 ----
      tabItem(
        tabName = "page3",
        fluidRow(
          box(
            width = 12,
            title = "Data US Youtube Trending 2023",
            DT::DTOutput(outputId = "dataset")  # Menyediakan output untuk tabel
          )
        )      
              
              )
    )
    
  )
  
  
)