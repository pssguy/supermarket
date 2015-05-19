
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


shinyUI(fluidPage(

  # Application title
  titlePanel("Supermarkets"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("retailers","Select Retailers",retailerChoice, selected=retailerChoice),
      textInput("postcode","Enter Postcode","BR3 4DT")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("leafletMap")
    )
  )
))
