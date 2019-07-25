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
  
  
  # #############################################################################################-
  # STEP 4: Output elements ----
  # #############################################################################################-
  
  
  # =============================================================================================-
  # dt1 ----
  # Description     : 
  # Input           : 
  # Output          : 
  # Review status   : DEV
  # =============================================================================================-
  output$dt1 <- DT::renderDataTable(
    DT::datatable(data = {
      # Read data
      dt <- data.table(id = 1:10, value = runif(n = 10))
      return(dt)
    }), 
    options = list(paging = T, pageLength = 5, searching = T, sort = T, scrollX = T)
  )
  
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
