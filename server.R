library(shiny)
library(ggplot2)

WheelR <- 340

shinyServer(function(input,output){
    FrontVector1 <- reactive({
        rep(c(input$ring1Small,input$ring1Large), each = 10)
    })
    FrontVector2 <- reactive({
        rep(c(input$ring2Small,input$ring2Large), each = 10)
    })
    ###Turns input gears into numbers
    RearVector1 <- reactive({
        if (input$rear1 == "11-23") {
            return(c(11,12,13,14,15,16,17,19,21,23))
        } else if(input$rear1 == "11-25") {
            return(c(11,12,13,14,15,17,19,21,23,25))
        } else if(input$rear1 == "11-28") {
            return(c(11,12,13,14,15,17,19,21,24,28))
        } else if(input$rear1 == "12-23") {
            return(c(12,13,14,15,16,17,18,19,21,23))
        } else if(input$rear1 == "12-25") {
            return(c(12,13,14,15,16,17,19,21,23,25))
        } else if(input$rear1 == "12-30") {
            return(c(12,13,14,15,17,19,21,24,27,30))
        }
    })
    RearVector2 <- reactive({
        if (input$rear2 == "11-23") {
            return(c(11,12,13,14,15,16,17,19,21,23))
        } else if(input$rear2 == "11-25") {
            return(c(11,12,13,14,15,17,19,21,23,25))
        } else if(input$rear2 == "11-28") {
            return(c(11,12,13,14,15,17,19,21,24,28))
        } else if(input$rear2 == "12-23") {
            return(c(12,13,14,15,16,17,18,19,21,23))
        } else if(input$rear2 == "12-25") {
            return(c(12,13,14,15,16,17,19,21,23,25))
        } else if(input$rear2 == "12-30") {
            return(c(12,13,14,15,17,19,21,24,27,30))
        }
    })
    Crank1R <- reactive({
        as.numeric(input$crank1)
    })
    Crank2R <- reactive({
        as.numeric(input$crank2)
    })
    output$plot <- renderPlot({
        GainRatio1 <- WheelR/Crank1R()*FrontVector1()/RearVector1()
        GainRatio2 <- WheelR/Crank2R()*FrontVector2()/RearVector2()
        Gears1 <- data.frame(Config = rep("Configuration 1", 20),
                             Front = FrontVector1(), 
                             Ring = rep(c("small", "large"), each = 10),
                             Rear = RearVector1(),
                             GainRatio = GainRatio1)
        Gears2 <- data.frame(Config = rep("Configuration 2", 20),
                             Front = FrontVector2(),
                             Ring = rep(c("small", "large"), each = 10),
                             Rear = RearVector2(),
                             GainRatio = GainRatio2)
        Gears <- rbind(Gears1, Gears2)
        g2 <- ggplot(Gears, aes(x = as.factor(Rear), y = GainRatio,
                                ymax = 10,
                                fill = as.factor(Config),
                                shape = as.factor(Ring)))
        p <- g2 + 
            geom_line(size = 1,
                      aes(group = interaction(Config,Front),
                          colour = as.factor(Config)),
                      position = position_dodge(0.2),
                      alpha = 0.7) + 
            geom_point(aes(colour = as.factor(Config)),
                       position = position_dodge(0.2), 
                       size = 5, alpha = 0.7) +
            scale_colour_manual(values = c("blue", "red")) +
            scale_fill_manual(values = c("blue", "red")) +
            scale_shape_manual(values = c(24,21))
        p + ylim(2,10) + 
            ylab("Gain \nRatio") + 
            xlab("Teeth in rear sprocket") +
            labs(colour = "Configuration", 
                 fill = "Configuration",
                 shape = "Chain Ring") +
            theme(legend.title = element_text(
                face = "bold", size = 14)) +
            theme(legend.text = element_text(size = 12))+
            theme(legend.key = element_blank()) +
            theme(axis.text.x = element_text(colour = "darkred", 
                                             size = 14))+
            theme(axis.text.y = element_text(colour = "darkred", 
                                             size = 14))+
            theme(axis.title.x = element_text(face = "italic", size = 20))+
            theme(axis.title.y = element_text(face = "italic", size = 20,
                                              angle = 0)) 
    })
})


