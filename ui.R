

dashboardPage(
  dashboardHeader(title = "Supermarket Search"),
  dashboardSidebar(
    
    checkboxGroupInput("retailers","Select Retailers",retailerChoice, selected=retailerChoice),
   
      textInput("postcode","Enter Postcode","BR3 4DT"),
   submitButton(icon("refresh"))
#    fluidRow(col(6,submitButton(icon("refresh"))),
#             col(6,includeMarkdown("about2.md"))   
#    )
    
  ),
  dashboardBody(
    includeMarkdown("about.md"),
    includeCSS("custom.css"),
    leafletOutput('leafletMap',height = 550)
  )
  , skin="red"
)