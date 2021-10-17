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
             navbarMenu("More",
                        tabPanel("Table",
                                 DT::dataTableOutput("table")
                        ),
                        tabPanel("About",
                                 fluidRow(
                                   column(6,
                                    "Colum 6"
                                   ),
                                   column(3,
                            
                                   )
                                 )
                        )
             )
  ),  
  
  # fluidRow(
  #   column(4, 
  #          "Distribution 1",
  #          numericInput("n1", label = "n", value = 1000, min = 1),
  #          numericInput("mean1", label = "µ", value = 0, step = 0.1),
  #          numericInput("sd1", label = "??", value = 0.5, min = 0.1, step = 0.1)
  #   ),
  #   column(4, 
  #          "Distribution 2",
  #          numericInput("n2", label = "n", value = 1000, min = 1),
  #          numericInput("mean2", label = "µ", value = 0, step = 0.1),
  #          numericInput("sd2", label = "??", value = 0.5, min = 0.1, step = 0.1)
  #   ),
  #   column(4,
  #          "Frequency polygon",
  #          numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
  #          sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
  #   )
  # ),
  # fluidRow(
  #   column(9, plotOutput("hist")),
  #   column(3, verbatimTextOutput("ttest"))
  # )
)



server <- function(input, output, session) {
  pop_table <- population()
  pop_plot <- plotPopulation(pop_table)
  
  nat_mort_table <- nat_mort()
  nat_mort_plot <- plotNat_Mort(nat_mort_table)
    
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
}

# Run the app
shinyApp(ui, server)
