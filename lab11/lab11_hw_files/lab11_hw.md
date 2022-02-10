---
title: "Lab 11 Homework"
author: "Please Add Your Name Here"
date: "2022-02-10"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

**In this homework, you should make use of the aesthetics you have learned. It's OK to be flashy!**

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we will use for midterm 2 so this is good practice.

```r
#install.packages("gapminder")
library("gapminder")
```


```r
options(scipen = 999)
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NA's are treated in the data.**  


```r
gapminder
```

```
## # A tibble: 1,704 × 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # … with 1,694 more rows
```


```r
glimpse(gapminder)
```

```
## Rows: 1,704
## Columns: 6
## $ country   <fct> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", …
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, …
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, …
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.8…
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 12…
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134, …
```

```r
anyNA(gapminder)
```

```
## [1] FALSE
```


```r
summary(gapminder)
```

```
##         country        continent        year         lifeExp     
##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
##  Australia  :  12                  Max.   :2007   Max.   :82.60  
##  (Other)    :1632                                                
##       pop               gdpPercap       
##  Min.   :     60011   Min.   :   241.2  
##  1st Qu.:   2793664   1st Qu.:  1202.1  
##  Median :   7023596   Median :  3531.8  
##  Mean   :  29601212   Mean   :  7215.3  
##  3rd Qu.:  19585222   3rd Qu.:  9325.5  
##  Max.   :1318683096   Max.   :113523.1  
## 
```

```r
naniar::miss_var_summary(gapminder)
```

```
## # A tibble: 6 × 3
##   variable  n_miss pct_miss
##   <chr>      <int>    <dbl>
## 1 country        0        0
## 2 continent      0        0
## 3 year           0        0
## 4 lifeExp        0        0
## 5 pop            0        0
## 6 gdpPercap      0        0
```

```r
gapminder<-clean_names(gapminder)
names(gapminder)
```

```
## [1] "country"    "continent"  "year"       "life_exp"   "pop"       
## [6] "gdp_percap"
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**


```r
gapminder%>%
  group_by(year)%>%
  summarize(avg_life_exp=mean(life_exp))%>%
  ggplot(aes(x=year,y=avg_life_exp,color=avg_life_exp))+
  geom_point()+
  theme_bw()+
  labs(title = "Change of Life Expectancy between 1952 and 2007",
       x="year",
       y="Mean Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

**3. How do the distributions of life expectancy compare for the years 1952 and 2007?**

```r
gapminder%>%
  filter(year=="1952"|year=="2007")%>%
  mutate(year=as.factor(year))%>%
  ggplot(aes(x=life_exp,fill=year))+
  geom_density(alpha=0.6)+
  theme_linedraw()+
  theme(axis.text.x = element_text( hjust=1))+
  labs(title = "Distribution of Life Expectancy in 1952 vs. 2007",
       x = "Life Expectancy",
       y= "Density")
```

![](lab11_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->


**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**


```r
gapminder%>%
  group_by(continent,year)%>%
  summarise(min=min(life_exp),
            mean=mean(life_exp),
            max=max(life_exp))
```

```
## `summarise()` has grouped output by 'continent'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 60 × 5
## # Groups:   continent [5]
##    continent  year   min  mean   max
##    <fct>     <int> <dbl> <dbl> <dbl>
##  1 Africa     1952  30    39.1  52.7
##  2 Africa     1957  31.6  41.3  58.1
##  3 Africa     1962  32.8  43.3  60.2
##  4 Africa     1967  34.1  45.3  61.6
##  5 Africa     1972  35.4  47.5  64.3
##  6 Africa     1977  36.8  49.6  67.1
##  7 Africa     1982  38.4  51.6  69.9
##  8 Africa     1987  39.9  53.3  71.9
##  9 Africa     1992  23.6  53.6  73.6
## 10 Africa     1997  36.1  53.6  74.8
## # … with 50 more rows
```


```r
gapminder%>%
  group_by(year,continent)%>%
  ggplot(aes(group=continent,x=continent,y=life_exp,fill=continent))+
  geom_boxplot()+
  facet_wrap(~year)+
  labs(title="Life Expectancy Changed by Continent per year",
       x="Continent",
       y="Life Expectancy")+
  theme_linedraw()+
  theme(axis.text.x = element_text(angle=60,hjust=1),plot.title = element_text(hjust = 0.5,face = "bold"))
```

![](lab11_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

**5. How has life expectancy changed between 1952-2007 for each continent?**


```r
gapminder%>%
  group_by(year,continent)%>%
  summarize(mean=mean(life_exp))%>%
  ggplot(aes(x=year,y=mean,fill=continent))+
  geom_boxplot(alpha=0.6)+
  theme_linedraw()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5,face="bold"))+
  labs(title = "Change of Life Expectancy between 1952 to 2007 by Continent",
       x="Year",
       y="Mean Life Expectancy")
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

