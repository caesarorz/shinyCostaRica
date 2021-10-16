# uncomment if you need to install a package
install.packages(c("shiny", "maps", "mapproj", "readxl", "tidyverse", "ggiraph"))
install.packages("scales")
## load packages

library(shiny)
library(quantmod)
library(scales)

## make sure getwd works ***************


# Source helpers ----
source("helpers.R")

population()
# View(population())
# femalePop <- population() %>% filter(dem_comp == 'Mujeres') %>%
# malePop <- population() %>% filter(dem_comp == 'Hombres')

# User interface ----
ui <- fluidPage(
  
  titlePanel("Costa Rica ..."),
  
  sidebarLayout(
    sidebarPanel(
      helpText("..."),
      
      # dateRangeInput("dates",
      #                "Date range",
      #                start = "2013-01-01",
      #                end = as.character(Sys.Date())),
      
      br(),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale",
                    value = FALSE),
      
      checkboxInput("adjust",
                    "Adjust prices for inflation", value = FALSE)
    ),
    
    mainPanel(
      plotOutput("plot", click = "plot_click"),
      tableOutput("data")
  )  

  )  
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    
    ggplot(population()) +
      geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
      scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6))
    
  }, res = 96)
  
  output$data <- renderTable({
    req(input$plot_click)
    nearPoints(population(), input$plot_click)
  })
}

# Run the app
shinyApp(ui, server)














