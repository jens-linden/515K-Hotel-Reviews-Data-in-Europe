# ###############################################################################################-
# Author(s)     : Jens Linden
# Description   : User interface for shiny
# 
# STEP 1        : Settings
# STEP 2        : Definition of user elements
# STEP 3        : Define user interface
# 
# STATUS        : DEV
# ###############################################################################################-

# ###############################################################################################-
# STEP 1: settings ----
# ###############################################################################################-
s <- list()
s$title <- "Hotel review analysis"

# ###############################################################################################-
# STEP 2: Define input elements ----
# ###############################################################################################-


# ###############################################################################################-
# STEP 3: Define user interface ----
# ###############################################################################################-
shinyUI(
  fluidPage(
    title = s$title ,
    theme = "style.css",
    h1(img(src = "", height=45, hspace="0px", vspace="5px", 
           style="margin-left: -14px; margin-right: 20px;"),
       span(s$title)
    ),
    # ==========================================================================================-
    # Sidebar 
    # ==========================================================================================-
    fluidRow(
      column(4,
             fluidRow(
               column(12,
                      wellPanel(
                        h2("Map"),
                        style = "background-color: white;",
                        # ======================================================================-
                        # xxx ----
                        # ======================================================================-
                        leafletOutput("map_hotel")
                      ) # end wellPanel
               ) # end column
             ), # end fluidRow
             fluidRow(
               column(12,
                      conditionalPanel(
                        condition ="typeof input.dt_hotel_list_rows_selected  === 'undefined' || input.dt_hotel_list_rows_selected.length <= 0",
                        wellPanel(
                          h2("Filter hotels"),
                          # ======================================================================-
                          # Select ... ----
                          # ======================================================================-
                          selectInput("sel_cluster", "Choose cluster",
                                      c("all", "1", "2", "3",  "4",  "5"),
                                      selected = "all"
                          ),
                          # ======================================================================-
                          # Select ... ----
                          # ======================================================================-
                          selectInput("sel_leadlag", "Choose leader or lagger",
                                      c("all", "leader", "lagger", "middle"),
                                      selected = "all"
                          ),
                          # ======================================================================-
                          # Select ... ----
                          # ======================================================================-
                          selectInput("sel_city", "Choose city",
                                      c("all", "Amsterdam", "London", "Paris", "Barcelona", "Milan", "Vienna"),
                                      selected = "all"
                          )
                        ) # end wellPanel
                      ) # end conditionalPanel
               ) # end column
             ) # end fluidRow
      ), # end column
      column(8,
             fluidRow(
               column(12,
                      wellPanel(
                        h2("List of hotels"),
                        # ======================================================================-
                        # Table 1 ----
                        # ======================================================================-
                        dataTableOutput("dt_hotel_list")
                      ) # end wellPanel
               ) # end column
             ), # end fluidRow
             fluidRow(
               column(6, 
                      conditionalPanel(
                        condition ="typeof input.dt_hotel_list_rows_selected  !== 'undefined' && input.dt_hotel_list_rows_selected.length > 0",
                        wellPanel(
                          h2("Benchmark mean hotel score with peers"),
                          # ======================================================================-
                          # Table 2 ----
                          # ======================================================================-
                          plotOutput(outputId = "plot_benchmarks", 
                                     height = "200px")
                        ) # end wellPanel
                      ) # end conditionalPanel
               ) # end column
             ) # end fluidRow
      ) # end column
    ) # end fluidRow
  ) # end fluidPage
) # end shinyUI
