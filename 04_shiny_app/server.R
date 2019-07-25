# ###############################################################################################-
# Author(s)     : Jens Linden
# Description   : Shiny Server 
# 
# STEP 1        : Function definitions
# STEP 2        : Reactive expressions
# STEP 3        : Output elements
# 
# STATUS        : DEV
#
# INPUT         : 
# OUTPUT        : 
# ###############################################################################################-

# ###############################################################################################-
# STEP 1: Function definitions ----
# ###############################################################################################-


shinyServer(function(input, output, session) {
  
  
  # #############################################################################################-
  # STEP 2: Observers (to have dynamic input elements) ----
  # #############################################################################################-
  
  
  # #############################################################################################-
  # STEP 3: Reactive expressions (to optimize runtime) ----
  # #############################################################################################-
  
  hotel_data <- reactive({
    # some processing
    dt <- readRDS("data/80_res_hot.rds")
    # Filter cluster
    if(input$sel_cluster != "all") {
      dt <- dt[clus == input$sel_cluster]
    }
    # Filter leader lagger
    if(input$sel_leadlag != "all") {
      dt <- dt[lead_lag == input$sel_leadlag]
    }
    # Filter city
    if(input$sel_city != "all") {
      dt <- dt[city == input$sel_city]
    }
    
    
    return(dt)
  })
  
  hotel_selected <- reactive({
    if(is.null(input$dt_hotel_list_rows_selected)){
      hot_sel <- NULL
    } else{
      dt <- hotel_data()
      hot_sel <- dt[input$dt_hotel_list_rows_selected, id_hot]
    }
    return(hot_sel)
  })
  
  # #############################################################################################-
  # STEP 4: Output elements ----
  # #############################################################################################-
  
  
  # =============================================================================================-
  # dt_hotel_list ----
  # Description     : 
  # Input           : 
  # Output          : 
  # Review status   : DEV
  # =============================================================================================-
  output$dt_hotel_list <- DT::renderDataTable({
    data <- hotel_data()
    dt <- DT::datatable(
      data, 
      options = list(paging = T, pageLength = 5, searching = T, sort = T, scrollX = T),
      rownames = F, 
      selection = "single" 
    ) %>%
      formatRound(c("score_clus_mean", "score_hot_mean", "score_q25", "score_q75", "score_dist_mean"),
                  digits = 1) 
    return(dt)
  })
  
  # =============================================================================================-
  # map_hotel ----
  # Description     : 
  # Input           : 
  # Output          : 
  # Review status   : DEV
  # =============================================================================================-
  output$map_hotel <- renderLeaflet({
    data <- hotel_data()
    # Only show one hotel when selected
    if(!is.null(hotel_selected())) {
      data <- data[id_hot == hotel_selected()]
    }
    leaflet(data = data) %>% 
      addProviderTiles('OpenStreetMap.Mapnik') %>% 
      addMarkers(popup = ~Hotel_Address, clusterOptions = markerClusterOptions())
  })
  
  # =============================================================================================-
  # plot_benchmarks ----
  # Description     : Plot plot_benchmarks 
  # Input           : 
  # Output          : 
  # Review status   : 
  # =============================================================================================-
  output$plot_benchmarks <- renderPlot({
    if (is.null(hotel_selected()))
      return(NULL)
    
    dt <- hotel_data()
    # Get hotel info
    clus_hot <- dt[id_hot == hotel_selected(), clus]
    target <- dt[id_hot == hotel_selected(), unique(score_q75)]
    val <- dt[id_hot == hotel_selected(), score_hot_mean]
    p <- ggplot(dt[clus == clus_hot]) +
      geom_density(aes(x = score_hot_mean), fill = opt$ci$vibrant_blue, color = "white")  + 
      geom_vline(xintercept = target, color = opt$ci$deep_purple, size = 2) +
      geom_vline(xintercept = val, color = opt$ci$tech_red, size = 2, linetype="solid") +
      geom_label_repel(data = data.table(x = c(target, val)), 
                       aes(x = x, y = 0), 
                       label = c(paste0("Target value: ", round(target)), 
                                 paste0("Your hotel: ", round(val))), 
                       box.padding = unit(0.5, "lines"),
                       point.padding = unit(0.5, "lines"),
                       segment.color = 'black',
                       color = "black",
                       size = 6) +
      xlab("Mean hotel score") + 
      theme(text = element_text(size = 14)) 
    return(p)
  })
  
  # =============================================================================================-
  # Description     : close the R session when browser closes
  # Input           : 
  # Output          : 
  # Review status   : QC
  # =============================================================================================-
  session$onSessionEnded(function() { 
    stopApp()
  })
} # End shinyServer function
) # End shinyServer
