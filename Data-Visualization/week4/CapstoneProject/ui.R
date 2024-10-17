dashboardPage(
  
  # Bagian Header
  dashboardHeader(
    title = "Capstone Project"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("city")),
      menuItem("Product Category Analysis", tabName = "page2", icon = icon("store")),
      menuItem("Gender Analysis", tabName = "page3", icon = icon("venus-mars")),
      menuItem("Dataset", tabName = "page4", icon = icon("server"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "page1",
              fluidRow(
                infoBox(
                  width = 6,
                  title = "Total Stores",
                  value = comma(length(unique(supermarket$Branch))),
                  icon = icon("store"),
                  color = "red"
                ),
                infoBox(
                  width = 6,
                  title = "Total Product Categories",
                  value = comma(length(unique(supermarket$Product.line))),
                  icon = icon("cart-shopping"),
                  color = "black"
                )
              ),
              fluidRow(
                box(
                  width = 12,
                  plotlyOutput(outputId = "plot1_bar")
                )
              ),
              fluidRow(
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot3")
                ),
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot2")
                )
              )
      ),
      tabItem(tabName = "page2",
              fluidRow(
                box(
                  width = 12,
                  selectInput(
                    inputId = "input_category",
                    label = "Choose Product Category",
                    choices = unique(supermarket$Product.line),
                    selected = "Health and beauty"
                  )
                )
              ),
              fluidRow(
                box(
                  width = 12,
                  plotlyOutput(outputId = "plot2_lolipop")
                )
              ),
              fluidRow(
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot4")
                ),
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot7")
                )
              )
      ),
      tabItem(tabName = "page3",
              fluidRow(
                box(
                  width = 12,
                  tags$style(HTML("
                        .pretty-radio .shiny-input-container {
                           margin-top: 10px;
                           margin-bottom: 10px;
                        }
                        
                        .pretty-radio label {
                           font-size: 16px;       
                           font-weight: bold;     
                           color: #555555;        
                           padding-right: 10px;   
                           cursor: pointer;
                           transition: all 0.3s ease;
                        }
                        
                        .pretty-radio label:hover {
                           color: green;
                           background-color: #fff111;
                           border-radius: 50%;
                        }
                        
                        .pretty-radio input[type='radio']:checked {
                           background-color: #007bff;
                           border-color: #007bff;
                        }
                     ")),
                  div(class = "pretty-radio",radioButtons("radio", "Choose one:", choices = c("Male", "Female"), inline = TRUE)),
                  textOutput("selection")
                )
              ),
              fluidRow(
                box(
                  width = 12,
                  plotlyOutput(outputId = "plot3_lolipop")
                )
              ),
              fluidRow(
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot5")
                ),
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot6")
                )
              )
              ),
      tabItem(tabName = "page4",
              fluidRow(
                box(
                  width = 12,
                  title = "Data Supermarket in Yangon, Naypitaw and Mandalay in 2019",
                  DT::DTOutput(outputId = "dataset")
                )
              )
      )
    )
  )
)