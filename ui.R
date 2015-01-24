library(shiny)

# Define UI 
shinyUI(pageWithSidebar(

        # Application title
        titlePanel("Madrid Houses Prices Forecasting"),
        
        # Sidebar with controls to select the dataset and forecast ahead duration
        sidebarPanel(
                
                helpText("Shows the evolution of house prices in Madrid 
                         for different districts since 2001 by quarter and 
                         forecasts its possible evolution for a selected number of quarters."),
                helpText("Source for historical data: idealista.com"),
                
                selectInput("variable", "Select a Madrid District:",
                            list("All Madrid" = "Madrid",
                                 "Arganzuela" = "Arganzuela", 
                                 "Barajas" = "Barajas",
                                 "Carabanchel" = "Carabanchel",
                                 "Centro" = "Centro",
                                 "Chamartin" = "Chamartin",
                                 "Chamberi" = "Chamberi",
                                 "Ciudad Lineal" = "Ciudad Lineal",
                                 "Fuencarral" = "Fuencarral",
                                 "Hortaleza" = "Hortaleza",
                                 "Latina" = "Latina",
                                 "Moncloa" = "Moncloa",
                                 "Moratalaz" = "Moratalaz",
                                 "Puente de Vallecas" = "Puente de Vallecas",
                                 "Retiro" = "Retiro",
                                 "Salamanca" = "Salamanca",
                                 "San Blas" = "San Blas",
                                 "Tetuan" = "Tetuan",
                                 "Usera" = "Usera",
                                 "Vicalvaro" = "Vicalvaro",
                                 "Villa de Vallecas" = "Villa de Vallecas",
                                 "Villaverde" = "Villaverde")),
                numericInput("ahead", "Quarters to Forecast Ahead:", 4,
                             min = 1, max = 12),
                br(),
                submitButton("Update"),
                br(),
                p('Click on the Update button to display the corresponding information to your selection')
        ),
        
        
        
        # Show the caption and forecast plots
        mainPanel(
                h3(textOutput("caption"), align="center"),
                
                tabsetPanel(
                        tabPanel("Exponential Smoothing (ETS) Forecast", plotOutput("etsForecastPlot")), 
                        tabPanel("Arima Forecast", plotOutput("arimaForecastPlot")),
                        tabPanel("Timeseries Decomposition", plotOutput("dcompPlot")),
                        tabPanel("Data", tableOutput("data"))
                )
        )
))