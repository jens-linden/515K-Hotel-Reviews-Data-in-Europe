# ###############################################################################################-
# Author(s)     : Jens Linden
# Description   : Global values assessible from server.R and ui.R
#                 Cf. http://shiny.rstudio.com/articles/scoping.html
# 
# STEP 1        : Libraries and initializations & settings
# STEP 2        : Global variables
# STEP 3        : Function definitions
# 
# STATUS        : 
#
# ###############################################################################################-

# ###############################################################################################-
# STEP 1: Libraries and initializations & settings ----
# ###############################################################################################-
# library(checkpoint) # Package management to avoid incompatibilities
# checkpoint('2019-05-01') # Use all packages as of date provided
library(shiny) # Shiny App using R
library(ggplot2) # High quality plots
library(ggmap) # maps
library(cowplot) # Multiple plot arrangement
theme_set(theme_gray()) # Set standard ggplot gray style
library(data.table) # Data munging
library(DT) # Shiny interactive data tables
options(datatable.auto.index=FALSE) # Bug fixing for v < 1.9.5
library(openxlsx) # Simplifies the creation of Excel .xlsx files
options(shiny.maxRequestSize=10*1024^2) # Set upload limit for inputFile to 10MB
library(readxl) # Reading from xlsx
library(ggmap) # Labels in scatterplot
library(leaflet) # Interative maps
library(ggrepel) # Label in plots
library(caret) # Classification And REgression Training
source("lib_general.R")

# ###############################################################################################-
# STEP 2: Global variables ----
# ###############################################################################################-
IS_DEBUG <- TRUE
VERSION <- "Version 1.0"

# ===============================================================================================-
# Central place to store porject wide settings
# ===============================================================================================-
opt <- list()
# Define colors
opt$ci <- list()
opt$ci$cap_blue <- rgb(0, 112, 173, maxColorValue = 255)
opt$ci$vibrant_blue <- rgb(18, 171, 219, maxColorValue = 255)
opt$ci$tech_red <- rgb(255, 48, 76, maxColorValue = 255)
opt$ci$deep_purple <- rgb(43, 10, 61, maxColorValue = 255)

# ###############################################################################################-
# STEP 3: Function definitions ----
# ###############################################################################################-

# Eventually carve out lib elements when lib is not to be deployed