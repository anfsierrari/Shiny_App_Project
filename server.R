#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(caret)
library(randomForest); library(e1071)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    my_data <- iris[, 3:5]
    inTrain <- createDataPartition(y=my_data$Species, p=0.7, list=F)
    training <- my_data[inTrain, ]
    testing <- my_data[-inTrain, ]
    model1 <- train(Species~., data=training, method="rf")
    model2 <- train(Species~., data=training, method="lda")
    confmatrix <- confusionMatrix(testing$Species, predict(model1, testing[,-3]))
    confmatrix2 <- confusionMatrix(testing$Species, predict(model2, testing[,-3]))
    
    output$confmatrix <- renderText({
        as.numeric(confmatrix$overall[1])
    })
    
    output$confmatrix2 <- renderText({
        as.numeric(confmatrix2$overall[1])
    })
    
    output$plot1 <- renderPlot({
             ggplot(data=my_data, aes(x=Petal.Width, y=Petal.Length,
                                      color=Species)) + geom_point(size=2) +
                                        geom_point(aes(x=input$width,
                                                       y=input$length),
                                                   col="purple", size=3,
                                                   pch=19) + theme_bw()
                                                                    

    })
    
    output$plot2 <- renderPlot({
        ggplot(data=my_data, aes(x=Petal.Width, y=Petal.Length,
                                 color=Species)) + geom_point(size=2) +
            geom_point(aes(x=input$width,
                           y=input$length),
                       col="purple", size=3,
                       pch=19) + theme_bw()
        
        
    })
    
    output$pred <- reactive({
        predict(model1, newdata=data.frame(Petal.Length=input$length,
                                           Petal.Width=input$width))
    })

    output$pred2 <- reactive({
        predict(model2, newdata=data.frame(Petal.Length=input$length,
                                           Petal.Width=input$width))
    })
})
