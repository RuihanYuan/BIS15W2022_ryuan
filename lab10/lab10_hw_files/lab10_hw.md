---
title: "Lab 10 Homework"
author: "Ruihan Yuan"
date: "2022-02-08"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

## Desert Ecology
For this assignment, we are going to use a modified data set on [desert ecology](http://esapubs.org/archive/ecol/E090/118/). The data are from: S. K. Morgan Ernest, Thomas J. Valone, and James H. Brown. 2009. Long-term monitoring and experimental manipulation of a Chihuahuan Desert ecosystem near Portal, Arizona, USA. Ecology 90:1708.

```r
deserts <- read_csv(here("lab10", "data", "surveys_complete.csv"))
```

```
## Rows: 34786 Columns: 13
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (6): species_id, sex, genus, species, taxa, plot_type
## dbl (7): record_id, month, day, year, plot_id, hindfoot_length, weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Use the function(s) of your choice to get an idea of its structure, including how NA's are treated. Are the data tidy?  


```r
glimpse(deserts)
```

```
## Rows: 34,786
## Columns: 13
## $ record_id       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,…
## $ month           <dbl> 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, …
## $ day             <dbl> 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16…
## $ year            <dbl> 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, 1977, …
## $ plot_id         <dbl> 2, 3, 2, 7, 3, 1, 2, 1, 1, 6, 5, 7, 3, 8, 6, 4, 3, 2, …
## $ species_id      <chr> "NL", "NL", "DM", "DM", "DM", "PF", "PE", "DM", "DM", …
## $ sex             <chr> "M", "M", "F", "M", "M", "M", "F", "M", "F", "F", "F",…
## $ hindfoot_length <dbl> 32, 33, 37, 36, 35, 14, NA, 37, 34, 20, 53, 38, 35, NA…
## $ weight          <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ genus           <chr> "Neotoma", "Neotoma", "Dipodomys", "Dipodomys", "Dipod…
## $ species         <chr> "albigula", "albigula", "merriami", "merriami", "merri…
## $ taxa            <chr> "Rodent", "Rodent", "Rodent", "Rodent", "Rodent", "Rod…
## $ plot_type       <chr> "Control", "Long-term Krat Exclosure", "Control", "Rod…
```

```r
deserts%>%
  skimr::skim()
```


Table: Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |34786      |
|Number of columns        |13         |
|_______________________  |           |
|Column type frequency:   |           |
|character                |6          |
|numeric                  |7          |
|________________________ |           |
|Group variables          |None       |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|species_id    |         0|          1.00|   2|   2|     0|       48|          0|
|sex           |      1748|          0.95|   1|   1|     0|        2|          0|
|genus         |         0|          1.00|   6|  16|     0|       26|          0|
|species       |         0|          1.00|   3|  15|     0|       40|          0|
|taxa          |         0|          1.00|   4|   7|     0|        4|          0|
|plot_type     |         0|          1.00|   7|  25|     0|        5|          0|


**Variable type: numeric**

|skim_variable   | n_missing| complete_rate|     mean|       sd|   p0|     p25|     p50|      p75|  p100|hist  |
|:---------------|---------:|-------------:|--------:|--------:|----:|-------:|-------:|--------:|-----:|:-----|
|record_id       |         0|          1.00| 17804.20| 10229.68|    1| 8964.25| 17761.5| 26654.75| 35548|▇▇▇▇▇ |
|month           |         0|          1.00|     6.47|     3.40|    1|    4.00|     6.0|    10.00|    12|▇▆▆▅▇ |
|day             |         0|          1.00|    16.10|     8.25|    1|    9.00|    16.0|    23.00|    31|▆▇▇▇▆ |
|year            |         0|          1.00|  1990.50|     7.47| 1977| 1984.00|  1990.0|  1997.00|  2002|▇▆▇▇▇ |
|plot_id         |         0|          1.00|    11.34|     6.79|    1|    5.00|    11.0|    17.00|    24|▇▆▇▆▅ |
|hindfoot_length |      3348|          0.90|    29.29|     9.56|    2|   21.00|    32.0|    36.00|    70|▁▇▇▁▁ |
|weight          |      2503|          0.93|    42.67|    36.63|    4|   20.00|    37.0|    48.00|   280|▇▁▁▁▁ |

```r
naniar::miss_var_summary(deserts)
```

```
## # A tibble: 13 × 3
##    variable        n_miss pct_miss
##    <chr>            <int>    <dbl>
##  1 hindfoot_length   3348     9.62
##  2 weight            2503     7.20
##  3 sex               1748     5.03
##  4 record_id            0     0   
##  5 month                0     0   
##  6 day                  0     0   
##  7 year                 0     0   
##  8 plot_id              0     0   
##  9 species_id           0     0   
## 10 genus                0     0   
## 11 species              0     0   
## 12 taxa                 0     0   
## 13 plot_type            0     0
```
This data is not tidy.

2. How many genera and species are represented in the data? What are the total number of observations? Which species is most/ least frequently sampled in the study?


```r
deserts%>%
  summarize(n_species=n_distinct(species),
            n_genera=n_distinct(genus),
            n=n())
```

```
## # A tibble: 1 × 3
##   n_species n_genera     n
##       <int>    <int> <int>
## 1        40       26 34786
```


```r
deserts%>%
  count(species,sort=T)%>%
  head(n=1)
```

```
## # A tibble: 1 × 2
##   species      n
##   <chr>    <int>
## 1 merriami 10596
```

```r
deserts%>%
  count(species,sort=T)%>%
  tail(n=1)
```

```
## # A tibble: 1 × 2
##   species     n
##   <chr>   <int>
## 1 viridis     1
```

3. What is the proportion of taxa included in this study? Show a table and plot that reflects this count.


```r
deserts%>%
  count(taxa)%>%
  ggplot(aes(x=taxa,y=log10(n),fill=taxa))+geom_col()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title = "Proportion of Taxa in Desert Data",
       x = "Taxa")
