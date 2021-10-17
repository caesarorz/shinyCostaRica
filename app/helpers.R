# uncomment if you need to install a package
# install.packages(c("shiny", "maps", "mapproj", "readxl", "tidyverse"))

## load packages
library("shiny")
library("maps")
library("mapproj")
library("readxl")
library("tidyverse")
require(dplyr)

# path <- "C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app"
# setwd(path)

## load files       path + /tables/name-of-your-file


pop_pivot %>%
  ggplot(.) +
  geom_line(mapping = aes(x = year, y = points, color = dem_comp)) +
  geom_point(mapping = aes(x=year, y=points,color = dem_comp))
# 
# 
gg_point = ggplot(data = pop_pivot) +
  geom_point_interactive(aes(x = year, y = points, color = dem_comp,
                             tooltip = points, data_id = dem_comp)) +
  #geom_line(aes(x=year, y=points, color=dem_comp)) +
  scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6)) +
  theme(axis.text.x = element_text(face="bold", color="black",
                                   size=8, angle=90),
        axis.text.y = element_text(face="bold", color="black",
                                   size=10, angle=0))

girafe(ggobj = gg_point)
# 
# 
# library(ggiraph)
# data <- mtcars
# data$carname <- row.names(data)
# 
# gg_point = ggplot(data = data) +
#   geom_point_interactive(aes(x = wt, y = qsec, color = disp,
#                              tooltip = carname, data_id = carname)) + 
#   scale_y_continuous(labels = unit_format(unit = "M", scale = 1e-6)) +
#   theme_minimal()
# 
# girafe(ggobj = gg_point)







############################################   functions



loadTable <- function(){
  path <- "C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app"
  setwd(path)
  
  ## load files       path + /tables/name-of-your-file
  populationFile <- paste(path, "/tables/repoblacev_bid_web.xls", sep='') # pop table
  ## others
  table <<- read_excel(populationFile, sheet="Cuadro 1")
  return(table)
}


## table generators
population <- function(){
  
# population table cleaning
  population <- loadTable()
  colnames(population) <- population %>% slice(4)
  colnames(population)[colnames(population) == '2020a/'] <- '2020'
  colnames(population)[colnames(population) == 'Componente demográfico'] <- 'dem_comp'
  population$'2020' <- as.double(as.character(population$'2020'))
  #sapply(population, class) # check typeso 
  
  # population_clean <- population %>% slice(8:nrow(population))
  population_clean <- population %>% slice(8:10)
  
  pop_pivot <- pivot_longer(population_clean, 
                            2:ncol(population_clean), 
                            names_to = "year", 
                            values_to = "points", values_drop_na = TRUE) %>%
    group_by(year)

  return(pop_pivot)
}






