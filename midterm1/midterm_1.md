---
title: "Midterm 1"
author: "Ruihan Yuan"
date: "2022-01-25"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 15 total questions, each is worth 2 points.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by 12:00p on Thursday, January 27.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
## ✓ readr   2.1.1     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Questions  
Wikipedia's definition of [data science](https://en.wikipedia.org/wiki/Data_science): "Data science is an interdisciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from noisy, structured and unstructured data, and apply knowledge and actionable insights from data across a broad range of application domains."  

1. (2 points) Consider the definition of data science above. Although we are only part-way through the quarter, what specific elements of data science do you feel we have practiced? Provide at least one specific example.  

We used R and Rstudio to work with data and apply different algorithms with it. We can import the data into Rstudio and re-oragnize it using R. For example, we can use tabyl() function to get a table of summerized information to give us a better understanding and overview of the data taht we have. We can use select functions to extract data in columns and do different algorithm with it, like mean, median, etc. to get the information that we want.

2. (2 points) What is the most helpful or interesting thing you have learned so far in BIS 15L? What is something that you think needs more work or practice? 

I think the most interesting part is the use of dplyr. It is very powerful and convenient when transforming data frames. I think I still need to do more practices and my proficiency with those functions still need to be improved.
I want to find shorter routes, so that my work will look cleaner. I think I can reach this goal by doing more practices and learning new knowledge.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.

```r
elephants<-readr::read_csv("data/ElephantsMF.csv")
```

```
## Rows: 288 Columns: 3
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): Sex
## dbl (2): Age, Height
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, 1…
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00,…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M"…
```

```r
names(elephants)
```

```
## [1] "Age"    "Height" "Sex"
```
The class of Age and Height is numeric(dbl) and class of sex is chracater(chr)


4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.


```r
elephants<-janitor::clean_names(elephants)
names(elephants)
```

```
## [1] "age"    "height" "sex"
```

```r
elephants$sex<-as.factor(elephants$sex)
class(elephants$sex)
```

```
## [1] "factor"
```

5. (2 points) How many male and female elephants are represented in the data?


```r
elephants%>%
  group_by(sex)%>%
  summarize(total=n())
```

```
## # A tibble: 2 × 2
##   sex   total
##   <fct> <int>
## 1 F       150
## 2 M       138
```

6. (2 points) What is the average age all elephants in the data?

```r
elephants%>%
  summarize(average_age=mean(age))
```

```
## # A tibble: 1 × 1
##   average_age
##         <dbl>
## 1        11.0
```

7. (2 points) How does the average age and height of elephants compare by sex?

```r
elephants%>%
  group_by(sex)%>%
  summarize(average_age=mean(age),
            average_height=mean(height))
```

```
## # A tibble: 2 × 3
##   sex   average_age average_height
##   <fct>       <dbl>          <dbl>
## 1 F           12.8            190.
## 2 M            8.95           185.
```

8. (2 points) How does the average height of elephants compare by sex for individuals over 20 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.  

```r
elephants%>%
  group_by(sex)%>%
  filter(age>20)%>%
  summarize(average_height=mean(height),
            min_height=min(height),
            max_height=max(height),
            total=n())
```

```
## # A tibble: 2 × 5
##   sex   average_height min_height max_height total
##   <fct>          <dbl>      <dbl>      <dbl> <int>
## 1 F               232.       193.       278.    37
## 2 M               270.       229.       304.    13
```

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.

```r
vertebrate<-readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## Rows: 24 Columns: 26
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): HuntCat, LandUse
## dbl (24): TransectID, Distance, NumHouseholds, Veg_Rich, Veg_Stems, Veg_lian...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
glimpse(vertebrate)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 16, …
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24.06…
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None", "N…
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46, 56…
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", "Pa…
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 14.7…
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 31.2…
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38, 8…
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 51.2…
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4.00…
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2.71…
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, 6.1…
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 42.6…
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0.43…
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 46.2…
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1.26…
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10, 8…
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21, 22…
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0.81…
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2.56…
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11, 1…
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0.80…
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1.92…
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 11, …
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0.77…
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1.92…
```

