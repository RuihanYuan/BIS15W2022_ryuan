library("shiny")
library("tidyverse")
library("shinydashboard")

uc_admit<-read_csv("data/uc_data/UC_admit.csv")%>%clean_names()

ui <- dashboardPage(
  dashboardHeader(title = "UC Admission"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box( title = "Select variable",width = 3,
           selectInput("x","select year",
                       choices = c("2010","2011","2012","2013","2014","2015","2016","2017","2018","2019"),
                       selected = "2010"),
           selectInput("y","select campus",
                       choices = c("Berkeley","Davis","Irvine","Los_Angeles","Merced","Riverside","San_Diego","Santa_Barbara","Santa_Cruz"),
                       selected = "Berkeley"),
           selectInput("z","select admit category",
                       choices = c("Admits","Enrollees","Applicants"),
                       selected = "Admits")
      ),
      box(
        title = "UC admission Plot",width = 7,
        plotOutput("plot",width = "600px",height = "500px")
      )
    )
  )
)

server <- function(input, output,session) { 
  output$plot<-renderPlot({
    uc_admit%>%
      filter(academic_yr==input$x,campus==input$y,category==input$z)%>%
      ggplot(aes_string(x="ethnicity",y="filtered_count_fr",fill="ethnicity"))+
      geom_col(alpha=0.8,color="Black")+
      theme_linedraw()+
      theme(axis.text.x = element_text(hjust = 1,angle = 60))+
      labs(x="Ethnicity", y="Flitered Count")
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)