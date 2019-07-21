#################################################################################################x
# Author(s)     : Jens Linden
# Description   : Collection of helper functions 
# 
# STEP 1        : Load re-usable assets
# STEP 2        : Define operators
# STEP 3        : Define functions
# STEP 4        : Define classes
# 
# STATUS        : DEVELOPMENT
#
# INPUT         : 
# OUTPUT        : 
#################################################################################################x

library(R6)

##################################################################################################x
# STEP 1: Load re-usable assets ----
##################################################################################################x


##################################################################################################x
# STEP 2: Define operators ----
##################################################################################################x

# Are you not also tired of writing !(a %in% b)? Use a %ni% b
`%ni%` <- Negate(`%in%`)
# Example:
# c("a", "b", "c") %in% c("c", "d", "e")
# c("a", "b", "c") %ni% c("c", "d", "e")

##################################################################################################x
# STEP 3: Define functions ----
##################################################################################################x

# ===============================================================================================-
# Description     : Format nicely
# Input           : x - numeric
# Output          : Formatted string
# Review status   : DEV
# ===============================================================================================-
format.nice <- function(x, decimal.mark=".", big.mark=",", digits = 0, ...) {
  formatC(unclass(x), decimal.mark=decimal.mark, big.mark=big.mark, digits = digits, format = "f")
}

# ================================================================================================x
# Description     : Inverse of which function. Numeric index to logical index.
# Input           : -
# Output          : -
# Review status   : DEV
# ================================================================================================x
which_logical <- function(indices, totlength) is.element(seq_len(totlength), indices)


# ================================================================================================x
# Description     : Output number of NA and inf in each column as ordered data table
# Input           : -
# Output          : -
# Review status   : DEV
# ================================================================================================x
inspect_na <- function(dt) {
  na_count <- sapply(dt, function(y) sum(length(which(is.na(y)))))
  inf_count <- sapply(dt, function(y) sum(length(which(is.infinite(y)))))
  na_count <- data.table(col=names(na_count), 
                         n_na=na_count, 
                         n_non_na=nrow(dt)-na_count,
                         n_inf=inf_count,
                         n_fin=nrow(dt)-inf_count )
  na_count <- na_count[order(n_na, decreasing = T)]
  
  return(na_count)
}

# ================================================================================================x
# Description     : Search dat table header for string
# Input           : dt: Data table 
#                   string: String to be searched for
# Output          : -
# Review status   : DEV
# ================================================================================================x
search.att.name <- sat <- function(dt, to_match, fixed=T) {
  col_names <- names(dt)
  col_names_low <- tolower(col_names)
  # Form regex using OR for searching multiple patterns
  regex <- paste(tolower(to_match), collapse="|")
  # Find
  idx <- grep(pattern=regex, x=col_names_low)
  return(col_names[idx])
}

# ================================================================================================x
# Description     : Returns string w/o leading or trailing whitespace
# Input           : String
# Output          : String
# Review status   : DEV
# ================================================================================================x
# 
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# ================================================================================================x
# Description     : Returns classes of data table columns
# Input           : dt
# Output          : res
# Review status   : DEV
# ================================================================================================x
col_types <- dt_classes <- function(dt) {
  tmp <- t(as.data.table(lapply(dt, class)))
  res <- data.table(col=rownames(tmp), class=tmp[,1])
  return(res)
}

# ================================================================================================x
# Description     : Returns col names of dt belonging to classes specified
# Input           : dt
#                   class_list: e.g. class_list <- c("numeric", "integer")
# Output          : res
# Review status   : DEV
# ================================================================================================x
get_cols_of_type <- function(dt, class_list) {
  cl <- dt_classes(dt)
  res <- cl[class %in% class_list]
  return(res)
}

# ================================================================================================x
# Description     : Get mode of numerical vector
# Input           : v - Vector
# Output          : Mode
# Review status   : Final
# Source          : https://www.tutorialspoint.com/r/r_mean_median_mode.htm
# ================================================================================================x
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# ================================================================================================x
# Description     : Get most freqent value of vector x
# Input           : x - vector (should be factor)
# Output          : scalar
# Review status   : DEV
# ================================================================================================x
get_most_freq <- function(x, na.rm=F) {
  # Debug: x=sw[store==1001 & CC_year==2013, CC_store_type] 
  if (na.rm){
    x <- x[!is.na(x)]
  }
  return(data.table(x=x)[, .N, by=x][order(N, decreasing = T)][1, x])
}

# ================================================================================================x
# Description     : Get uid
# Input           : 
# Output          : string
# Review status   : DEV
# ================================================================================================x
generate_uid <- function() {
  baseuuid <- paste(sample(c(letters[1:6],0:9),30,replace=TRUE),collapse="")
  uid <-   paste(
    substr(baseuuid,1,8),
    "-",
    substr(baseuuid,9,12),
    "-",
    "4",
    substr(baseuuid,13,15),
    "-",
    sample(c("8","9","a","b"),1),
    substr(baseuuid,16,18),
    "-",
    substr(baseuuid,19,30),
    sep="",
    collapse=""
  )
  return(uid)
}

# ================================================================================================x
# Description     : Get country from geolocations (from https://stackoverflow.com/a/14342127)
# Input           : 
# Output          : string
# Depends         : sp, rworldmap
# Review status   : DEV
# ================================================================================================x
coords2country <- function(points)
{  
  countriesSP <- getMap(resolution='low')
  pointsSP = SpatialPoints(points, proj4string=CRS(proj4string(countriesSP)))  
  # use 'over' to get indices of the Polygons object containing each point 
  indices = over(pointsSP, countriesSP)
  # return the ADMIN names of each country
  indices$ADMIN  
}

##################################################################################################x
# STEP 4: Define clases ----
##################################################################################################x

# # ===============================================================================================x
# # R6 class Template ----
# # ===============================================================================================x
# Template <- R6Class(
#   classname = "Template",
#   
#   # =============================================================================================x
#   # Public  ----
#   # =============================================================================================x
#   public = list(
#     
#     # Attributes
#     s=NA,
#     
#     # -------------------------------------------------------------------------------------------x
#     # Constructor -----
#     # Review status : 
#     # -------------------------------------------------------------------------------------------x
#     initialize = function() {
#     },
#     
#     # -------------------------------------------------------------------------------------------x
#     # Description   : xxx
#     # Input         : 
#     # Review status : DEV
#     # -------------------------------------------------------------------------------------------x
#     fcn1 = function() {
#       
#     }
#   ) # end public
# ) # end class

