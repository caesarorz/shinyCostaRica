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
                          column(12,
                                 plotOutput("plot_gdp_cr")
                          ),
                        ),
                        fluidRow(
                          column(12,
                                 ggiraphOutput("plot_gdp_world")
                          )
                        )
             )
  )
)

server <- function(input, output, session) {
  pop_table <- population()
  pop_plot <- plotPopulation(pop_table)
  
  nat_mort_table <- nat_mort()
  nat_mort_plot <- plotNat_Mort(nat_mort_table)
    
  gdp_costarica <- gdpCostaRica()
  gdpcr_plot <- plotGDPCostaRica(gdp_costarica)
    
  gdp_word <- gdpWorld2020()
  gg_gdp_world <- plotGDPWord(gdp_word)
  
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
  
  # filterIris <- reactive({
  #   filter(iris, Species == input$species)
  # })  
  
  output$plot_gdp_world <- renderggiraph({
    girafe(ggobj = gg_gdp_world, width_svg = 15, height_svg = 4)
  })
  
  
  
}

# Run the app
shinyApp(ui, server)

