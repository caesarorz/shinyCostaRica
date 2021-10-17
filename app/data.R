library(shiny)
library(quantmod)
library(scales)
library(ggiraph)
library(ggplot2)
library(markdown)

source("C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app/helpers.R")
#source("C:/Users/50687/Desktop/dojo/bootcamp/week6/weekendAssingment/app/navbar.R")

ui <- fluidPage(
  
  navbarPage("Navbar!",
             tabPanel("Plot",
                        fluidRow(
                          column(9,
                                 plotOutput("plot_nat_mort", click = "plot_click")
                          ),
                          column(3,
                                 tableOutput("data_nat_mort")
                          )
                        )
                      
             ),
             tabPanel("Summary",
                      fluidRow(
                        column(9,
                               plotOutput("plot_population", click = "plot_click")
                        ),
                        column(3,
                               tableOutput("data_population")
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
  output$plot_nat_mort <- renderPlot({
    ggplot(nat_mort()) +
      geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
      theme(axis.text.x = element_text(face="bold", color="#993333", 
                                       size=10, angle=90),
            axis.text.y = element_text(face="bold", color="#993333", 
                                       size=10, angle=0))
  }, res = 96)

  output$data_nat_mort <- renderTable({
    req(input$plot_click)
    nearPoints(nat_mort(), input$plot_click)
  })  
  
  output$plot_population <- renderPlot({
    ggplot(population()) +
      geom_point(mapping = aes(x=year, y=points, color = dem_comp)) +
      scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
      theme(axis.text.x = element_text(face="bold", color="#993333", 
                                       size=10, angle=90),
            axis.text.y = element_text(face="bold", color="#993333", 
                                       size=10, angle=0))
    
  }, res = 96)
  output$data_population <- renderTable({
    req(input$plot_click)
    nearPoints(population(), input$plot_click)
  })  
  

}

# Run the app
shinyApp(ui, server)
