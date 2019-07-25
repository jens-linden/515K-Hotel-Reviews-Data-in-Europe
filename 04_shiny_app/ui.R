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
    h1(
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
                        h2("Menue panel"),
                        # ======================================================================-
                        # Select ... ----
                        # ======================================================================-
                        selectInput("store", "Choose your ...:",
                                    c("", "16105", "58330", "124573",  "161156",  "229520",  "261059")
                        )
                      ) # end wellPanel
               ) # end column
             ), # end fluidRow
             fluidRow(
               column(12,
                      wellPanel(
                        h2("Menue panel"),
                        style = "background-color: white;"
                        # ======================================================================-
                        # xxx ----
                        # ======================================================================-

                      ) # end wellPanel
               ) # end column
               
             ) # end fluidRow
      ), # end column
      column(8,
             fluidRow(
               column(12,
                      wellPanel(
                        h2("Content panel"),
                        # ======================================================================-
                        # Table 1 ----
                        # ======================================================================-
                        dataTableOutput("dt1")
                      ) # end wellPanel
               ) # end column
             ), # end fluidRow
             fluidRow(
               column(12, 
                      conditionalPanel(
                        condition = "input.store != ''",
                        wellPanel(
                          h2("Recommendations for store manager"),
                          # ======================================================================-
                          # Table 2 ----
                          # ======================================================================-
                          dataTableOutput("dt2")
                        ) # end wellPanel
                      ) # end conditionalPanel
               ) # end column
             ) # end fluidRow
      ) # end column
    ) # end fluidRow
  ) # end fluidPage
) # end shinyUI