```r
names(vertebrate)
```

```
##  [1] "TransectID"              "Distance"               
##  [3] "HuntCat"                 "NumHouseholds"          
##  [5] "LandUse"                 "Veg_Rich"               
##  [7] "Veg_Stems"               "Veg_liana"              
##  [9] "Veg_DBH"                 "Veg_Canopy"             
## [11] "Veg_Understory"          "RA_Apes"                
## [13] "RA_Birds"                "RA_Elephant"            
## [15] "RA_Monkeys"              "RA_Rodent"              
## [17] "RA_Ungulate"             "Rich_AllSpecies"        
## [19] "Evenness_AllSpecies"     "Diversity_AllSpecies"   
## [21] "Rich_BirdSpecies"        "Evenness_BirdSpecies"   
## [23] "Diversity_BirdSpecies"   "Rich_MammalSpecies"     
## [25] "Evenness_MammalSpecies"  "Diversity_MammalSpecies"
```

```r
vertebrate$HuntCat<-as.factor(vertebrate$HuntCat)
vertebrate$LandUse<-as.factor(vertebrate$LandUse)
```


```r
class(vertebrate$HuntCat)
```

```
## [1] "factor"
```

```r
class(vertebrate$LandUse)
```

```
## [1] "factor"
```


10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?


```r
vertebrate%>%
  group_by(HuntCat)%>%
  filter(HuntCat !="None")%>%
  summarize(average_diversity_bird=mean(Diversity_BirdSpecies),
            average_diversity_mammal=mean(Diversity_MammalSpecies),
            total=n())
```

```
## # A tibble: 2 × 4
##   HuntCat  average_diversity_bird average_diversity_mammal total
##   <fct>                     <dbl>                    <dbl> <int>
## 1 High                       1.66                     1.74     7
## 2 Moderate                   1.62                     1.68     8
```


11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 3km from a village to sites that are greater than 25km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator. 

```r
vertebrate%>%
  group_by(Distance<3,Distance>25)%>%
  filter(Distance<3|Distance>25)%>%
  summarize(across(contains("RA"),mean))
```

```
## `summarise()` has grouped output by 'Distance < 3'. You can override using the `.groups` argument.
```

```
## # A tibble: 2 × 9
## # Groups:   Distance < 3 [2]
##   `Distance < 3` `Distance > 25` TransectID RA_Apes RA_Birds RA_Elephant
##   <lgl>          <lgl>                <dbl>   <dbl>    <dbl>       <dbl>
## 1 FALSE          TRUE                    24    4.91     31.6       0    
## 2 TRUE           FALSE                   21    0.12     76.6       0.145
## # … with 3 more variables: RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>
```


12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`
I want to check if the hunting rate will affect the evenness of birds and mammals

```r
vertebrate%>%
  group_by(HuntCat)%>%
  summarize(across(c(Evenness_MammalSpecies,Evenness_BirdSpecies),
                   n_distinct))
```

```
## # A tibble: 3 × 3
##   HuntCat  Evenness_MammalSpecies Evenness_BirdSpecies
##   <fct>                     <int>                <int>
## 1 High                          7                    7
## 2 Moderate                      7                    8
## 3 None                          9                    9
```
I think it is very interesting that the evenness of mammals and birds are almost identical to each other in different hunting rates. As we can see from above, the hunting rate will have an effect on the evenness of mammals and birds because the evenness is the highest when no hunting occur.

What about the effect on abundance?


```r
vertebrate%>%
  group_by(HuntCat)%>%
  summarize(across(contains("RA"),n_distinct))
```

```
## # A tibble: 3 × 8
##   HuntCat  TransectID RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent
##   <fct>         <int>   <int>    <int>       <int>      <int>     <int>
## 1 High              7       3        7           4          7         7
## 2 Moderate          8       6        8           4          8         8
## 3 None              8       8        9           8          9         9
## # … with 1 more variable: RA_Ungulate <int>
```
We got the same conclusion as above that the hunting rate will have an effect on abundance of species. Apes and elephant have a relatively larger difference between different hunting rates.


