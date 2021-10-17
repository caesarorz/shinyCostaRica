library(shiny)
library(quantmod)
library(scales)
library(ggiraph)
library(ggplot2)
library(markdown)

source("C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app/helpers.R")
source("C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app/plots.R")

ui <- fluidPage(
  navbarPage("Costa Rica Insights",
             tabPanel("Population",
                      fluidRow(
                        column(9,
                               plotOutput("plot_population", click = "plot_click")
                        ),
                        column(3,
                               tableOutput("data_population")
                        )
                      )
             ),
             tabPanel("Mortality/Natality",
                        fluidRow(
                          column(9,
                                 plotOutput("plot_nat_mort", click = "plot_click")
                          ),
                          column(3,
                                 tableOutput("data_nat_mort")
                          )
                        )
                      
             ),
             tabPanel("GDP", 
                        fluidRow(
                          column(6,
                                 plotOutput("plot_gdp_cr")
                          ),
                          column(6,
                                 ggiraphOutput("plot_gdp_world")
                          )
                        )
             )
  )
)

gdp_word <- gdpWorld2020()
# 
# gg_point = ggplot(gdp_word) +
#   geom_point_interactive(aes(x = `Country Name`, y = `2020`)) + 
#   theme_minimal()
# 
# 
# 
# ggplot(gdp_word) + 
#   geom_point(mapping = aes(x = `Country Name`, y = `2020`))
# 
# 



server <- function(input, output, session) {
  pop_table <- population()
  pop_plot <- plotPopulation(pop_table)
  
  nat_mort_table <- nat_mort()
  nat_mort_plot <- plotNat_Mort(nat_mort_table)
    
  gdp_costarica <- gdpCostaRica()
  gdpcr_plot <- plotGDPCostaRica(gdp_costarica)
    
  gdp_word <- gdpWorld2020()
  
  
  output$plot_population <- renderPlot({pop_plot}, res = 96)
  output$data_population <- renderTable({
    req(input$plot_click)
    nearPoints(pop_table, input$plot_click)
  })  
  
  output$plot_nat_mort <- renderPlot({nat_mort_plot}, res = 96)
  output$data_nat_mort <- renderTable({
    req(input$plot_click)
    nearPoints(nat_mort_table, input$plot_click)
  }) 
  
  output$plot_gdp_cr <- renderPlot({gdpcr_plot}, res = 96)
  
  
  
  output$plot_gdp_word <- renderGirafe({
    girafe(ggobj = gg_point )
  })
  
  filterIris <- reactive({
    filter(iris, Species == input$species)
  })  
  
  output$plot_gdp_world <- renderggiraph({
    gg_point = ggplot(gdp_word) +
      scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      geom_point_interactive(aes(x = country_name, y = gdp2019,
                                 tooltip = country_name, data_id = gdp2019)) +
      
      theme_minimal()
    
    girafe(ggobj = gg_point)
  })
  
  
  
}

# Run the app
shinyApp(ui, server)