```

![](lab10_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

4. For the taxa included in the study, use the fill option to show the proportion of individuals sampled by `plot_type.`


```r
deserts%>%
  ggplot(aes(x=taxa,fill=plot_type))+geom_bar(position = "dodge") +
  scale_y_log10()+
  theme(plot.title=element_text(size=rel(1.5),hjust=(0.5)))+
  labs(title = "Taxa by plot type",
       x="Taxa",
       y="Number of Individuals")
```

![](lab10_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


5. What is the range of weight for each species included in the study? Remove any observations of weight that are NA so they do not show up in the plot.


```r
deserts%>%
  ggplot(aes(x=species,y=weight,fill=species))+geom_boxplot(na.rm=T)+
  coord_flip()+
  theme(plot.title=element_text(size=rel(1.5),hjust=(0.5),face="bold"))+
  labs(title = "Distribution of Weight by Speices",
       x="Species",
       y="Weight")
```

![](lab10_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->


6. Add another layer to your answer from #4 using `geom_point` to get an idea of how many measurements were taken for each species.


```r
deserts%>%
  filter(weight!="NA")%>%
  ggplot(aes(x=species,y=weight,fill=species))+geom_boxplot(na.rm=T)+
  coord_flip()+
  geom_point(size=0.5)+
  theme(plot.title=element_text(size=rel(1.5),hjust=(0.5),face="bold"))+
  labs(title = "Distribution of Weight by Speices",
       x="Species",
       y="Weight")
```

![](lab10_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->
7. [Dipodomys merriami](https://en.wikipedia.org/wiki/Merriam's_kangaroo_rat) is the most frequently sampled animal in the study. How have the number of observations of this species changed over the years included in the study?


```r
deserts%>%
  filter(species_id=="DM")%>%
  ggplot(aes(x=year))+
  geom_bar()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title = "Observations of Dipodomys merriami over years",
       x="Year",
       y=NULL)
```

![](lab10_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->
8. What is the relationship between `weight` and `hindfoot` length? Consider whether or not over plotting is an issue.


```r
deserts%>%
  ggplot(aes(x=weight,y=hindfoot_length))+geom_point(na.rm=T,size=0.1)+
  geom_smooth(method="lm",se=F)+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title = "Weight vs. Hindfoot",
       x="Weight",
       y="Hindfoot")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

```
## Warning: Removed 4048 rows containing non-finite values (stat_smooth).
```

![](lab10_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

9. Which two species have, on average, the highest weight? Once you have identified them, make a new column that is a ratio of `weight` to `hindfoot_length`. Make a plot that shows the range of this new ratio and fill by sex.


```r
deserts%>%
  group_by(species)%>%
  filter(weight!="NA")%>%
  summarize(avg_weight=mean(weight))%>%
  arrange(desc(avg_weight))
```

```
## # A tibble: 22 × 2
##    species      avg_weight
##    <chr>             <dbl>
##  1 albigula          159. 
##  2 spectabilis       120. 
##  3 spilosoma          93.5
##  4 hispidus           65.6
##  5 fulviventer        58.9
##  6 ochrognathus       55.4
##  7 ordii              48.9
##  8 merriami           43.2
##  9 baileyi            31.7
## 10 leucogaster        31.6
## # … with 12 more rows
```

```r
deserts%>%
  filter(species=="albigula"|species=="spectabilis")%>%
  filter(weight!="NA"&hindfoot_length!="NA")%>%
  mutate(ratio=weight/hindfoot_length)%>%
  select(species,weight,hindfoot_length,sex,ratio)%>%
  ggplot(aes(x=species,y=ratio,fill=sex))+geom_boxplot()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title="Ratio of Weight to Hindfoot by Sex",
       x="species",
       y="Ratio")
```

![](lab10_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


10. Make one plot of your choice! Make sure to include at least two of the aesthetics options you have learned.


```r
deserts%>%
  filter(weight!="NA")%>%
  ggplot(aes(x=year,y=weight,fill=year))+geom_col()+
  scale_y_log10()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title="Observations of Weight by Years",
       x="Year",
       y="Weight")
```

![](lab10_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
