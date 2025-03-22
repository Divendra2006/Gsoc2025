required_packages <- c("shiny", "Rtsne", "ggplot2", "palmerpenguins", "dplyr", "bslib")

# Check if packages are installed, and install them if not
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

library(shiny)
library(Rtsne)
library(ggplot2)
library(palmerpenguins)
library(dplyr)
library(bslib)

ui <- page_sidebar(
  title = "t-SNE Visualization of Palmer Penguins",
  sidebar = sidebar(
    title = "Controls",
    sliderInput("perplexity", "Perplexity:", 
                min = 5, max = 50, value = 30, step = 5),
    checkboxGroupInput("features", "Features to include:", 
                       choices = c("bill_length_mm", "bill_depth_mm", 
                                   "flipper_length_mm", "body_mass_g"),
                       selected = c("bill_length_mm", "bill_depth_mm", 
                                    "flipper_length_mm", "body_mass_g")),
    p("Perplexity can be interpreted as a smooth measure of the number of neighbors considered.")
  ),
  
  card(
    card_header("t-SNE Plot"),
    plotOutput("tsne_plot")
  ),
  
  card(
    card_header("Dataset Information"),
    p("This app visualizes the Palmer Penguins dataset using t-SNE."),
    p("Each point represents a penguin, colored by species."),
    p("t-SNE attempts to preserve local distances, showing clusters of similar penguins.")
  )
)

server <- function(input, output, session) {
  penguins_data <- reactive({
    req(length(input$features) >= 2)
    
    data <- na.omit(penguins[, c("species", input$features)])
    
    list(
      features = as.matrix(data[, input$features]),
      species = data$species
    )
  })

  output$tsne_plot <- renderPlot({
    data <- penguins_data()
    
    req(nrow(data$features) > 0)
  
    max_perplexity <- floor((nrow(data$features) - 1) / 3)
    perplexity <- min(input$perplexity, max_perplexity)
    
    if (perplexity < input$perplexity) {
      showNotification(
        paste("Perplexity adjusted to", perplexity, "due to dataset size."),
        type = "warning"
      )
    }
   
    set.seed(123) # For reproducibility
    tsne_result <- Rtsne(data$features, 
                         perplexity = perplexity, 
                         check_duplicates = FALSE,
                         pca = TRUE, 
                         dims = 2)
   
    tsne_df <- data.frame(
      x = tsne_result$Y[, 1],
      y = tsne_result$Y[, 2],
      species = data$species
    )
    
    ggplot(tsne_df, aes(x = x, y = y, color = species)) +
      geom_point(size = 3, alpha = 0.7) +
      labs(
        title = paste("t-SNE with Perplexity =", perplexity),
        x = "t-SNE Dimension 1",
        y = "t-SNE Dimension 2"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 16),
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12)
      )
  })
}

shinyApp(ui, server)
