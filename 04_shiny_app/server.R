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
    if(input$sel_cluster != "all") {
      dt <- dt[clus == input$sel_cluster]
    }
    return(dt)
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
    leaflet(data = data) %>% 
      addProviderTiles('OpenStreetMap.Mapnik') %>% 
      addMarkers(popup = ~Hotel_Address, clusterOptions = markerClusterOptions())
  })
  
  # =============================================================================================-
  # dt2 ----
  # Description     : 
  # Input           : 
  # Output          : 
  # Review status   : DEV
  # =============================================================================================-
  output$dt2 <- DT::renderDataTable(
    DT::datatable(data = {
      # Read data
      dt <- data.table(id = 1:10, value = runif(n = 10))
      return(dt)
    }), 
    options = list(paging = T, pageLength = 5, searching = T, sort = T, scrollX = T)
  )
  
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
