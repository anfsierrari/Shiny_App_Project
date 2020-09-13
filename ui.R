#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Iris species predictor"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("length","Select petal length:",
                        min = 1,
                        max = 7,
                        value = 3, step = 0.5),
            sliderInput("width", "Select petal width:",
                        min= 0.1,
                        max= 3,
                        value= 1.5, step = 0.1),
            submitButton("Run")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type="tabs",
                        tabPanel("How it works?", br(),
                                 h5("This shiny app is designed to predict the species
                                    of a Iris flower given the petal width and length. In
                                    the sidebar panel you must select the values for both measurements
                                    and then click run to start the processes"),
                                 h5("The predictions will be made using two different models: a random forest
                                    model (second page) and a linear discriminant analysis (third page). In 
                                    both pages you will find a scatter plot of all the values from the iris dataset
                                    in R. Also you will see a purple point, which coordinates are dependent of the 
                                    values you have selected in the sidebar panel. The two models were build using the caret package. The training and testing data
                                    were selected from the original dataset (p=0.7). Finally you will find the predicted
                                    species for the floral attributes you selected and the accuracy of the model used in the
                                    prediction."),
                                 h3("That's all, enjoy this app!")),
                        tabPanel("Random Forest", br(),
                                 h4("Iris measurements plot"),
                                 plotOutput("plot1"),
                                 h4("A flower with the selected measurements will be of the species:"),
                                 textOutput("pred"),
                                 h4("Accuracy of the random forest model:"),
                                 textOutput("confmatrix")),
                        tabPanel("Linear discrminant analysis (LDA)", br(),
                                 h4("Iris measurements plot"),
                                 plotOutput("plot2"),
                                 h4("A flower with the selected measurements will be of the species:"),
                                 textOutput("pred2"),
                                 h4("Accuracy of the LDA model:"),
                                 textOutput("confmatrix2"))
           
        )
    )
)))
