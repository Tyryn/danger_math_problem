library(shiny)
library(tidyverse)
library(dygraphs)

#source("is_odd.R")
#source("collatz_conjecture.R")

ui <- fluidPage(
  
  # Application title
  titlePanel("The Collatz conjecture"),
  
  # Sidebar with two numeric input widgets
  sidebarLayout(
    sidebarPanel(
      numericInput("integer1", label = "Enter an integer:", value = 100, min=1, width = '50%'),
      numericInput("integer2", label = "Enter another integer:", value = 50, min=1, width = '50%')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tags$div(
        HTML("<p>The Collatz conjecture, proposed by mathematician Lothar Collatz in 1937, is a deceptively simple yet unsolved problem in number theory.</p>
             <p>Starting with any positive integer n, follow these rules iteratively:</p>
             <ul>
               <li>If n is even, divide it by 2.</li>
               <li>If n is odd, multiply it by 3 and add 1.</li>
             </ul>
             <p>This process continues until n reaches 1. The conjecture suggests that regardless of the initial value of n, the sequence will always reach 1. Despite extensive computational verification, a rigorous proof remains elusive, making it a captivating challenge in mathematics. This project visualizes the Collatz conjecture, providing insights into its behavior and patterns.</p>")
      ),
      dygraphOutput("collatzPlot")  # Moved plotOutput inside mainPanel
    )
  )
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  
  dataframe <- reactive({
    dataframe1 <- danger_problem(input$integer1)
    dataframe2 <- danger_problem(input$integer2)
    merged_df <- merge(dataframe1, dataframe2, by = "iteration", suffixes = c("_df1", "_df2"), all.x=TRUE, all.y=TRUE)
    # Rename columns
    names(merged_df)[which(names(merged_df) == "value_df1")] <- input$integer1
    names(merged_df)[which(names(merged_df) == "value_df2")] <- input$integer2
    return(merged_df)
  })

    output$collatzPlot <- renderDygraph({
      dygraph(dataframe()) %>% dyRangeSelector()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
