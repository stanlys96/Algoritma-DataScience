function(input, output, session) {
  output$plot1_bar <- renderPlotly({
    week_group <- week_group %>% 
      mutate(label = glue(
        "Week : {Week}
       Total Sales: {comma(total)}"
      ))
    plot3 <- ggplot(week_group, aes(x = Week, y = total, group = 1, text = label)) +
      geom_line(col = "red") +   # Add a red line
      geom_point() +             # Optionally, add points at each month
      labs(title = "Sales Progress Each Week",
           x = "Week",
           y = NULL) +
      scale_y_continuous(labels = scales::comma, limits = c(0, NA)) +  
      scale_x_continuous(breaks = seq(1,nrow(week_group),1))
    
    ggplotly(plot3, tooltip = "text")
    
  })
  
  output$plot3 <- renderPlotly({
    branch_group <- supermarket %>% group_by(City) %>% summarise(total = sum(Total)) %>% ungroup() %>% 
      mutate(label = glue(
        "City : {City}
       Total Sales: {comma(total)}"
      )
      )
    
    plot2 <- ggplot(branch_group, aes(x = City, y = total, text = label)) +
      labs(title = "Total sales based on city",
           x = "City",
           y = NULL) +
      scale_y_continuous(labels = scales::comma, limits = c(0, NA)) +  
      theme_minimal() +
      theme(legend.position = "none") +
      geom_col(aes(fill = City))
    
    ggplotly(plot2, tooltip = "text")
  })
  
  output$plot2 <- renderPlotly({
    branch_group <- supermarket %>% group_by(Payment) %>% summarise(total = sum(Total)) %>% ungroup() %>% 
      mutate(label = glue(
        "Payment Method : {Payment}
       Total Sales: {comma(total)}"
      )
      )
    
    plot2 <- ggplot(branch_group, aes(x = Payment, y = total, text = label)) +
      labs(title = "Total sales based on payment method",
           x = "Payment Method",
           y = NULL) +
      scale_y_continuous(labels = scales::comma, limits = c(0, NA)) +  
      theme_minimal() +
      theme(legend.position = "none") +
      geom_col(aes(fill = Payment))
    
    ggplotly(plot2, tooltip = "text")
  })
  
  output$plot2_lolipop <- renderPlotly({
    
    # Data wrangling
    supermarket_filter <- supermarket %>%
      filter(City == input$input_city) %>%
      group_by(Product.line) %>% 
      summarise(total_sales = sum(Total)) %>% 
      ungroup() %>% 
      arrange(-total_sales)
    
    supermarket_filter <- supermarket_filter %>% 
      mutate(label = glue(
        "Product : {Product.line}
       Total Sales: {comma(total_sales)}"
      )
      )
    
    # Visualization
    plot2 <- ggplot(supermarket_filter, aes(x = Product.line, 
                                 y = total_sales,
                                 text = label)) +
      
      geom_col(aes(fill = Product.line)) +
      scale_y_continuous(labels = comma) +
      theme_minimal() +
      theme(legend.position = "none") +
      labs(title = glue("Total sales in {input$input_city}"),
           x = NULL,
           y = NULL) 
    ggplotly(plot2, tooltip = "text")
    
  })
  
  output$plot4 <- renderPlotly({
    supermarket_filter <- supermarket %>%
      filter(City == input$input_city) %>% 
      group_by(Week) %>% 
      summarise(total = sum(Total))
    
    plot4 <- ggplot(supermarket_filter, aes(x = Week, y = total, group = 1)) +
      geom_line(col = "red") +   # Add a red line
      geom_point() +             # Optionally, add points at each month
      scale_y_continuous(labels = scales::comma, limits = c(0, NA)) +  
      scale_x_continuous(breaks = seq(1,nrow(supermarket_filter),1)) + 
      labs(title = glue("Sales progress in {input$input_city}"),
           x = "Week",
           y = NULL) 
    
    ggplotly(plot4)
    
  })
  
  output$dataset <- DT::renderDT(
    supermarket,
    options = list(scrollX = TRUE,  # Memungkinkan scroll horizontal
                   scrollY = TRUE)  # Memungkinkan scroll vertikal
  )
}