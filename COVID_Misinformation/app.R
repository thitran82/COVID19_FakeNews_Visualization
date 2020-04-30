#Load the Library
library(shiny)
library(ggplot2)
library(tidyverse)
library(RCurl)

load(url("https://raw.githubusercontent.com/thitran82/COVID19_FakeNews_Visualization/master/Covid_Fake.RData"))

ui <- navbarPage(title = "Coronavirus - COVID 19 Misinformation Record Visualization",
                 tabPanel("Misinformation records in different features through time:",
                          sidebarLayout(
                              sidebarPanel(
                                  #Select Y-axix variables
                                  selectInput(inputId = "feature1", 
                                              label = "Please select features of misinformation to be analyzed by time:",
                                              choices = c("Primary_Language","Main_Narrative","Motive","Source","Misinfo_Type"), 
                                              selected = "Motive"),
                                  #X axis is always the time such information was created and posted, which is the variable "Publication_Date"
                                  selectInput(inputId = "time", 
                                              label = "Time value:",
                                              choices = c("Publication_Date"), 
                                              selected = "Publication_Date"),
                              ),
                              mainPanel(
                                  plotOutput(outputId = "TimeChart")
                              )
                          )
                 ),
                 tabPanel("Misinformation records in different features divided by motives",
                          sidebarLayout(
                              sidebarPanel(
                                  #Select Y-axix variables
                                  selectInput(inputId = "feature2", 
                                              label = "Please select features of misinformation to be analyzed by motives:",
                                              choices = c("Primary_Language","Main_Narrative","Source","Misinfo_Type"), 
                                              selected = "Source"),
                                  #X axis is always the variable "Motive"
                                  selectInput(inputId = "motive", 
                                              label = "Motive variable of Misinformation creators:",
                                              choices = c("Motive"), 
                                              selected = "Motive"),),
                              mainPanel(
                                  plotOutput(outputId = "MotiveChart")
                              )
                          )
                 )
)


# Define server and plot types:

server <- function(input, output) {
    
    #Time Chart: line chart
    output$TimeChart <- renderPlot({
        # draw the line chart
        ggplot(covid, aes_string(x=input$time, group=input$feature1, color=input$feature1)) + geom_line(stat="count", position = "dodge")
    })
    
    #Motive chart: stacked bar chart
    output$MotiveChart <- renderPlot({
        # draw the stacked bar chart
        ggplot(covid, aes_string(x=input$motive, group=input$feature2, fill=input$feature2)) +  geom_bar(stat="count", position = "stack", color = "blue") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
    })
}
# Run the application 
shinyApp(ui = ui, server = server)