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
           selectInput("x","select ethnicity",
                       choices = c("International","Unknown","White","Asian","Chicano/Latino","American Indian","African American","All"),
                       selected = "International"),
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
      filter(ethnicity==input$x&campus==input$y&category==input$z)%>%
      ggplot(aes_string(x="academic_yr",y="filtered_count_fr"))+
      geom_col(fill="orange",position="dodge",alpha=0.8,color="Black")+
      theme_linedraw(base_size = 18)+
      theme(axis.text.x = element_text(hjust = 1))+
      labs(x="Academic Year", y="Enrollment")
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)