library(shiny)

shinyUI(fluidPage(
    titlePanel("Gain Ratio calculator for bicycle gear configurations"),
    p("Use this calculator to compare the gearings of two bicycle drivetrain
      configurations. Enter the parameters for each configuration below. The 'size' of the
      resulting gears will be shown in the plot at the bottom, in terms of 
      gain ratio."),
    p("For a detailed description of gain ratio, see"),
    a("http://www.sheldonbrown.com/gain.html", 
      href="http://www.sheldonbrown.com/gain.html", target="_blank"),
    fluidRow(
        column(4,
            h3("Configuration 1"),
            selectInput("crank1", 
                        "Crank length:",
                        choices = c(170, 172.5, 175, 180),
                        selected = 175),
            fluidRow(
                column(3,
                     numericInput("ring1Small", 
                        "Select small chainring:",
                        value = 42)),
                column(3,offset = 2,
                     numericInput("ring1Large", 
                         "Select large chainring:",
                         value = 52))
                ),
            selectInput("rear1",
                        "Select gear cluster 1:",
                        choices = c("11-23","11-25", "11-28",
                                    "12-23", "12-25", "12-30"),
                        selected = "11-23")
            ),
        column(4,
            h3("Configuration 2"),
            selectInput("crank2", 
                        "Crank length:",
                        choices = c(170, 172.5, 175, 180),
                        selected = 175),
            fluidRow(
                column(3,
                       numericInput("ring2Small", 
                         "Select small chainring:",
                         value = 42)),
                column(3, offset = 2,
                       numericInput("ring2Large", 
                         "Select large chainring:",
                         value = 52))
                ),
            selectInput("rear2",
                        "Select gear cluster 2:",
                        choices = c("11-23","11-25", "11-28",
                                    "12-23", "12-25", "12-30"),
                        selected = "11-23")),
        column(4,offset = 9,
            submitButton("Go!")
                        ),
        
        mainPanel(h3("Gain Ratio versus rear cluster", align = "center"),
            plotOutput("plot"),
            h2("Notes"),
            p("Use the link below to access ui.R and server.R files used to 
              produce this app."),
            a("Sourcecode files can be found here", 
              href = "https://github.com/jleslie17/BicycleGearCalculator",
              target="_blank")
        ))
))
