---
title: "Lab 13 Homework"
author: "Ruihan Yuan"
date: "2022-02-24"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Libraries

```r
library(tidyverse)
library(shiny)
library(shinydashboard)
library(here)
library(janitor)
library(lubridate)
```

## Choose Your Adventure!
For this homework assignment, you have two choices of data. You only need to build an app for one of them. The first dataset is focused on UC Admissions and the second build on the Gabon data that we used for midterm 1.  

## Option 1
The data for this assignment come from the [University of California Information Center](https://www.universityofcalifornia.edu/infocenter). Admissions data were collected for the years 2010-2019 for each UC campus. Admissions are broken down into three categories: applications, admits, and enrollees. The number of individuals in each category are presented by demographic.  

**1. Load the `UC_admit.csv` data and use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine if there are NA's and how they are treated.**  


```r
uc_admit<-read_csv(here("lab13","data","uc_data","UC_admit.csv"))%>%clean_names()
```

```
## Rows: 2160 Columns: 6
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): Campus, Category, Ethnicity, Perc FR
## dbl (2): Academic_Yr, FilteredCountFR
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
glimpse(uc_admit)
```

```
## Rows: 2,160
## Columns: 6
## $ campus            <chr> "Davis", "Davis", "Davis", "Davis", "Davis", "Davis"…
## $ academic_yr       <dbl> 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2019, 2018…
## $ category          <chr> "Applicants", "Applicants", "Applicants", "Applicant…
## $ ethnicity         <chr> "International", "Unknown", "White", "Asian", "Chica…
## $ perc_fr           <chr> "21.16%", "2.51%", "18.39%", "30.76%", "22.44%", "0.…
## $ filtered_count_fr <dbl> 16522, 1959, 14360, 24024, 17526, 277, 3425, 78093, …
```

```r
names(uc_admit)
```

```
## [1] "campus"            "academic_yr"       "category"         
## [4] "ethnicity"         "perc_fr"           "filtered_count_fr"
```

```r
naniar::miss_var_summary(uc_admit)
```

```
## # A tibble: 6 × 3
##   variable          n_miss pct_miss
##   <chr>              <int>    <dbl>
## 1 perc_fr                1   0.0463
## 2 filtered_count_fr      1   0.0463
## 3 campus                 0   0     
## 4 academic_yr            0   0     
## 5 category               0   0     
## 6 ethnicity              0   0
```
There are NAs in the data and represented by NA





**2. The president of UC has asked you to build a shiny app that shows admissions by ethnicity across all UC campuses. Your app should allow users to explore year, campus, and admit category as interactive variables. Use shiny dashboard and try to incorporate the aesthetics you have learned in ggplot to make the app neat and clean.**



```r
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
      filter(academic_yr==input$x&campus==input$y&category==input$z)%>%
      ggplot(aes_string(x="ethnicity",y="filtered_count_fr",fill="ethnicity"))+
      geom_col(alpha=0.8,color="Black")+
      theme_linedraw()+
      theme(axis.text.x = element_text(hjust = 1,angle = 60))+
      labs(x="Ethnicity", y="Flitered Count")
  })
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}




**3. Make alternate version of your app above by tracking enrollment at a campus over all of the represented years while allowing users to interact with campus, category, and ethnicity.**  


```r
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
```

`<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>`{=html}


## Option 2
We will use data from a study on vertebrate community composition and impacts from defaunation in Gabon, Africa. Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016.   

**1. Load the `IvindoData_DryadVersion.csv` data and use the function(s) of your choice to get an idea of the overall structure, including its dimensions, column names, variable classes, etc. As part of this, determine if NA's are present and how they are treated.**  

**2. Build an app that re-creates the plots shown on page 810 of this paper. The paper is included in the folder. It compares the relative abundance % to the distance from villages in rural Gabon. Use shiny dashboard and add aesthetics to the plot.  **  

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
