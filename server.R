library(shiny)
library(forecast)

PreciosMadrid <- read.table("PreciosMadrid.txt", sep="\t", header=TRUE)
PreciosMadrid$Quarter<-as.yearqtr(PreciosMadrid$Quarter, format = "%Y %q")
PreciosMadrid <- PreciosMadrid[order(PreciosMadrid$District, PreciosMadrid$Quarter),]

shinyServer(function(input, output) {
        
        getDataset <- reactive({
                return(ts(subset(PreciosMadrid, District==input$variable)[,3],frequency=4,start=c(2001,1)))
        })
        
        output$caption <- renderText({
                paste("District: ", input$variable)
        })
        
        output$dcompPlot <- renderPlot({
                ds_ts <- ts(getDataset(), frequency=4)
                f <- decompose(ds_ts)
                plot(f)
        })
        
        output$arimaForecastPlot <- renderPlot({
                fit <- auto.arima(getDataset(), stationary = TRUE, seasonal = FALSE,ic="aic")
                plot(forecast(fit, h=input$ahead))
        })
        
        output$etsForecastPlot <- renderPlot({
                fit <- ets(getDataset())
                plot(forecast(fit, h=input$ahead))
        })
        
        output$data <- renderTable({
                getDataset()
                              
        })
})