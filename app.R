library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
    titlePanel("Star Wars"),
    h1("Star Wars Characters"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "Taille",
                        label = "Height of characters",
                        min = 0,
                        max = 250,
                        value = 30)
        ),
        mainPanel(
           plotOutput(outputId = "StarWarsPlot")
        )
    )
)

server <- function(input, output) {

    output$StarWarsPlot <- renderPlot({
        starwars |> 
          filter(height > input$Taille) |>
          ggplot(aes(x = height)) +
          geom_histogram(
            binwidth = 10, 
            fill = "darkgray", 
            color = "white"
          )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

