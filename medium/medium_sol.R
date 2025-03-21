library(shiny)
library(detourr)
library(crosstalk)
library(tourr)
library(htmltools)

data(flea, package = "tourr")

ui <- fluidPage(
  bscols(
    displayScatter2dOutput("tour1"), 
    displayScatter2dOutput("tour2")   
  )
)

server <- function(input, output) {
  shared_flea <- SharedData$new(flea)
  
  output$tour1 <- shinyRenderDisplayScatter2d({
    detour(shared_flea, tour_aes(projection = -species, colour = species)) |>
      tour_path(grand_tour(2), fps = 60) |>  
      show_scatter(alpha = 0.7, axes = FALSE)
  })
  
  output$tour2 <- shinyRenderDisplayScatter2d({
    detour(shared_flea, tour_aes(projection = -species, colour = species)) |>
      tour_path(little_tour(2), fps = 60) |>  
      show_scatter(alpha = 0.7, axes = FALSE)
  })
}

shinyApp(ui = ui, server = server)
