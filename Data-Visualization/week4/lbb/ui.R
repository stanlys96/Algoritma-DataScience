dashboardPage(
  
  # Bagian Header
  dashboardHeader(
    title = "Supermarket Analysis"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "page1", icon = icon("city")),
      menuItem("Supermarket Analysis", tabName = "page2", icon = icon("store")),
      menuItem("Dataset", tabName = "page3", icon = icon("server"))
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
                  plotlyOutput(outputId = "plot2")
                ),
                box(
                  width = 6,
                  plotlyOutput(outputId = "plot3")
                )
              )
      ),
      tabItem(tabName = "page2",
              fluidRow(
                box(
                  width = 12,
                  selectInput(
                    inputId = "input_city",
                    label = "Choose city",
                    choices = unique(supermarket$City),
                    selected = "Yangon"
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
                  width = 12,
                  plotlyOutput(outputId = "plot4")
                )
              )
      ),
      tabItem(tabName = "page3",
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