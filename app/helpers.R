# uncomment if you need to install a package
# install.packages(c("shiny", "maps", "mapproj", "readxl", "tidyverse"))

## load packages
library("shiny")
library("maps")
library("mapproj")
library("readxl")
library("tidyverse")
require(dplyr)

############################################   functions

loadTablePopulation <- function(){
  ## load files 
  path <- "C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app"
  setwd(path)
  ##        path + /tables/name-of-your-file
  populationFile <- paste(path, "/tables/repoblacev_bid_web.xls", sep='') # pop table
  ## others
  table_pop <- read_excel(populationFile, sheet="Cuadro 1")
  return(table_pop)
}

loadTableGDP <- function(){
  ## load files 
  path <- "C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app"
  setwd(path)
  ##        path + /tables/name-of-your-file
  populationFile <- paste(path, "/tables/API_NY.GDP.MKTP.CD_DS2_en_excel_v2_3052509.xls", sep='') # pop table
  ## others
  table_gdp <- read_excel(populationFile, sheet="Data")
  return(table_gdp)
}


cleanGDPTable <- function(){
  clean_table <- loadTableGDP()
  colnames(clean_table) <- clean_table %>% slice(3)
  clean_table <- clean_table %>% slice(4:nrow(clean_table)) %>%
    mutate_at(c(5:ncol(clean_table)), as.numeric)
  return(clean_table)
}

gdpWorld2020 <- function() {
  table <- cleanGDPTable()
  table <- table %>% select(`Country Name`, `2020`)
  return(table)
}


gdpCostaRica <- function(){
  table <- cleanGDPTable()
  table <- table %>% filter(`Country Name` == 'Costa Rica')
  return(table)
}


cleanTable <- function(){
  # table cleaning and fixing (general)
  clean_table <- loadTablePopulation()
  colnames(clean_table) <- clean_table %>% slice(4)
  colnames(clean_table)[colnames(clean_table) == '2020a/'] <- '2020'
  colnames(clean_table)[colnames(clean_table) == 'Componente demográfico'] <- 'dem_comp'
  clean_table$'2020' <- as.double(as.character(clean_table$'2020'))
  #sapply(clean_table, class) # check typeso 
  return(clean_table)
}

population <- function(){
  ## table generator population
  df_population <- cleanTable()
  # population_clean <- population %>% slice(8:nrow(population))
  df_population <- df_population %>% slice(8:10)
  
  df_population <- pivot_longer(df_population, 
                            2:ncol(df_population), 
                            names_to = "year", 
                            values_to = "points", values_drop_na = TRUE) %>%
    group_by(year)

  return(df_population)
}

nat_mort <- function(){
  ## table generator natality and mortality
  nat_mort <- cleanTable()
  nat_mort_clean <- nat_mort %>% slice(14:25) %>% slice(-c(2:9))
  nat_mort_clean[nat_mort_clean == "General (por mil habitantes)"] <- "Mortalidad General (por mil habiltantes)"
  nat_mort_clean[nat_mort_clean == "Hombres"] <- "Mortalidad General Hombres"
  nat_mort_clean[nat_mort_clean == "Mujeres"] <- "Mortalidad General Mujeres"
  nat_mort_pivot <- pivot_longer(nat_mort_clean, 
                             2:ncol(nat_mort_clean), 
                             names_to = "year", 
                             values_to = "points", values_drop_na = TRUE) %>%
     group_by(year)
  
  return(nat_mort_pivot)
}



