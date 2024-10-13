
function(input, output, session) {

    output$plot1_bar <- renderPlotly({
      
      
      # Data Wrangling
      vids_count <- vids_clean %>% 
        group_by(category_id) %>% 
        summarise(count = n()) %>% 
        ungroup() %>% 
        arrange(-count)
      
      vids_count <- vids_count %>% 
        mutate(
          label = glue(
            "Category: {category_id}
      Video count: {count}"
          )
        )
      
      # Visualization
      plot1 <- ggplot(data = vids_count, aes(x = count, 
                                             y = reorder(category_id, count),
                                             text = label)) + # reorder(A, berdasarkan B)
        geom_col(aes(fill = count)) +
        scale_fill_gradient(low="red", high="black") +
        labs(title = "Trending Categories of YouTube US 2023",
             x = "Video Count",
             y = NULL) +
        scale_x_continuous(labels = comma) +
        theme_minimal() +
        theme(legend.position = "none")
      
      ggplotly(plot1, tooltip = "text")
      
      
    })
    
    
    output$plot2_lolipop <- renderPlotly({
      
      # Data wrangling
      vids_10 <- vids_clean %>%
        filter(category_id== input$input_category ) %>%
        group_by(channel_title) %>% 
        summarise(mean_viewers = mean(views)) %>% 
        ungroup() %>% 
        arrange(-mean_viewers) %>%
        head(10)
      
      vids_10 <- vids_10 %>% 
        mutate(label = glue(
          "Channel : {channel_title}
       Average Views: {comma(mean_viewers)}"
        )
        )
      
      # Visualization
      plot2 <- ggplot(vids_10, aes(x = reorder(channel_title, mean_viewers), 
                                   y = mean_viewers,
                                   text = label)) +
        
        geom_segment(aes(xend=reorder(channel_title, mean_viewers), y=0,yend=mean_viewers), color="red") +
        geom_point(color="black", size=3) +
        coord_flip() +
        scale_y_continuous(labels = comma) +
        labs(title = glue("Top 10 Channel on {input$input_category}"),
             x = NULL,
             y = "Average View") +
        theme_minimal()
      
      ggplotly(plot2, tooltip = "text")
      
    })
    
    
    output$plot3_line <- renderPlotly({
      
      # Data wrangling
      vids_trend <- vids_clean %>% 
        filter(category_id == input$input_category) %>% 
        group_by(publish_hour) %>% 
        summarise(avg_views = mean(views)) %>% 
        ungroup() %>% 
        mutate(
          label2 = glue(
            "Publish Hour: {publish_hour}
      Average views: {comma(round(avg_views, 2))}"
          )
        )
      
      # Visualization
      plot3 <- ggplot(vids_trend, aes(x=publish_hour, y= avg_views))+
        geom_line(col="red") +
        geom_point(aes(text=label2), col="black") +
        scale_y_continuous(labels = comma , breaks = seq(0, 8000000, 1000000)) +
        scale_x_continuous(breaks = seq(0,23,1)) +
        labs(
          title = glue("Viewers Activity of {input$input_category} Videos"),
          x = "Publish Hours",
          y = "Average Views"
        ) +
        theme_minimal()
      
      ggplotly(plot3, tooltip = "text")
      
    })
    
    
    # ---- Kode untuk menampilkan dataset table
    output$dataset <- DT::renderDT(
      vids_clean,
      options = list(scrollX = TRUE,  # Memungkinkan scroll horizontal
                     scrollY = TRUE)  # Memungkinkan scroll vertikal
    )
    

}