![](lab11_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
gapminder %>% 
  group_by(continent,year)%>%
  filter(between(year,1952,2007))%>%
  summarize(mean_life_exp=mean(life_exp))
```

```
## `summarise()` has grouped output by 'continent'. You can override using the
## `.groups` argument.
```

```
## # A tibble: 60 × 3
## # Groups:   continent [5]
##    continent  year mean_life_exp
##    <fct>     <int>         <dbl>
##  1 Africa     1952          39.1
##  2 Africa     1957          41.3
##  3 Africa     1962          43.3
##  4 Africa     1967          45.3
##  5 Africa     1972          47.5
##  6 Africa     1977          49.6
##  7 Africa     1982          51.6
##  8 Africa     1987          53.3
##  9 Africa     1992          53.6
## 10 Africa     1997          53.6
## # … with 50 more rows
```


```r
gapminder%>%
  group_by(year,continent)%>%
  filter(between(year,1952,2007))%>%
  summarize(mean_life_exp=mean(life_exp))%>%
  ggplot(aes(x=year,y=mean_life_exp))+
  geom_line()+
  geom_point(shape=4,color="plum")+
  facet_wrap(~continent)+
  labs(title="Life Expectancy between 1952 to 2007 per Continent",
       x="Year",
       y="Life Expectancy")+
  theme_bw()+
  theme(axis.title.x = element_text(hjust=1),plot.title = element_text(hjust=0.5,face = "bold"))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

![](lab11_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->





**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**



```r
gapminder%>%
  ggplot(aes(x=gdp_percap,y=life_exp,color=continent,shape=continent,alpha=0.6))+
  geom_point(size=1)+
  scale_x_log10()+
  geom_smooth(method="lm",se=F)+
  theme_linedraw()+
  theme(plot.title = element_text(size=rel(1.5),hjust=0.5))+
  labs(title="Relationship between GDP per capita and Life Expectancy",
       x="GDP per cap",
       y="Life Expectancy")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](lab11_hw_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


**7. Which countries have had the largest population growth since 1952?**


```r
gapminder%>%
  select(country,year,pop)%>%
  filter(year=="1952"|year=="2007")%>%
  pivot_wider(names_from = year,
              names_prefix = "yr_",
              values_from = pop)%>%
  mutate(growth=yr_2007 - yr_1952)%>%
  arrange(desc(growth))
```

```
## # A tibble: 142 × 4
##    country         yr_1952    yr_2007    growth
##    <fct>             <int>      <int>     <int>
##  1 China         556263527 1318683096 762419569
##  2 India         372000000 1110396331 738396331
##  3 United States 157553000  301139947 143586947
##  4 Indonesia      82052000  223547000 141495000
##  5 Brazil         56602560  190010647 133408087
##  6 Pakistan       41346560  169270617 127924057
##  7 Bangladesh     46886859  150448339 103561480
##  8 Nigeria        33119096  135031164 101912068
##  9 Mexico         30144317  108700891  78556574
## 10 Philippines    22438691   91077287  68638596
## # … with 132 more rows
```

**8. Use your results from the question above to plot population growth for the top five countries since 1952.**


```r
gapminder%>%
  select(country,year,pop)%>%
  filter(year=="1952"|year=="2007")%>%
  pivot_wider(names_from = year,
              names_prefix = "yr_",
              values_from = pop)%>%
  mutate(growth=yr_2007 - yr_1952)%>%
  arrange(desc(growth))%>%
  head(n=5)%>%
  ggplot(aes(x=country,y=growth,fill=country))+
  geom_col()+
  theme_linedraw()+
  theme(plot.title = element_text(hjust=1,face = "bold"))+
  labs(title="Top 5 Population Growth from 1952 to 2007",
       x="Country",
       y="Population Growth")
```

![](lab11_hw_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

**9. How does per-capita GDP growth compare between these same five countries?**


```r
gapminder%>%
  filter(country=="Brazil"|country=="China"|country=="India"|country=="Indonesia"|country=="United States")%>%
  group_by(country)%>%
  summarize(total_gdp_percap=sum(gdp_percap))
```

```
## # A tibble: 5 × 2
##   country       total_gdp_percap
##   <fct>                    <dbl>
## 1 Brazil                  69952.
## 2 China                   17860.
## 3 India                   12688.
## 4 Indonesia               20896.
## 5 United States          315134.
```


```r
gapminder%>%
  filter(country=="Brazil"|country=="China"|country=="India"|country=="Indonesia"|country=="United States")%>%
  group_by(country)%>%
  summarize(total_gdp_percap=sum(gdp_percap))%>%
  ggplot(aes(x=country,y=total_gdp_percap,fill=country))+
  geom_col()+
  theme_linedraw()+
  theme(plot.title=element_text(hjust=0.5,face = "bold"))+
  labs(title="Top 5 GDP per capita Growth since 1952",
       x="Country",
       y="GDP per cap Grwoth")
```

![](lab11_hw_files/figure-html/unnamed-chunk-21-1.png)<!-- -->

**10. Make one plot of your choice that uses faceting!**


```r
names(gapminder)
```

```
## [1] "country"    "continent"  "year"       "life_exp"   "pop"       
## [6] "gdp_percap"
```


```r
gapminder%>%
  filter(country=="Brazil"|country=="China"|country=="India"|country=="Indonesia"|country=="United States")%>%
  ggplot(aes(x=pop,y=life_exp,color=country))+
  geom_line()+
  facet_wrap(~country)+
  theme_linedraw()+
  theme(plot.title=element_text(hjust=1))+
  labs(title = "Life Expectancy vs Population",
       x="population",
       y="Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-23-1.png)<!-- -->
I try to see if there's an positive relationship between population and life expectancy for the top 5 population growth countries. And the graph shows that as population increases, life expectancy also increases.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
