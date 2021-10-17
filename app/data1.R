# uncomment if you need to install a package
install.packages(c("shiny", "maps", "mapproj", "readxl", "tidyverse", "ggiraph"))
install.packages("scales")
## load packages

library(shiny)
library(quantmod)
library(scales)
library(ggiraph)

## make sure getwd works ***************

# Source helpers ----
source("helpers.R")

# User interface
ui <- fluidPage(
  titlePanel("Costa Rica ..."),
  plotOutput("plot", click = "plot_click"),
  tableOutput("data")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    
    ggplot(population()) +
      geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
      scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      theme(axis.text.x = element_text(face="bold", color="#993333", 
                                       size=10, angle=90),
            axis.text.y = element_text(face="bold", color="#993333", 
                                       size=10, angle=0))
    
  }, res = 96)
  
  output$data <- renderTable({
    req(input$plot_click)
    nearPoints(population(), input$plot_click)
  })
}

# Run the app
shinyApp(ui, server)














