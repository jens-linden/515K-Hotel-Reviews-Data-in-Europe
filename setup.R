#################################################################################################+
# Author(s)     : Jens Linden
# Description   : Setup project environment
# 
# STEP 1 Install packages
# STEP 2 Clean start and inits
# STEP 3 Unzip raw files
# 
# STATUS        : DEVELOPMENT
#
#################################################################################################+

#################################################################################################+
# STEP 1 Install packages  ----
#################################################################################################+
install.packages(c('data.table',
                   'rprojroot',
                   'R6',
                   'ggplot2',
                   'knitr',
                   'skimr',
                   'DataExplorer',
                   'leaflet',
                   'sp',
                   'rworldmap',
                   'digest',
                   'geosphere',
                   'stringr',
                   'tidyr',
                   'tm',
                   'SnowballC', 
                   'caret',
                   'factoextra',
                   'party',
                   'ggmap',
                   'DT'))


#################################################################################################+
# STEP 2 Clean start and inits ----
#################################################################################################+
rm(list=ls())                   # Clear all
graphics.off()                  # Close all
Sys.setenv(LANG = "en")         # Language
cat("\014")                     # Clean console (win only)
cat(rep("#",80), "\n", sep="")  # Cosmetics
options(width = 100)            # Change standard width from 80 to 100

# Libs
library(rprojroot) # Rroot folder management
ROOT <- find_root(has_file("PROJECT_ROOT_DIR"))

#################################################################################################+
# STEP 3 Unzip raw files ----
#################################################################################################+

# ID01 - Challenge data
file_zip <- paste0(ROOT, '/01_data/01_raw/ID01_task_inf/Hotel_Reviews.zip') 
dir_unzip <- paste0(ROOT, '/01_data/02_unzipped/ID01')
unzip(zipfile = file_zip, exdir = dir_unzip) # Unzip files 

# ID02 - Kaggle data
file_zip <- paste0(ROOT, '/01_data/01_raw/ID02_kaggle/515k-hotel-reviews-data-in-europe.zip') 
dir_unzip <- paste0(ROOT, '/01_data/02_unzipped/ID02')
unzip(zipfile = file_zip, exdir = dir_unzip) # Unzip files 

# ID03 - free-world-hotel-database
file_zip <- paste0(ROOT, '/01_data/01_raw/ID03_free-world-hotel-database/hotels.csv.zip') 
dir_unzip <- paste0(ROOT, '/01_data/02_unzipped/ID03')
unzip(zipfile = file_zip, exdir = dir_unzip) # Unzip files 


# ID04 - hotelsbase
file_zip <- paste0(ROOT, '/01_data/01_raw/ID04_hotelsbase/hotelsbase_prep.zip') 
dir_unzip <- paste0(ROOT, '/01_data/02_unzipped/ID04')
unzip(zipfile = file_zip, exdir = dir_unzip) # Unzip files 

