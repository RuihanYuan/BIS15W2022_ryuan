---
title: "Transforming data 2: `filter()`"
date: "2022-01-13"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
  pdf_document:
    toc: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to HW 2 in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Use the functions of dplyr (filter, select, arrange) to organize and sort data frames.  
2. Use `mutate()` to calculate a new column from existing columns.  

## Review  
In the previous lab, we used `select()` to extract columns of interest from a data frame. This helps us focus our attention on the variables relevant to our question. However, it doesn't allow us to extract observations from within the data frame. The `filter()` function allows us to extract data that meet specific criteria. When combined with `select()`, we have the power to transform, shape, and explore data with the potential to make new discoveries.  

## Load the tidyverse

```r
library("tidyverse")
```

## Load the data
For these exercises we will use the data from lab 4_1.  

```r
fish <- readr::read_csv("data/Gaeta_etal_CLC_data.csv")
```

```
## Rows: 4033 Columns: 6
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (2): lakeid, annnumber
## dbl (4): fish_id, length, radii_length_mm, scalelength
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
mammals <- readr::read_csv("data/mammal_lifehistories_v2.csv")
```

```
## Rows: 1440 Columns: 13
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): order, family, Genus, species
## dbl (9): mass, gestation, newborn, weaning, wean mass, AFR, max. life, litte...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

To keep things tidy, I am going to rename the variables in the mammals data.  

```r
mammals <- rename(mammals, genus=Genus, wean_mass="wean mass", max_life="max. life", litter_size="litter size", litters_per_year="litters/year")
```


```r
names(mammals)
```

```
##  [1] "order"            "family"           "genus"            "species"         
##  [5] "mass"             "gestation"        "newborn"          "weaning"         
##  [9] "wean_mass"        "AFR"              "max_life"         "litter_size"     
## [13] "litters_per_year"
```

```r
#install.packages("janitor")
library("janitor")
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

```r
mammals<- clean_names(mammals)
names(mammals)
```

```
##  [1] "order"            "family"           "genus"            "species"         
##  [5] "mass"             "gestation"        "newborn"          "weaning"         
##  [9] "wean_mass"        "afr"              "max_life"         "litter_size"     
## [13] "litters_per_year"
```


## `filter()`
Unlike `select()`, `filter()` allows us to extract data that meet specific criteria within a variable. Let's say that we are interested only in the fish that occur in lake "AL". We can use `filter()` to extract these observations. 

```r
fish
```

```
## # A tibble: 4,033 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 4,023 more rows
```

```r
select(fish,lakeid,scalelength)
```

```
## # A tibble: 4,033 × 2
##    lakeid scalelength
##    <chr>        <dbl>
##  1 AL            2.70
##  2 AL            2.70
##  3 AL            2.70
##  4 AL            3.02
##  5 AL            3.02
##  6 AL            3.02
##  7 AL            3.02
##  8 AL            3.34
##  9 AL            3.34
## 10 AL            3.34
## # … with 4,023 more rows
```

```r
tabyl(fish,lakeid)
```

```
##  lakeid   n    percent
##      AL 383 0.09496653
##      AR 262 0.06496405
##      BO 197 0.04884701
##      BR 291 0.07215472
##      CR 343 0.08504835
##      DY 355 0.08802380
##      FD 302 0.07488222
##      JN 238 0.05901314
##      LC 173 0.04289611
##      LJ 181 0.04487974
##      LR 292 0.07240268
##     LSG 143 0.03545748
##      MN 293 0.07265063
##      RD 135 0.03347384
##      UB 191 0.04735929
##      WS 254 0.06298041
```


```r
filter(fish, lakeid == "AL")
```

```
## # A tibble: 383 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 373 more rows
```

Similarly, if we are only interested in fish with a length greater than or equal to 350 we can use `filter()` to extract these observations.  

```r
filter(fish, length >= 350)
```

```
## # A tibble: 890 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         306 EDGE         350            6.94        6.94
##  2 AL         306 10           350            6.46        6.94
##  3 AL         306 9            350            6.16        6.94
##  4 AL         306 8            350            5.88        6.94
##  5 AL         306 7            350            5.42        6.94
##  6 AL         306 6            350            4.90        6.94
##  7 AL         306 5            350            4.46        6.94
##  8 AL         306 4            350            3.75        6.94
##  9 AL         306 3            350            2.93        6.94
## 10 AL         306 2            350            2.14        6.94
## # … with 880 more rows
```

+ `filter()` allows all of the expected operators; i.e. >, >=, <, <=, != (not equal), and == (equal).  

Using the `!` operator allows for the exclusion of specific observations.

```r
filter(fish, lakeid != "AL")
```

```
## # A tibble: 3,650 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AR         269 EDGE         140            2.01        2.01
##  2 AR         269 1            140            1.48        2.01
##  3 AR         270 EDGE         193            2.66        2.66
##  4 AR         270 3            193            2.39        2.66
##  5 AR         270 2            193            2.03        2.66
##  6 AR         270 1            193            1.42        2.66
##  7 AR         271 EDGE         220            3.50        3.50
##  8 AR         271 5            220            3.13        3.50
##  9 AR         271 4            220            2.86        3.50
## 10 AR         271 3            220            2.63        3.50
## # … with 3,640 more rows
```

## Using `filter()` with multiple observations  
Filtering multiple values within the same variable requires the `%in%` [operator](https://www.tutorialspoint.com/r/r_operators.htm).    

```r
filter(fish, length %in% c(167, 175))
```

```
## # A tibble: 18 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167           2.70         2.70
##  2 AL         299 2            167           2.04         2.70
##  3 AL         299 1            167           1.31         2.70
##  4 AL         300 EDGE         175           3.02         3.02
##  5 AL         300 3            175           2.67         3.02
##  6 AL         300 2            175           2.14         3.02
##  7 AL         300 1            175           1.23         3.02
##  8 BO         397 EDGE         175           2.67         2.67
##  9 BO         397 3            175           2.39         2.67
## 10 BO         397 2            175           1.59         2.67
## 11 BO         397 1            175           0.830        2.67
## 12 LSG         45 EDGE         175           3.21         3.21
## 13 LSG         45 3            175           2.92         3.21
## 14 LSG         45 2            175           2.44         3.21
## 15 LSG         45 1            175           1.60         3.21
## 16 RD         103 EDGE         167           2.80         2.80
## 17 RD         103 2            167           2.10         2.80
## 18 RD         103 1            167           1.31         2.80
```

Alternatively, you can use `between` if you are looking for a range of specific values.  

```r
filter(fish, between(scalelength, 2.5, 2.55))
```

```
## # A tibble: 10 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 LSG         56 EDGE         145            2.55        2.55
##  2 LSG         56 2            145            1.94        2.55
##  3 LSG         56 1            145            1.20        2.55
##  4 LSG         57 EDGE         143            2.52        2.52
##  5 LSG         57 2            143            2.13        2.52
##  6 LSG         57 1            143            1.19        2.52
##  7 UB          80 EDGE         153            2.55        2.55
##  8 UB          80 3            153            2.10        2.55
##  9 UB          80 2            153            1.62        2.55
## 10 UB          80 1            153            1.14        2.55
```

You can also extract observations "near" a certain value but you need to specify a tolerance.  

```r
filter(fish, near(radii_length_mm, 2, tol = 0.2))
```

```
## # A tibble: 291 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 2            167            2.04        2.70
##  2 AL         300 2            175            2.14        3.02
##  3 AL         302 2            324            2.19        6.07
##  4 AL         303 2            325            2.04        6.79
##  5 AL         306 2            350            2.14        6.94
##  6 AL         308 2            355            1.86        6.67
##  7 AL         312 2            367            2.17        6.81
##  8 AL         313 2            367            2.06        6.47
##  9 AL         315 2            372            2.04        6.47
## 10 AL         316 2            372            1.82        6.35
## # … with 281 more rows
```

## Practice
1. Filter the `fish` data to include the samples from lake "BO".

```r
filter(fish, lakeid =="BO")
```

```
## # A tibble: 197 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 BO         389 EDGE         104           1.50         1.50
##  2 BO         389 1            104           0.736        1.50
##  3 BO         390 EDGE         105           1.59         1.59
##  4 BO         390 1            105           0.698        1.59
##  5 BO         391 EDGE         107           1.43         1.43
##  6 BO         391 1            107           0.695        1.43
##  7 BO         392 EDGE         124           2.11         2.11
##  8 BO         392 2            124           1.36         2.11
##  9 BO         392 1            124           0.792        2.11
## 10 BO         393 EDGE         141           2.16         2.16
## # … with 187 more rows
```

```r
table(fish$lakeid)#check all the lakeid in fish data
```

```
## 
##  AL  AR  BO  BR  CR  DY  FD  JN  LC  LJ  LR LSG  MN  RD  UB  WS 
## 383 262 197 291 343 355 302 238 173 181 292 143 293 135 191 254
```


2. Filter the data to include all lakes except "AR".

```r
filter(fish, lakeid !="AR")
```

```
## # A tibble: 3,771 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 3,761 more rows
```

3. Filter the fish data to include all fish with a scalelength within 0.25 of 8.

```r
filter(fish, near(scalelength, 8, tol=0.25))
```

```
## # A tibble: 236 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         309 EDGE         355            7.89        7.89
##  2 AL         309 13           355            7.56        7.89
##  3 AL         309 12           355            7.36        7.89
##  4 AL         309 11           355            7.16        7.89
##  5 AL         309 10           355            6.77        7.89
##  6 AL         309 9            355            6.39        7.89
##  7 AL         309 8            355            5.96        7.89
##  8 AL         309 7            355            5.44        7.89
##  9 AL         309 6            355            4.74        7.89
## 10 AL         309 5            355            4.06        7.89
## # … with 226 more rows
```

```r
filter(fish,near(radii_length_mm, 1, tol=0.1))
```

```
## # A tibble: 99 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         316 1            372           1.09         6.35
##  2 AR         273 1            230           1.07         3.92
##  3 AR         274 1            230           1.07         3.81
##  4 AR         275 1            233           1.10         3.98
##  5 AR         277 1            237           0.907        4.42
##  6 AR         278 1            238           1.08         4.42
##  7 AR         280 1            240           1.04         4.20
##  8 AR         284 1            246           1.04         3.52
##  9 AR         290 1            264           1.07         4.57
## 10 AR         292 1            267           1.10         4.56
## # … with 89 more rows
```


4. Filter the fish data to include fish with a scalelength between 2 and 4.

```r
filter(fish, between(scalelength, 2,4))
```

```
## # A tibble: 723 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 713 more rows
```

## Using `filter()` on multiple conditions
You can also use `filter()` to extract data based on multiple conditions. Below we extract only the fish that have lakeid "AL" and length >350.

```r
filter(fish, lakeid == "AL" & length > 350)#pull only fish that are AL "and" >350
```

```
## # A tibble: 314 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         307 EDGE         353            7.55        7.55
##  2 AL         307 13           353            7.28        7.55
##  3 AL         307 12           353            6.98        7.55
##  4 AL         307 11           353            6.73        7.55
##  5 AL         307 10           353            6.48        7.55
##  6 AL         307 9            353            6.22        7.55
##  7 AL         307 8            353            5.92        7.55
##  8 AL         307 7            353            5.44        7.55
##  9 AL         307 6            353            5.06        7.55
## 10 AL         307 5            353            4.37        7.55
## # … with 304 more rows
```

Notice that the `|` operator generates a different result.

```r
filter(fish, lakeid == "AL" | length > 350)# | for "or"
```

```
## # A tibble: 948 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         299 EDGE         167            2.70        2.70
##  2 AL         299 2            167            2.04        2.70
##  3 AL         299 1            167            1.31        2.70
##  4 AL         300 EDGE         175            3.02        3.02
##  5 AL         300 3            175            2.67        3.02
##  6 AL         300 2            175            2.14        3.02
##  7 AL         300 1            175            1.23        3.02
##  8 AL         301 EDGE         194            3.34        3.34
##  9 AL         301 3            194            2.97        3.34
## 10 AL         301 2            194            2.29        3.34
## # … with 938 more rows
```

Rules:  
+ `filter(condition1, condition2)` will return rows where both conditions are met.  
+ `filter(condition1, !condition2)` will return all rows where condition one is true but condition 2 is not.  
+ `filter(condition1 | condition2)` will return rows where condition 1 and/or condition 2 is met.  
+ `filter(xor(condition1, condition2)` will return all rows where only one of the conditions is met, and not when both conditions are met.  

In this case, we filter out the fish with a length over 400 and a scale length over 11 or a radii length over 8.

```r
filter(fish, length > 400, (scalelength > 11 | radii_length_mm > 8))
```

```
## # A tibble: 23 × 6
##    lakeid fish_id annnumber length radii_length_mm scalelength
##    <chr>    <dbl> <chr>      <dbl>           <dbl>       <dbl>
##  1 AL         324 EDGE         406            8.21        8.21
##  2 AL         327 EDGE         413            8.33        8.33
##  3 AL         327 15           413            8.11        8.33
##  4 AL         328 EDGE         420            8.71        8.71
##  5 AL         328 16           420            8.41        8.71
##  6 AL         328 15           420            8.14        8.71
##  7 WS         180 EDGE         403           11.0        11.0 
##  8 WS         180 16           403           10.6        11.0 
##  9 WS         180 15           403           10.3        11.0 
## 10 WS         180 14           403            9.93       11.0 
## # … with 13 more rows
```

## Practice  
1. Have a look at the mammals data using the summary functions of your choosing.    

```r
summary(mammals)
```

```
##     order              family             genus             species         
##  Length:1440        Length:1440        Length:1440        Length:1440       
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##       mass             gestation          newborn             weaning       
##  Min.   :     -999   Min.   :-999.00   Min.   :   -999.0   Min.   :-999.00  
##  1st Qu.:       50   1st Qu.:-999.00   1st Qu.:   -999.0   1st Qu.:-999.00  
##  Median :      403   Median :   1.05   Median :      2.6   Median :   0.73  
##  Mean   :   383577   Mean   :-287.25   Mean   :   6703.1   Mean   :-427.17  
##  3rd Qu.:     7009   3rd Qu.:   4.50   3rd Qu.:     98.0   3rd Qu.:   2.00  
##  Max.   :149000000   Max.   :  21.46   Max.   :2250000.0   Max.   :  48.00  
##    wean_mass             afr             max_life       litter_size      
##  Min.   :    -999   Min.   :-999.00   Min.   :-999.0   Min.   :-999.000  
##  1st Qu.:    -999   1st Qu.:-999.00   1st Qu.:-999.0   1st Qu.:   1.000  
##  Median :    -999   Median :   2.50   Median :-999.0   Median :   2.270  
##  Mean   :   16049   Mean   :-408.12   Mean   :-490.3   Mean   : -55.634  
##  3rd Qu.:      10   3rd Qu.:  15.61   3rd Qu.: 147.2   3rd Qu.:   3.835  
##  Max.   :19075000   Max.   : 210.00   Max.   :1368.0   Max.   :  14.180  
##  litters_per_year  
##  Min.   :-999.000  
##  1st Qu.:-999.000  
##  Median :   0.375  
##  Mean   :-477.141  
##  3rd Qu.:   1.155  
##  Max.   :   7.500
```

2. What are the names of the variables in the mammals data?  

```r
names(mammals)
```

```
##  [1] "order"            "family"           "genus"            "species"         
##  [5] "mass"             "gestation"        "newborn"          "weaning"         
##  [9] "wean_mass"        "afr"              "max_life"         "litter_size"     
## [13] "litters_per_year"
```

3.  From the `mammals` data, filter all members of the family Bovidae with a mass greater than 450000.

```r
filter(mammals, family =="Bovidae" & mass >45000)
```

```
## # A tibble: 54 × 13
##    order  family genus species   mass gestation newborn weaning wean_mass    afr
##    <chr>  <chr>  <chr> <chr>    <dbl>     <dbl>   <dbl>   <dbl>     <dbl>  <dbl>
##  1 Artio… Bovid… Addax nasoma… 1.82e5      9.39   5480     6.5       -999   27.3
##  2 Artio… Bovid… Alce… busela… 1.5 e5      7.9   10167.    6.5       -999   23.0
##  3 Artio… Bovid… Ammo… lervia  5.55e4      5.08   3810     4         -999   14.9
##  4 Artio… Bovid… Bison bison   4.98e5      8.93  20000    10.7     157500   29.4
##  5 Artio… Bovid… Bison bonasus 5   e5      9.14  23000.    6.6       -999   30.0
##  6 Artio… Bovid… Bos   grunni… 3.33e5      8.88  18000     7.33      -999   24.3
##  7 Artio… Bovid… Bos   fronta… 8   e5      9.02  23033.    4.5       -999   24.2
##  8 Artio… Bovid… Bos   javani… 6.67e5      9.83   -999     9.5       -999   25.5
##  9 Artio… Bovid… Bose… tragoc… 1.69e5      8.51   5875  -999         -999   30.0
## 10 Artio… Bovid… Buba… mindor… 2.33e5      9.85   -999  -999         -999 -999  
## # … with 44 more rows, and 3 more variables: max_life <dbl>, litter_size <dbl>,
## #   litters_per_year <dbl>
```

4. Let's say we are only interested in family, genus, species, mass, and gestation. Relimit the mammals data frame to these variables.  

```r
x<-select(mammals, family,genus,species,mass,gestation)
x
```

```
## # A tibble: 1,440 × 5
##    family         genus       species          mass gestation
##    <chr>          <chr>       <chr>           <dbl>     <dbl>
##  1 Antilocapridae Antilocapra americana      45375       8.13
##  2 Bovidae        Addax       nasomaculatus 182375       9.39
##  3 Bovidae        Aepyceros   melampus       41480       6.35
##  4 Bovidae        Alcelaphus  buselaphus    150000       7.9 
##  5 Bovidae        Ammodorcas  clarkei        28500       6.8 
##  6 Bovidae        Ammotragus  lervia         55500       5.08
##  7 Bovidae        Antidorcas  marsupialis    30000       5.72
##  8 Bovidae        Antilope    cervicapra     37500       5.5 
##  9 Bovidae        Bison       bison         497667.      8.93
## 10 Bovidae        Bison       bonasus       500000       9.14
## # … with 1,430 more rows
```

5. Use the output from #4 to focus on the family Bovidae with a mass greater than 450000.

```r
filter(x, family=="Bovidae" & mass>45000)
```

```
## # A tibble: 54 × 5
##    family  genus      species          mass gestation
##    <chr>   <chr>      <chr>           <dbl>     <dbl>
##  1 Bovidae Addax      nasomaculatus 182375       9.39
##  2 Bovidae Alcelaphus buselaphus    150000       7.9 
##  3 Bovidae Ammotragus lervia         55500       5.08
##  4 Bovidae Bison      bison         497667.      8.93
##  5 Bovidae Bison      bonasus       500000       9.14
##  6 Bovidae Bos        grunniens     333000       8.88
##  7 Bovidae Bos        frontalis     800000       9.02
##  8 Bovidae Bos        javanicus     666667.      9.83
##  9 Bovidae Boselaphus tragocamelus  169000       8.51
## 10 Bovidae Bubalus    mindorensis   233333.      9.85
## # … with 44 more rows
```

6. From the `mammals` data, build a data frame that compares `mass`, `gestation`, and `newborn` among the primate genera `Lophocebus`, `Erythrocebus`, and `Macaca`. Among these genera, which species has the smallest `newborn` mass?

```r
variable<-select(mammals, mass,gestation,newborn)
```


```r
genera<-filter(mammals,genus=="Lophocebus"|genus=="Erythrocebus"|genus=="Macaca")
```


```r
new_data<-data.frame(genera,variable)
new_data
```

```
##         order          family        genus      species     mass gestation
## 1    Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 2    Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 3    Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 4    Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 5    Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 6    Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 7    Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 8    Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 9    Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 10   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 11   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 12   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 13   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 14   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 15   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 16   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 17   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 18   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 19   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 20   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 21   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 22   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 23   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 24   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 25   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 26   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 27   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 28   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 29   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 30   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 31   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 32   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 33   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 34   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 35   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 36   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 37   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 38   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 39   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 40   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 41   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 42   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 43   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 44   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 45   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 46   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 47   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 48   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 49   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 50   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 51   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 52   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 53   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 54   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 55   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 56   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 57   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 58   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 59   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 60   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 61   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 62   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 63   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 64   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 65   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 66   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 67   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 68   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 69   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 70   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 71   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 72   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 73   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 74   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 75   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 76   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 77   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 78   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 79   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 80   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 81   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 82   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 83   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 84   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 85   Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 86   Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 87   Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 88   Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 89   Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 90   Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 91   Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 92   Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 93   Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 94   Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 95   Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 96   Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 97   Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 98   Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 99   Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 100  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 101  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 102  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 103  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 104  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 105  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 106  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 107  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 108  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 109  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 110  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 111  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 112  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 113  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 114  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 115  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 116  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 117  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 118  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 119  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 120  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 121  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 122  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 123  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 124  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 125  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 126  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 127  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 128  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 129  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 130  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 131  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 132  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 133  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 134  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 135  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 136  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 137  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 138  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 139  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 140  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 141  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 142  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 143  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 144  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 145  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 146  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 147  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 148  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 149  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 150  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 151  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 152  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 153  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 154  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 155  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 156  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 157  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 158  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 159  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 160  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 161  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 162  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 163  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 164  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 165  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 166  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 167  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 168  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 169  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 170  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 171  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 172  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 173  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 174  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 175  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 176  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 177  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 178  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 179  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 180  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 181  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 182  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 183  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 184  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 185  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 186  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 187  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 188  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 189  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 190  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 191  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 192  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 193  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 194  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 195  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 196  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 197  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 198  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 199  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 200  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 201  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 202  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 203  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 204  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 205  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 206  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 207  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 208  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 209  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 210  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 211  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 212  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 213  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 214  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 215  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 216  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 217  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 218  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 219  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 220  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 221  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 222  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 223  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 224  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 225  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 226  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 227  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 228  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 229  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 230  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 231  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 232  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 233  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 234  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 235  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 236  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 237  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 238  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 239  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 240  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 241  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 242  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 243  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 244  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 245  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 246  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 247  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 248  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 249  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 250  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 251  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 252  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 253  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 254  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 255  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 256  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 257  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 258  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 259  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 260  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 261  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 262  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 263  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 264  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 265  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 266  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 267  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 268  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 269  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 270  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 271  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 272  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 273  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 274  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 275  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 276  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 277  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 278  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 279  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 280  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 281  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 282  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 283  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 284  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 285  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 286  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 287  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 288  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 289  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 290  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 291  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 292  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 293  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 294  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 295  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 296  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 297  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 298  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 299  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 300  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 301  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 302  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 303  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 304  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 305  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 306  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 307  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 308  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 309  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 310  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 311  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 312  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 313  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 314  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 315  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 316  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 317  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 318  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 319  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 320  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 321  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 322  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 323  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 324  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 325  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 326  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 327  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 328  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 329  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 330  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 331  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 332  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 333  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 334  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 335  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 336  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 337  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 338  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 339  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 340  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 341  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 342  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 343  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 344  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 345  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 346  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 347  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 348  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 349  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 350  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 351  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 352  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 353  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 354  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 355  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 356  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 357  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 358  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 359  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 360  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 361  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 362  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 363  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 364  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 365  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 366  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 367  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 368  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 369  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 370  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 371  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 372  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 373  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 374  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 375  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 376  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 377  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 378  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 379  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 380  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 381  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 382  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 383  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 384  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 385  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 386  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 387  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 388  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 389  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 390  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 391  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 392  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 393  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 394  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 395  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 396  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 397  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 398  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 399  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 400  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 401  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 402  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 403  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 404  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 405  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 406  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 407  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 408  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 409  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 410  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 411  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 412  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 413  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 414  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 415  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 416  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 417  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 418  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 419  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 420  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 421  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 422  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 423  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 424  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 425  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 426  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 427  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 428  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 429  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 430  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 431  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 432  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 433  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 434  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 435  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 436  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 437  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 438  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 439  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 440  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 441  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 442  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 443  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 444  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 445  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 446  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 447  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 448  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 449  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 450  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 451  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 452  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 453  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 454  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 455  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 456  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 457  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 458  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 459  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 460  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 461  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 462  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 463  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 464  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 465  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 466  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 467  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 468  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 469  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 470  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 471  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 472  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 473  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 474  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 475  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 476  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 477  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 478  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 479  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 480  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 481  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 482  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 483  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 484  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 485  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 486  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 487  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 488  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 489  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 490  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 491  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 492  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 493  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 494  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 495  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 496  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 497  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 498  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 499  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 500  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 501  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 502  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 503  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 504  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 505  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 506  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 507  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 508  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 509  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 510  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 511  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 512  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 513  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 514  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 515  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 516  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 517  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 518  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 519  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 520  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 521  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 522  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 523  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 524  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 525  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 526  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 527  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 528  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 529  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 530  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 531  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 532  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 533  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 534  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 535  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 536  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 537  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 538  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 539  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 540  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 541  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 542  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 543  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 544  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 545  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 546  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 547  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 548  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 549  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 550  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 551  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 552  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 553  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 554  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 555  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 556  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 557  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 558  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 559  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 560  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 561  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 562  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 563  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 564  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 565  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 566  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 567  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 568  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 569  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 570  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 571  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 572  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 573  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 574  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 575  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 576  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 577  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 578  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 579  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 580  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 581  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 582  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 583  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 584  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 585  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 586  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 587  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 588  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 589  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 590  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 591  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 592  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 593  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 594  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 595  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 596  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 597  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 598  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 599  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 600  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 601  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 602  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 603  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 604  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 605  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 606  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 607  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 608  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 609  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 610  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 611  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 612  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 613  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 614  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 615  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 616  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 617  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 618  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 619  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 620  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 621  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 622  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 623  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 624  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 625  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 626  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 627  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 628  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 629  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 630  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 631  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 632  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 633  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 634  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 635  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 636  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 637  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 638  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 639  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 640  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 641  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 642  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 643  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 644  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 645  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 646  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 647  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 648  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 649  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 650  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 651  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 652  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 653  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 654  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 655  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 656  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 657  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 658  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 659  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 660  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 661  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 662  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 663  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 664  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 665  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 666  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 667  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 668  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 669  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 670  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 671  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 672  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 673  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 674  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 675  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 676  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 677  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 678  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 679  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 680  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 681  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 682  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 683  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 684  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 685  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 686  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 687  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 688  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 689  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 690  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 691  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 692  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 693  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 694  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 695  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 696  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 697  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 698  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 699  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 700  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 701  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 702  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 703  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 704  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 705  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 706  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 707  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 708  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 709  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 710  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 711  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 712  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 713  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 714  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 715  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 716  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 717  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 718  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 719  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 720  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 721  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 722  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 723  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 724  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 725  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 726  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 727  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 728  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 729  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 730  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 731  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 732  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 733  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 734  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 735  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 736  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 737  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 738  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 739  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 740  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 741  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 742  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 743  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 744  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 745  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 746  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 747  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 748  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 749  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 750  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 751  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 752  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 753  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 754  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 755  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 756  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 757  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 758  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 759  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 760  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 761  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 762  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 763  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 764  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 765  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 766  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 767  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 768  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 769  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 770  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 771  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 772  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 773  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 774  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 775  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 776  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 777  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 778  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 779  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 780  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 781  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 782  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 783  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 784  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 785  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 786  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 787  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 788  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 789  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 790  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 791  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 792  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 793  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 794  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 795  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 796  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 797  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 798  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 799  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 800  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 801  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 802  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 803  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 804  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 805  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 806  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 807  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 808  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 809  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 810  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 811  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 812  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 813  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 814  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 815  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 816  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 817  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 818  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 819  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 820  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 821  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 822  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 823  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 824  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 825  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 826  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 827  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 828  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 829  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 830  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 831  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 832  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 833  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 834  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 835  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 836  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 837  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 838  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 839  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 840  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 841  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 842  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 843  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 844  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 845  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 846  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 847  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 848  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 849  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 850  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 851  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 852  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 853  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 854  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 855  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 856  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 857  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 858  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 859  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 860  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 861  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 862  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 863  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 864  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 865  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 866  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 867  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 868  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 869  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 870  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 871  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 872  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 873  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 874  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 875  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 876  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 877  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 878  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 879  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 880  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 881  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 882  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 883  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 884  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 885  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 886  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 887  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 888  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 889  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 890  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 891  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 892  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 893  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 894  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 895  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 896  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 897  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 898  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 899  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 900  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 901  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 902  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 903  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 904  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 905  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 906  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 907  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 908  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 909  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 910  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 911  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 912  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 913  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 914  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 915  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 916  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 917  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 918  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 919  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 920  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 921  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 922  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 923  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 924  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 925  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 926  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 927  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 928  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 929  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 930  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 931  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 932  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 933  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 934  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 935  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 936  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 937  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 938  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 939  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 940  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 941  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 942  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 943  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 944  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 945  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 946  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 947  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 948  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 949  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 950  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 951  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 952  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 953  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 954  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 955  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 956  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 957  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 958  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 959  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 960  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 961  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 962  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 963  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 964  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 965  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 966  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 967  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 968  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 969  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 970  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 971  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 972  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 973  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 974  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 975  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 976  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 977  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 978  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 979  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 980  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 981  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 982  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 983  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 984  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 985  Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 986  Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 987  Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 988  Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 989  Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 990  Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 991  Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 992  Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 993  Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 994  Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 995  Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 996  Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 997  Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 998  Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 999  Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1000 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1001 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1002 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1003 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1004 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1005 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1006 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1007 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1008 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1009 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1010 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1011 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1012 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1013 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1014 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1015 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1016 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1017 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1018 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1019 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1020 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1021 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1022 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1023 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1024 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1025 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1026 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1027 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1028 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1029 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1030 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1031 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1032 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1033 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1034 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1035 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1036 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1037 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1038 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1039 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1040 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1041 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1042 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1043 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1044 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1045 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1046 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1047 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1048 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1049 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1050 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1051 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1052 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1053 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1054 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1055 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1056 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1057 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1058 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1059 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1060 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1061 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1062 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1063 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1064 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1065 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1066 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1067 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1068 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1069 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1070 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1071 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1072 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1073 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1074 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1075 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1076 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1077 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1078 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1079 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1080 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1081 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1082 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1083 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1084 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1085 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1086 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1087 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1088 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1089 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1090 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1091 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1092 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1093 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1094 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1095 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1096 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1097 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1098 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1099 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1100 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1101 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1102 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1103 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1104 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1105 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1106 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1107 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1108 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1109 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1110 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1111 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1112 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1113 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1114 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1115 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1116 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1117 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1118 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1119 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1120 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1121 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1122 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1123 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1124 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1125 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1126 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1127 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1128 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1129 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1130 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1131 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1132 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1133 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1134 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1135 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1136 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1137 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1138 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1139 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1140 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1141 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1142 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1143 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1144 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1145 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1146 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1147 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1148 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1149 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1150 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1151 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1152 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1153 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1154 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1155 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1156 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1157 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1158 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1159 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1160 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1161 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1162 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1163 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1164 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1165 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1166 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1167 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1168 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1169 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1170 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1171 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1172 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1173 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1174 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1175 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1176 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1177 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1178 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1179 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1180 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1181 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1182 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1183 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1184 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1185 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1186 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1187 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1188 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1189 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1190 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1191 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1192 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1193 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1194 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1195 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1196 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1197 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1198 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1199 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1200 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1201 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1202 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1203 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1204 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1205 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1206 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1207 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1208 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1209 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1210 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1211 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1212 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1213 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1214 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1215 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1216 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1217 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1218 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1219 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1220 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1221 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1222 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1223 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1224 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1225 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1226 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1227 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1228 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1229 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1230 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1231 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1232 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1233 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1234 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1235 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1236 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1237 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1238 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1239 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1240 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1241 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1242 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1243 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1244 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1245 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1246 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1247 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1248 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1249 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1250 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1251 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1252 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1253 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1254 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1255 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1256 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1257 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1258 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1259 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1260 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1261 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1262 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1263 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1264 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1265 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1266 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1267 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1268 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1269 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1270 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1271 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1272 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1273 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1274 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1275 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1276 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1277 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1278 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1279 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1280 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1281 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1282 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1283 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1284 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1285 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1286 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1287 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1288 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1289 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1290 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1291 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1292 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1293 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1294 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1295 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1296 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1297 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1298 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1299 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1300 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1301 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1302 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1303 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1304 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1305 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1306 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1307 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1308 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1309 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1310 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1311 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1312 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1313 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1314 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1315 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1316 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1317 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1318 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1319 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1320 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1321 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1322 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1323 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1324 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1325 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1326 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1327 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1328 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1329 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1330 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1331 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1332 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1333 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1334 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1335 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1336 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1337 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1338 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1339 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1340 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1341 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1342 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1343 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1344 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1345 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1346 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1347 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1348 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1349 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1350 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1351 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1352 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1353 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1354 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1355 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1356 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1357 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1358 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1359 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1360 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1361 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1362 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1363 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1364 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1365 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1366 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1367 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1368 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1369 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1370 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1371 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1372 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1373 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1374 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1375 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1376 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1377 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1378 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1379 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1380 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1381 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1382 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1383 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1384 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1385 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1386 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1387 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1388 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1389 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1390 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1391 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1392 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1393 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1394 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1395 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1396 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1397 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1398 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1399 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1400 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1401 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1402 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1403 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1404 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1405 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1406 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1407 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1408 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1409 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1410 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1411 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1412 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1413 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1414 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1415 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1416 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1417 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1418 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1419 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1420 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1421 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1422 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1423 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1424 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1425 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
## 1426 Primates Cercopithecidae Erythrocebus        patas  5883.40      5.56
## 1427 Primates Cercopithecidae   Lophocebus     albigena  6725.80      5.97
## 1428 Primates Cercopithecidae       Macaca    thibetana 10036.67      5.67
## 1429 Primates Cercopithecidae       Macaca      fuscata  8857.50      5.72
## 1430 Primates Cercopithecidae       Macaca        maura  5575.00      5.43
## 1431 Primates Cercopithecidae       Macaca     sylvanus  9752.60      5.49
## 1432 Primates Cercopithecidae       Macaca    arctoides  7307.67      6.00
## 1433 Primates Cercopithecidae       Macaca        nigra  6211.67      5.78
## 1434 Primates Cercopithecidae       Macaca       sinica  3495.00   -999.00
## 1435 Primates Cercopithecidae       Macaca      silenus  4875.00      5.94
## 1436 Primates Cercopithecidae       Macaca      mulatta  5413.40      5.47
## 1437 Primates Cercopithecidae       Macaca     cyclopis  6316.67      5.40
## 1438 Primates Cercopithecidae       Macaca   nemestrina  6133.10      5.71
## 1439 Primates Cercopithecidae       Macaca fascicularis  3456.29      5.49
## 1440 Primates Cercopithecidae       Macaca      radiata  3735.00      5.43
##      newborn weaning wean_mass     afr max_life litter_size litters_per_year
## 1     546.50    5.33   1950.00   32.84      287        1.00             0.97
## 2     462.50    7.67   2170.00   57.58      392        1.00             0.36
## 3     533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 4     504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 5     389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 6     450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 7     486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 8     457.67    7.00   -999.00   63.21      216        1.00             0.67
## 9     446.00   13.03   -999.00   54.00      420        1.00             0.69
## 10    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 11    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 12    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 13    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 14    407.82    9.58    990.33   43.56      445        1.00             0.93
## 15    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 16    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 17    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 18    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 19    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 20    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 21    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 22    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 23    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 24    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 25    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 26    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 27    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 28    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 29    407.82    9.58    990.33   43.56      445        1.00             0.93
## 30    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 31    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 32    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 33    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 34    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 35    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 36    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 37    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 38    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 39    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 40    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 41    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 42    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 43    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 44    407.82    9.58    990.33   43.56      445        1.00             0.93
## 45    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 46    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 47    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 48    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 49    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 50    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 51    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 52    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 53    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 54    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 55    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 56    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 57    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 58    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 59    407.82    9.58    990.33   43.56      445        1.00             0.93
## 60    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 61    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 62    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 63    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 64    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 65    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 66    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 67    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 68    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 69    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 70    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 71    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 72    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 73    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 74    407.82    9.58    990.33   43.56      445        1.00             0.93
## 75    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 76    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 77    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 78    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 79    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 80    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 81    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 82    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 83    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 84    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 85    418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 86    476.20    9.47   1454.00   41.08      259        1.00             0.75
## 87    401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 88    476.24   10.66   1416.50   43.64      316        1.00             0.85
## 89    407.82    9.58    990.33   43.56      445        1.00             0.93
## 90    391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 91    546.50    5.33   1950.00   32.84      287        1.00             0.97
## 92    462.50    7.67   2170.00   57.58      392        1.00             0.36
## 93    533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 94    504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 95    389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 96    450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 97    486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 98    457.67    7.00   -999.00   63.21      216        1.00             0.67
## 99    446.00   13.03   -999.00   54.00      420        1.00             0.69
## 100   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 101   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 102   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 103   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 104   407.82    9.58    990.33   43.56      445        1.00             0.93
## 105   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 106   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 107   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 108   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 109   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 110   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 111   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 112   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 113   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 114   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 115   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 116   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 117   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 118   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 119   407.82    9.58    990.33   43.56      445        1.00             0.93
## 120   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 121   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 122   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 123   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 124   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 125   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 126   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 127   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 128   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 129   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 130   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 131   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 132   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 133   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 134   407.82    9.58    990.33   43.56      445        1.00             0.93
## 135   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 136   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 137   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 138   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 139   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 140   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 141   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 142   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 143   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 144   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 145   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 146   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 147   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 148   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 149   407.82    9.58    990.33   43.56      445        1.00             0.93
## 150   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 151   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 152   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 153   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 154   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 155   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 156   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 157   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 158   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 159   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 160   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 161   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 162   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 163   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 164   407.82    9.58    990.33   43.56      445        1.00             0.93
## 165   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 166   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 167   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 168   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 169   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 170   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 171   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 172   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 173   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 174   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 175   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 176   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 177   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 178   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 179   407.82    9.58    990.33   43.56      445        1.00             0.93
## 180   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 181   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 182   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 183   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 184   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 185   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 186   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 187   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 188   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 189   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 190   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 191   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 192   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 193   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 194   407.82    9.58    990.33   43.56      445        1.00             0.93
## 195   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 196   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 197   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 198   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 199   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 200   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 201   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 202   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 203   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 204   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 205   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 206   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 207   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 208   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 209   407.82    9.58    990.33   43.56      445        1.00             0.93
## 210   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 211   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 212   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 213   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 214   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 215   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 216   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 217   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 218   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 219   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 220   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 221   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 222   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 223   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 224   407.82    9.58    990.33   43.56      445        1.00             0.93
## 225   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 226   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 227   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 228   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 229   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 230   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 231   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 232   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 233   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 234   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 235   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 236   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 237   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 238   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 239   407.82    9.58    990.33   43.56      445        1.00             0.93
## 240   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 241   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 242   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 243   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 244   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 245   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 246   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 247   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 248   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 249   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 250   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 251   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 252   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 253   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 254   407.82    9.58    990.33   43.56      445        1.00             0.93
## 255   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 256   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 257   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 258   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 259   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 260   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 261   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 262   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 263   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 264   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 265   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 266   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 267   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 268   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 269   407.82    9.58    990.33   43.56      445        1.00             0.93
## 270   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 271   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 272   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 273   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 274   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 275   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 276   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 277   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 278   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 279   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 280   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 281   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 282   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 283   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 284   407.82    9.58    990.33   43.56      445        1.00             0.93
## 285   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 286   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 287   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 288   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 289   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 290   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 291   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 292   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 293   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 294   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 295   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 296   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 297   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 298   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 299   407.82    9.58    990.33   43.56      445        1.00             0.93
## 300   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 301   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 302   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 303   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 304   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 305   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 306   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 307   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 308   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 309   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 310   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 311   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 312   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 313   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 314   407.82    9.58    990.33   43.56      445        1.00             0.93
## 315   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 316   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 317   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 318   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 319   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 320   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 321   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 322   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 323   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 324   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 325   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 326   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 327   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 328   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 329   407.82    9.58    990.33   43.56      445        1.00             0.93
## 330   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 331   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 332   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 333   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 334   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 335   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 336   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 337   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 338   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 339   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 340   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 341   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 342   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 343   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 344   407.82    9.58    990.33   43.56      445        1.00             0.93
## 345   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 346   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 347   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 348   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 349   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 350   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 351   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 352   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 353   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 354   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 355   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 356   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 357   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 358   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 359   407.82    9.58    990.33   43.56      445        1.00             0.93
## 360   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 361   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 362   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 363   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 364   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 365   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 366   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 367   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 368   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 369   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 370   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 371   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 372   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 373   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 374   407.82    9.58    990.33   43.56      445        1.00             0.93
## 375   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 376   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 377   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 378   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 379   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 380   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 381   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 382   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 383   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 384   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 385   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 386   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 387   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 388   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 389   407.82    9.58    990.33   43.56      445        1.00             0.93
## 390   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 391   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 392   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 393   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 394   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 395   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 396   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 397   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 398   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 399   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 400   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 401   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 402   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 403   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 404   407.82    9.58    990.33   43.56      445        1.00             0.93
## 405   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 406   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 407   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 408   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 409   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 410   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 411   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 412   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 413   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 414   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 415   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 416   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 417   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 418   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 419   407.82    9.58    990.33   43.56      445        1.00             0.93
## 420   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 421   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 422   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 423   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 424   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 425   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 426   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 427   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 428   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 429   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 430   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 431   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 432   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 433   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 434   407.82    9.58    990.33   43.56      445        1.00             0.93
## 435   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 436   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 437   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 438   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 439   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 440   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 441   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 442   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 443   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 444   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 445   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 446   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 447   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 448   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 449   407.82    9.58    990.33   43.56      445        1.00             0.93
## 450   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 451   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 452   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 453   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 454   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 455   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 456   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 457   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 458   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 459   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 460   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 461   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 462   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 463   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 464   407.82    9.58    990.33   43.56      445        1.00             0.93
## 465   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 466   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 467   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 468   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 469   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 470   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 471   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 472   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 473   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 474   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 475   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 476   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 477   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 478   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 479   407.82    9.58    990.33   43.56      445        1.00             0.93
## 480   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 481   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 482   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 483   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 484   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 485   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 486   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 487   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 488   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 489   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 490   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 491   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 492   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 493   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 494   407.82    9.58    990.33   43.56      445        1.00             0.93
## 495   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 496   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 497   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 498   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 499   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 500   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 501   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 502   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 503   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 504   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 505   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 506   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 507   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 508   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 509   407.82    9.58    990.33   43.56      445        1.00             0.93
## 510   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 511   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 512   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 513   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 514   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 515   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 516   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 517   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 518   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 519   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 520   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 521   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 522   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 523   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 524   407.82    9.58    990.33   43.56      445        1.00             0.93
## 525   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 526   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 527   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 528   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 529   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 530   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 531   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 532   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 533   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 534   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 535   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 536   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 537   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 538   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 539   407.82    9.58    990.33   43.56      445        1.00             0.93
## 540   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 541   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 542   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 543   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 544   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 545   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 546   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 547   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 548   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 549   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 550   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 551   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 552   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 553   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 554   407.82    9.58    990.33   43.56      445        1.00             0.93
## 555   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 556   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 557   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 558   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 559   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 560   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 561   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 562   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 563   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 564   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 565   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 566   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 567   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 568   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 569   407.82    9.58    990.33   43.56      445        1.00             0.93
## 570   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 571   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 572   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 573   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 574   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 575   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 576   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 577   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 578   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 579   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 580   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 581   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 582   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 583   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 584   407.82    9.58    990.33   43.56      445        1.00             0.93
## 585   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 586   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 587   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 588   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 589   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 590   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 591   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 592   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 593   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 594   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 595   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 596   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 597   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 598   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 599   407.82    9.58    990.33   43.56      445        1.00             0.93
## 600   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 601   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 602   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 603   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 604   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 605   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 606   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 607   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 608   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 609   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 610   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 611   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 612   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 613   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 614   407.82    9.58    990.33   43.56      445        1.00             0.93
## 615   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 616   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 617   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 618   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 619   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 620   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 621   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 622   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 623   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 624   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 625   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 626   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 627   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 628   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 629   407.82    9.58    990.33   43.56      445        1.00             0.93
## 630   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 631   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 632   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 633   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 634   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 635   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 636   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 637   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 638   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 639   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 640   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 641   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 642   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 643   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 644   407.82    9.58    990.33   43.56      445        1.00             0.93
## 645   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 646   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 647   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 648   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 649   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 650   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 651   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 652   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 653   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 654   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 655   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 656   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 657   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 658   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 659   407.82    9.58    990.33   43.56      445        1.00             0.93
## 660   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 661   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 662   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 663   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 664   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 665   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 666   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 667   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 668   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 669   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 670   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 671   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 672   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 673   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 674   407.82    9.58    990.33   43.56      445        1.00             0.93
## 675   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 676   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 677   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 678   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 679   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 680   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 681   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 682   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 683   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 684   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 685   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 686   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 687   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 688   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 689   407.82    9.58    990.33   43.56      445        1.00             0.93
## 690   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 691   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 692   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 693   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 694   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 695   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 696   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 697   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 698   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 699   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 700   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 701   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 702   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 703   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 704   407.82    9.58    990.33   43.56      445        1.00             0.93
## 705   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 706   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 707   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 708   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 709   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 710   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 711   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 712   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 713   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 714   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 715   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 716   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 717   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 718   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 719   407.82    9.58    990.33   43.56      445        1.00             0.93
## 720   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 721   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 722   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 723   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 724   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 725   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 726   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 727   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 728   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 729   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 730   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 731   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 732   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 733   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 734   407.82    9.58    990.33   43.56      445        1.00             0.93
## 735   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 736   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 737   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 738   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 739   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 740   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 741   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 742   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 743   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 744   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 745   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 746   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 747   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 748   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 749   407.82    9.58    990.33   43.56      445        1.00             0.93
## 750   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 751   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 752   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 753   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 754   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 755   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 756   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 757   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 758   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 759   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 760   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 761   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 762   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 763   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 764   407.82    9.58    990.33   43.56      445        1.00             0.93
## 765   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 766   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 767   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 768   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 769   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 770   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 771   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 772   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 773   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 774   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 775   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 776   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 777   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 778   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 779   407.82    9.58    990.33   43.56      445        1.00             0.93
## 780   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 781   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 782   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 783   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 784   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 785   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 786   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 787   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 788   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 789   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 790   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 791   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 792   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 793   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 794   407.82    9.58    990.33   43.56      445        1.00             0.93
## 795   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 796   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 797   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 798   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 799   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 800   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 801   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 802   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 803   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 804   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 805   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 806   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 807   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 808   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 809   407.82    9.58    990.33   43.56      445        1.00             0.93
## 810   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 811   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 812   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 813   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 814   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 815   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 816   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 817   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 818   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 819   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 820   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 821   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 822   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 823   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 824   407.82    9.58    990.33   43.56      445        1.00             0.93
## 825   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 826   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 827   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 828   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 829   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 830   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 831   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 832   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 833   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 834   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 835   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 836   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 837   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 838   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 839   407.82    9.58    990.33   43.56      445        1.00             0.93
## 840   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 841   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 842   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 843   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 844   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 845   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 846   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 847   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 848   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 849   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 850   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 851   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 852   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 853   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 854   407.82    9.58    990.33   43.56      445        1.00             0.93
## 855   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 856   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 857   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 858   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 859   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 860   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 861   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 862   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 863   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 864   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 865   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 866   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 867   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 868   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 869   407.82    9.58    990.33   43.56      445        1.00             0.93
## 870   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 871   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 872   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 873   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 874   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 875   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 876   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 877   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 878   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 879   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 880   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 881   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 882   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 883   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 884   407.82    9.58    990.33   43.56      445        1.00             0.93
## 885   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 886   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 887   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 888   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 889   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 890   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 891   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 892   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 893   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 894   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 895   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 896   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 897   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 898   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 899   407.82    9.58    990.33   43.56      445        1.00             0.93
## 900   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 901   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 902   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 903   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 904   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 905   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 906   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 907   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 908   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 909   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 910   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 911   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 912   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 913   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 914   407.82    9.58    990.33   43.56      445        1.00             0.93
## 915   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 916   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 917   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 918   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 919   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 920   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 921   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 922   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 923   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 924   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 925   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 926   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 927   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 928   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 929   407.82    9.58    990.33   43.56      445        1.00             0.93
## 930   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 931   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 932   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 933   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 934   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 935   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 936   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 937   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 938   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 939   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 940   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 941   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 942   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 943   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 944   407.82    9.58    990.33   43.56      445        1.00             0.93
## 945   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 946   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 947   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 948   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 949   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 950   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 951   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 952   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 953   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 954   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 955   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 956   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 957   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 958   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 959   407.82    9.58    990.33   43.56      445        1.00             0.93
## 960   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 961   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 962   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 963   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 964   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 965   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 966   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 967   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 968   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 969   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 970   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 971   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 972   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 973   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 974   407.82    9.58    990.33   43.56      445        1.00             0.93
## 975   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 976   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 977   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 978   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 979   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 980   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 981   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 982   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 983   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 984   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 985   418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 986   476.20    9.47   1454.00   41.08      259        1.00             0.75
## 987   401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 988   476.24   10.66   1416.50   43.64      316        1.00             0.85
## 989   407.82    9.58    990.33   43.56      445        1.00             0.93
## 990   391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 991   546.50    5.33   1950.00   32.84      287        1.00             0.97
## 992   462.50    7.67   2170.00   57.58      392        1.00             0.36
## 993   533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 994   504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 995   389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 996   450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 997   486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 998   457.67    7.00   -999.00   63.21      216        1.00             0.67
## 999   446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1000  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1001  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1002  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1003  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1004  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1005  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1006  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1007  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1008  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1009  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1010  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1011  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1012  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1013  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1014  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1015  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1016  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1017  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1018  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1019  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1020  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1021  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1022  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1023  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1024  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1025  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1026  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1027  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1028  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1029  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1030  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1031  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1032  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1033  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1034  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1035  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1036  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1037  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1038  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1039  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1040  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1041  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1042  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1043  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1044  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1045  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1046  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1047  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1048  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1049  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1050  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1051  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1052  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1053  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1054  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1055  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1056  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1057  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1058  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1059  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1060  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1061  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1062  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1063  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1064  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1065  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1066  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1067  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1068  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1069  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1070  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1071  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1072  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1073  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1074  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1075  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1076  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1077  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1078  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1079  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1080  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1081  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1082  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1083  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1084  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1085  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1086  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1087  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1088  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1089  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1090  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1091  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1092  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1093  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1094  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1095  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1096  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1097  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1098  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1099  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1100  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1101  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1102  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1103  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1104  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1105  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1106  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1107  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1108  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1109  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1110  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1111  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1112  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1113  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1114  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1115  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1116  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1117  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1118  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1119  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1120  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1121  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1122  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1123  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1124  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1125  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1126  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1127  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1128  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1129  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1130  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1131  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1132  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1133  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1134  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1135  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1136  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1137  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1138  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1139  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1140  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1141  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1142  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1143  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1144  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1145  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1146  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1147  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1148  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1149  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1150  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1151  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1152  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1153  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1154  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1155  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1156  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1157  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1158  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1159  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1160  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1161  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1162  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1163  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1164  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1165  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1166  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1167  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1168  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1169  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1170  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1171  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1172  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1173  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1174  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1175  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1176  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1177  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1178  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1179  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1180  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1181  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1182  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1183  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1184  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1185  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1186  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1187  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1188  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1189  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1190  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1191  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1192  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1193  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1194  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1195  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1196  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1197  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1198  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1199  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1200  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1201  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1202  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1203  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1204  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1205  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1206  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1207  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1208  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1209  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1210  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1211  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1212  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1213  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1214  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1215  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1216  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1217  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1218  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1219  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1220  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1221  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1222  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1223  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1224  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1225  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1226  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1227  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1228  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1229  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1230  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1231  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1232  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1233  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1234  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1235  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1236  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1237  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1238  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1239  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1240  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1241  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1242  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1243  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1244  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1245  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1246  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1247  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1248  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1249  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1250  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1251  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1252  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1253  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1254  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1255  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1256  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1257  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1258  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1259  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1260  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1261  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1262  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1263  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1264  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1265  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1266  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1267  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1268  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1269  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1270  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1271  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1272  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1273  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1274  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1275  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1276  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1277  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1278  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1279  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1280  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1281  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1282  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1283  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1284  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1285  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1286  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1287  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1288  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1289  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1290  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1291  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1292  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1293  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1294  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1295  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1296  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1297  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1298  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1299  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1300  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1301  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1302  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1303  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1304  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1305  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1306  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1307  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1308  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1309  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1310  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1311  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1312  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1313  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1314  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1315  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1316  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1317  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1318  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1319  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1320  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1321  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1322  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1323  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1324  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1325  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1326  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1327  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1328  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1329  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1330  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1331  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1332  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1333  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1334  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1335  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1336  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1337  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1338  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1339  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1340  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1341  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1342  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1343  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1344  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1345  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1346  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1347  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1348  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1349  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1350  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1351  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1352  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1353  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1354  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1355  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1356  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1357  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1358  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1359  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1360  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1361  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1362  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1363  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1364  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1365  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1366  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1367  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1368  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1369  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1370  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1371  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1372  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1373  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1374  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1375  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1376  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1377  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1378  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1379  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1380  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1381  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1382  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1383  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1384  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1385  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1386  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1387  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1388  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1389  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1390  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1391  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1392  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1393  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1394  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1395  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1396  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1397  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1398  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1399  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1400  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1401  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1402  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1403  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1404  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1405  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1406  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1407  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1408  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1409  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1410  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1411  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1412  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1413  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1414  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1415  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1416  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1417  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1418  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1419  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1420  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1421  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1422  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1423  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1424  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1425  391.33   10.72   2000.00   45.35     -999        1.00             1.00
## 1426  546.50    5.33   1950.00   32.84      287        1.00             0.97
## 1427  462.50    7.67   2170.00   57.58      392        1.00             0.36
## 1428  533.33   18.80   2400.00 -999.00     -999        1.00             0.50
## 1429  504.96   12.06   1767.50   55.02     -999        1.33             0.50
## 1430  389.50   16.67   -999.00   60.00     -999        1.00             0.55
## 1431  450.00    7.00   2420.00   49.81     -999        1.50             0.55
## 1432  486.20   11.20   2300.00   47.76     -999        1.00             0.61
## 1433  457.67    7.00   -999.00   63.21      216        1.00             0.67
## 1434  446.00   13.03   -999.00   54.00      420        1.00             0.69
## 1435  418.00   12.00   -999.00   53.16     -999        1.00             0.70
## 1436  476.20    9.47   1454.00   41.08      259        1.00             0.75
## 1437  401.00    6.87   -999.00 -999.00     -999        1.00             0.80
## 1438  476.24   10.66   1416.50   43.64      316        1.00             0.85
## 1439  407.82    9.58    990.33   43.56      445        1.00             0.93
## 1440  391.33   10.72   2000.00   45.35     -999        1.00             1.00
##            mass.1 gestation.1  newborn.1
## 1        45375.00        8.13    3246.36
## 2       182375.00        9.39    5480.00
## 3        41480.00        6.35    5093.00
## 4       150000.00        7.90   10166.67
## 5        28500.00        6.80    -999.00
## 6        55500.00        5.08    3810.00
## 7        30000.00        5.72    3910.00
## 8        37500.00        5.50    3846.00
## 9       497666.67        8.93   20000.00
## 10      500000.00        9.14   23000.08
## 11      333000.00        8.88   18000.00
## 12      800000.00        9.02   23033.33
## 13      666666.67        9.83    -999.00
## 14      169000.00        8.51    5875.00
## 15        -999.00       10.00    -999.00
## 16      233333.33        9.85    -999.00
## 17      950000.00       10.47   37500.00
## 18      302000.00        8.29    6000.00
## 19       55000.00        5.17    3850.00
## 20       41000.00        5.36    -999.00
## 21       71500.00        5.60    2791.43
## 22       50000.00        5.29    3787.50
## 23       60000.00        5.22    2200.00
## 24       18100.00        4.20    -999.00
## 25       13900.00     -999.00    -999.00
## 26       10000.00     -999.00    -999.00
## 27       12700.00     -999.00    -999.00
## 28       20000.00        4.00    -999.00
## 29        -999.00        7.47    1707.50
## 30       12500.00        7.82     965.00
## 31       11600.00        7.75    1610.00
## 32        6250.00        6.43     800.00
## 33       62500.00        5.43    2400.00
## 34        9000.00        4.00     832.00
## 35      132250.00        8.50   11000.00
## 36      164500.00        8.32   17716.67
## 37      159000.00        9.30    8350.00
## 38       84500.00        8.20    6792.00
## 39      128000.00        7.81   11100.00
## 40       40000.00        6.50    -999.00
## 41       27000.00        5.75    -999.00
## 42       73000.00        6.84    -999.00
## 43       23600.00        5.42    4640.00
## 44       47636.36        6.45    5602.50
## 45       20000.00        6.48    1253.33
## 46       17500.00        5.61    -999.00
## 47       16985.00        4.74    1500.63
## 48       25500.00        5.37    2426.67
## 49       16300.00        5.37    2553.75
## 50       20750.00        6.00    -999.00
## 51        -999.00        6.17    -999.00
## 52       35200.00        6.00    2000.00
## 53      242000.00        9.32   15166.67
## 54      200500.00        8.87   15447.14
## 55       17500.00     -999.00    -999.00
## 56       63950.00        8.50    -999.00
## 57       81733.33        7.57    5100.00
## 58      175333.33        8.91    9000.00
## 59       58600.00        8.38    4937.50
## 60       41333.33        6.76    -999.00
## 61        3250.00     -999.00     690.00
## 62        4550.00        5.84     681.67
## 63        4876.67        5.77     654.00
## 64       30000.00        7.15    3510.50
## 65       87500.00        7.50    -999.00
## 66       27666.67        7.69    2000.00
## 67        2500.00        6.00     500.00
## 68        7166.67        6.00    -999.00
## 69       82350.00        5.78    3176.67
## 70       13000.00        6.79    1065.00
## 71      177500.00        8.22   10316.67
## 72      121350.00        8.00    -999.00
## 73      195000.00        9.01   12015.00
## 74       17500.00        6.95    2235.00
## 75      258000.00        8.48   11077.40
## 76       50500.00     -999.00    -999.00
## 77       60000.00        6.00    -999.00
## 78       57666.67        5.62    3500.00
## 79       68166.67        5.99    4266.67
## 80      180000.00        5.61    2375.00
## 81       50000.00        5.02    2277.08
## 82       27500.00        7.00    -999.00
## 83       25000.00        8.70    -999.00
## 84       24000.00        6.43    2900.00
## 85       46666.67        5.16    -999.00
## 86       11333.33        6.53     936.00
## 87       48850.00        7.32    4500.00
## 88       40000.00        7.50    -999.00
## 89       30000.00        7.57    2600.00
## 90       26100.00        5.83    2652.86
## 91       38250.00        4.94    3365.33
## 92      153000.00        7.76   15000.00
## 93       19000.00        5.08    1202.86
## 94      504666.67       11.03   42862.50
## 95      680000.00        8.67    -999.00
## 96      432500.00        8.64   28325.00
## 97       19000.00        7.34    1033.00
## 98      218000.00     -999.00    -999.00
## 99      186250.00        9.57   19240.00
## 100      87500.00        8.13    4000.00
## 101     190000.00        7.41   16150.00
## 102     100666.67        7.37    5232.50
## 103      64500.00        8.01    5760.00
## 104      36250.00        6.17    3800.00
## 105       -999.00       13.18   35000.00
## 106     434000.00       12.64   35808.46
## 107     142500.00       11.01   12000.00
## 108      60000.00       10.79    7584.00
## 109     110000.00       11.25   11666.67
## 110      50000.00       11.55    5841.67
## 111     351000.00        7.95   13018.18
## 112      33500.00        7.45    2365.00
## 113      55000.00        7.72    3378.50
## 114     102500.00        8.89    4200.00
## 115      21666.67        6.54    1214.33
## 116      39450.00        9.67    1750.00
## 117     143000.00        8.21    -999.00
## 118     120333.33        8.03    8814.09
## 119     125000.00        8.33    -999.00
## 120      53000.00        8.49    -999.00
## 121     171000.00        8.20    9890.00
## 122      73000.00        7.37    5008.00
## 123      96500.00        7.59    3734.00
## 124      54500.00        7.75    4511.17
## 125      33500.00        6.50    -999.00
## 126     149000.00        9.41   11412.50
## 127      70000.00        6.50    -999.00
## 128      68600.00        8.00    -999.00
## 129      14000.00        6.25    1028.33
## 130       8200.00        7.25    -999.00
## 131      16650.00        7.42     792.33
## 132      23000.00        7.43     542.50
## 133      14000.00        6.12    1310.80
## 134      12000.00        6.86    1096.67
## 135      55766.67        6.85    2952.67
## 136      59500.00        6.84    3154.67
## 137      35000.00        7.25    2150.00
## 138       9750.00     -999.00     400.00
## 139       8250.00        6.76     695.00
## 140     113200.00        7.24    5773.67
## 141     800000.00       14.89   59770.59
## 142     287500.00       14.87   17375.00
## 143     215000.00        6.84    5636.25
## 144    1258333.33        7.75   39746.67
## 145      11000.00     -999.00     800.00
## 146      10900.00     -999.00     524.00
## 147      12500.00        5.33     458.75
## 148     100000.00        5.16     715.00
## 149     202500.00        4.39    1250.00
## 150      71000.00        5.53     672.78
## 151      71000.00        3.78     762.00
## 152       8150.00        3.76     191.50
## 153     102750.00        4.00    -999.00
## 154     100900.00        3.95    1040.31
## 155      35300.00     -999.00     647.00
## 156      19200.00        4.66     657.18
## 157      33750.00        5.23    1225.00
## 158      12250.00        5.86    -999.00
## 159       2450.00        4.94     319.00
## 160       3850.00        4.61     370.00
## 161       5900.00        5.20     373.67
## 162       4500.00        1.75      71.04
## 163       9500.00     -999.00    -999.00
## 164      12675.00        2.04    -999.00
## 165      11000.00        2.05     207.50
## 166      26000.00        2.05    -999.00
## 167      34875.00        2.16     418.60
## 168       9750.00        2.08     159.00
## 169      11800.00        2.05     249.75
## 170       8250.00        2.17    -999.00
## 171       6500.00        1.85     365.00
## 172      23000.00        2.11     400.17
## 173      12760.00        2.07     273.33
## 174      27133.33        2.41     332.50
## 175       4232.00        2.05      87.92
## 176       4150.00        2.26     120.88
## 177       4690.00        1.95    -999.00
## 178       3990.00        1.85    -999.00
## 179      13000.00        1.99    -999.00
## 180       6000.00        2.35     152.43
## 181       4220.00        2.14      95.33
## 182       1890.67        1.70    -999.00
## 183       1000.00        1.84      29.00
## 184       4000.00        1.72    -999.00
## 185       2250.00        1.75    -999.00
## 186       7000.00     -999.00    -999.00
## 187       2550.00     -999.00    -999.00
## 188       1800.00        1.69      58.50
## 189       2700.00        1.77      62.50
## 190       5662.50        1.73     101.25
## 191       1200.00        1.71      26.28
## 192       2766.67        1.71      39.65
## 193      58750.00        3.35     403.96
## 194      14000.00        2.43     165.00
## 195      11500.00        2.67     250.00
## 196      10000.00        2.05     126.62
## 197       2350.00        2.20      55.50
## 198       4150.00        2.15     101.87
## 199       2125.00        2.20      70.87
## 200       6750.00        2.33    -999.00
## 201       3666.67        2.67     118.00
## 202       2250.00        2.51    -999.00
## 203       8800.00        2.64     254.40
## 204      13350.00        2.36     253.20
## 205       9400.00        2.18    -999.00
## 206       8600.00        1.86     301.00
## 207      18026.67        2.33     269.50
## 208       8900.00        2.18     204.00
## 209      19500.00        3.06     215.33
## 210       2950.00     -999.00    -999.00
## 211       4000.00        2.45      86.18
## 212       3500.00        2.37      89.00
## 213     119700.00        3.51    1248.59
## 214      81150.00        3.39     831.89
## 215     139500.00        3.62    1377.45
## 216      42325.00        3.22     363.49
## 217       3500.00     -999.00      85.00
## 218      10850.00        2.29     170.00
## 219       1350.00        2.23    -999.00
## 220       4150.00        2.17      93.86
## 221      10650.00     -999.00     248.33
## 222      48000.00        3.07     388.22
## 223      45625.00        3.28     463.45
## 224       3300.00        2.49     100.23
## 225       1570.00     -999.00    -999.00
## 226        727.00        2.25    -999.00
## 227        598.50        1.84    -999.00
## 228        683.00        2.00    -999.00
## 229        448.00        2.00    -999.00
## 230        800.00        2.61      50.00
## 231       -999.00     -999.00    -999.00
## 232        274.80        1.80    -999.00
## 233        800.00        1.62      25.92
## 234       1008.00        1.98    -999.00
## 235       2920.00        2.39    -999.00
## 236       3150.00     -999.00    -999.00
## 237       1331.50        2.02      22.10
## 238        700.00        3.27      50.00
## 239       1800.00     -999.00    -999.00
## 240        776.00        2.57      31.33
## 241      63000.00        3.45    1353.33
## 242      40000.00        3.01     669.50
## 243      60200.00        3.08     727.28
## 244      10000.00        2.90    -999.00
## 245       3000.00        2.07      57.00
## 246      24000.00     -999.00    -999.00
## 247      11800.00        2.10    1050.00
## 248      10500.00        1.50      58.00
## 249       3500.00     -999.00    -999.00
## 250       1200.00        2.00    -999.00
## 251       1996.67        1.70    -999.00
## 252       4500.00        2.19      82.25
## 253      21800.00        7.10    1909.17
## 254       2350.00        1.30    -999.00
## 255      16333.33        1.69      90.53
## 256        500.00        1.68       5.00
## 257        765.00        1.20      12.50
## 258       7500.00        1.87    -999.00
## 259       -999.00        2.45    -999.00
## 260       6225.00        2.01     141.00
## 261       4000.00        2.00    -999.00
## 262       6750.00        2.20    -999.00
## 263       9000.00        2.07    -999.00
## 264       2500.00     -999.00    -999.00
## 265       1066.67        1.50      31.25
## 266       1700.00        3.19    -999.00
## 267        606.67        0.93      32.67
## 268       2600.00        1.33      34.78
## 269       1300.00        1.73      30.00
## 270      13000.00        1.89      84.25
## 271      10000.00        5.86     210.00
## 272       2000.00     -999.00    -999.00
## 273        965.00        2.00    -999.00
## 274       1821.25        1.63      28.10
## 275        809.00        1.44    -999.00
## 276        440.00        3.32       7.50
## 277        171.00        1.25    -999.00
## 278        405.00        1.06    -999.00
## 279        899.75        1.19       8.64
## 280        150.60        0.82       3.10
## 281        110.33        1.43       2.30
## 282       1350.00        1.20       5.73
## 283        588.67        1.05       9.26
## 284         49.75        1.32       2.61
## 285        257.50        1.05       4.00
## 286      24000.00        2.26     202.83
## 287        260.00        1.57       6.90
## 288        511.50        2.19      13.80
## 289       6050.00        1.83     101.88
## 290        542.50        2.00    -999.00
## 291     650000.00       11.50   51883.33
## 292      27000.00        7.00    3533.33
## 293      50000.00       11.75    4420.00
## 294      55000.00        7.75    3833.33
## 295      40500.00        9.00    5933.33
## 296      77666.67        9.17    5955.56
## 297      45000.00        7.75    4250.00
## 298     288932.50        8.75   19215.00
## 299      79633.33       11.75    7075.00
## 300     140000.00       12.00   12763.33
## 301       -999.00       12.00    7000.00
## 302      84666.67       11.14    6817.14
## 303      49100.00        8.37    5182.73
## 304     212000.00        8.01   15388.89
## 305     286666.67        8.71   36950.00
## 306     186000.00        7.87   12820.00
## 307     398666.67        9.50   30875.00
## 308     421666.67        9.60   28394.00
## 309     238333.33        8.50   22333.33
## 310     579400.00        7.63   39918.89
## 311     716666.67        8.45   35250.00
## 312     275000.00       10.00   19600.00
## 313     173000.00       11.00   30675.00
## 314     187666.67        8.13   20266.67
## 315      80000.00       10.50    7100.00
## 316      86000.00       11.00    5000.00
## 317      86140.00        8.20    5909.09
## 318     128786.67        7.63    8476.92
## 319      82500.00        9.00   10250.00
## 320     101250.00        8.35   11083.64
## 321      81666.67        9.00    3000.00
## 322       1242.50        2.45      51.00
## 323        900.00        2.15    -999.00
## 324        975.50        1.81      28.58
## 325       4750.00        2.51     153.33
## 326       3750.00        2.56     140.00
## 327       3000.00        3.84     165.66
## 328       6270.00     -999.00    -999.00
## 329       4400.00        2.13      76.14
## 330     111600.00        4.31     109.29
## 331       4325.00        4.30     120.17
## 332      46000.00        3.68     275.00
## 333     100000.00        6.42    -999.00
## 334      61000.00        7.33     320.00
## 335      76666.67        7.00     351.67
## 336     286366.67        8.11     634.25
## 337     203500.00        6.93     494.82
## 338     110560.00        6.75     294.47
## 339      12250.00        2.74     316.38
## 340       2250.00        1.50    -999.00
## 341       3250.00        2.00      81.50
## 342      13666.67        2.31     417.00
## 343       9500.00        3.00     100.00
## 344       4000.00     -999.00    -999.00
## 345       3000.00     -999.00     150.00
## 346       1540.00        2.90      67.50
## 347       2225.00     -999.00    -999.00
## 348       1866.67        2.50      74.20
## 349       1820.00        2.32      71.00
## 350       2375.00     -999.00     125.00
## 351       1900.00        2.13    -999.00
## 352       4300.00     -999.00    -999.00
## 353       2380.00     -999.00    -999.00
## 354       3100.00        1.50      87.08
## 355       4500.00     -999.00    -999.00
## 356        698.00     -999.00      40.00
## 357      10000.00     -999.00    -999.00
## 358       3000.00     -999.00    -999.00
## 359   80000000.00       12.37    -999.00
## 360   23000000.00       12.55    -999.00
## 361   23000000.00       11.50    -999.00
## 362   66800000.00       10.93 1850000.00
## 363  149000000.00       10.71 2250000.00
## 364   14766666.67       11.40  650000.00
## 365   20000000.00       12.35    -999.00
## 366   16266666.67       10.15    -999.00
## 367   30000000.00       11.43 1325000.00
## 368       -999.00     -999.00    9500.00
## 369      72400.00       12.00    5500.00
## 370       -999.00     -999.00    -999.00
## 371      76365.00        9.57    7050.00
## 372     133000.00     -999.00    -999.00
## 373    1060000.00       14.80  109666.67
## 374     726000.00       15.25   60000.00
## 375     425000.00       12.00    -999.00
## 376     164000.00       11.00    -999.00
## 377     180000.00     -999.00    -999.00
## 378     103000.00       10.00    -999.00
## 379     182000.00       10.50   24000.00
## 380     110000.00       11.63    -999.00
## 381     190000.00       14.00   12300.00
## 382    4300000.00       14.89  159333.33
## 383     206000.00       12.00    -999.00
## 384    1360000.00       14.92    -999.00
## 385      46666.67       10.70    -999.00
## 386     122950.00       12.10   11300.00
## 387      70333.33       10.40    -999.00
## 388      68700.00       11.40    -999.00
## 389     122500.00     -999.00    -999.00
## 390     173333.33       12.12   18920.00
## 391   25066666.67       12.36  529666.67
## 392     665000.00       13.44   71400.00
## 393     900000.00       14.83   80000.00
## 394    3200000.00       10.00    -999.00
## 395      32500.00       10.50    7066.67
## 396      45000.00     -999.00    -999.00
## 397      53183.33        9.66    6775.00
## 398     101666.67        9.98    -999.00
## 399     190233.33     -999.00    -999.00
## 400     363000.00       11.00   82000.00
## 401   15400000.00       15.80  942666.67
## 402      96500.00        9.83    6800.00
## 403      83500.00       10.50    -999.00
## 404       -999.00       10.25    7000.00
## 405      21000.00       10.00    -999.00
## 406      40333.33       10.92    7900.00
## 407       -999.00       10.00    -999.00
## 408    8200000.00       14.67    -999.00
## 409    5266666.67       12.00    -999.00
## 410    1500000.00       12.00    -999.00
## 411    1050000.00     -999.00    -999.00
## 412    3400000.00       12.00    -999.00
## 413    2952500.00       12.00    -999.00
## 414       1000.00        2.00    -999.00
## 415       -999.00        3.50      35.90
## 416       2950.00        7.59    -999.00
## 417       3116.67        7.00     236.00
## 418       2456.67        7.57     225.00
## 419       3600.00        7.44     232.18
## 420         64.80     -999.00       4.50
## 421         39.80     -999.00    -999.00
## 422         42.00     -999.00    -999.00
## 423        104.00     -999.00    -999.00
## 424         23.20     -999.00    -999.00
## 425        745.00        1.30    -999.00
## 426        334.00        1.24       7.92
## 427        309.00        1.22      10.49
## 428        956.50        1.25      14.50
## 429        719.00     -999.00      22.00
## 430        771.00        1.20      15.70
## 431        171.00        1.24       8.50
## 432        292.00     -999.00    -999.00
## 433        358.00     -999.00       8.50
## 434        342.00        1.26      10.14
## 435         64.00        1.08    -999.00
## 436       1000.00     -999.00    -999.00
## 437        900.00        2.80      53.75
## 438          9.25     -999.00    -999.00
## 439         14.50        0.75    -999.00
## 440         21.63        0.66       0.97
## 441         12.00     -999.00    -999.00
## 442         15.00     -999.00    -999.00
## 443          7.50        1.00       0.80
## 444          5.00     -999.00       0.82
## 445          2.50     -999.00    -999.00
## 446          7.20     -999.00    -999.00
## 447          9.70     -999.00    -999.00
## 448         17.10     -999.00       1.40
## 449         22.00        0.84       2.26
## 450          9.91        0.99       0.88
## 451         13.67        0.60       1.00
## 452         11.63        0.97       0.88
## 453          7.70        0.93       0.63
## 454          6.20        0.67       0.34
## 455         10.00     -999.00    -999.00
## 456         11.00     -999.00       1.00
## 457         13.00     -999.00    -999.00
## 458       -999.00     -999.00    -999.00
## 459         16.00        0.75       0.58
## 460         14.32        0.73       0.78
## 461          4.15     -999.00       0.41
## 462       -999.00     -999.00    -999.00
## 463          4.90     -999.00    -999.00
## 464          6.71     -999.00    -999.00
## 465          8.34     -999.00    -999.00
## 466         15.88     -999.00    -999.00
## 467          9.60        0.77       0.58
## 468          4.00     -999.00    -999.00
## 469          4.26        0.64       0.28
## 470          8.20     -999.00    -999.00
## 471          5.57        0.70       0.50
## 472          4.37     -999.00    -999.00
## 473          6.00     -999.00    -999.00
## 474          4.44     -999.00    -999.00
## 475          7.25        0.77       0.25
## 476          3.00        0.68    -999.00
## 477          8.98        0.69       0.47
## 478          3.68     -999.00    -999.00
## 479          2.50     -999.00    -999.00
## 480          8.20        0.55    -999.00
## 481          5.58        0.67       0.42
## 482         12.47        0.75    -999.00
## 483         45.87        1.05       2.60
## 484       -999.00     -999.00    -999.00
## 485          2.10        0.93       0.21
## 486       -999.00     -999.00    -999.00
## 487       -999.00     -999.00    -999.00
## 488       -999.00     -999.00    -999.00
## 489         55.33     -999.00    -999.00
## 490        383.00        1.54    -999.00
## 491         61.30        1.00    -999.00
## 492         10.00     -999.00       0.67
## 493         50.18        1.21      10.10
## 494         74.60        1.35       5.36
## 495        118.80        1.17       5.00
## 496         76.90        1.00    -999.00
## 497         52.00     -999.00    -999.00
## 498         85.00     -999.00       3.50
## 499        133.30        1.06       3.38
## 500         19.50     -999.00    -999.00
## 501        180.00        1.90       7.74
## 502          6.70        2.06       0.70
## 503        149.60        1.79       8.18
## 504         79.50     -999.00    -999.00
## 505         37.80        2.06       3.95
## 506         48.10        2.03       3.65
## 507         69.60     -999.00    -999.00
## 508        761.70     -999.00    -999.00
## 509        259.45        1.89      24.85
## 510        884.00        2.01      21.38
## 511        421.33        0.89    -999.00
## 512       1250.00     -999.00      45.00
## 513       2500.00     -999.00    -999.00
## 514       2099.50        1.30    -999.00
## 515       1820.00     -999.00    -999.00
## 516       -999.00        1.40    -999.00
## 517       2110.00        1.53     110.00
## 518       4506.33        1.53     102.50
## 519       3766.00        1.72     105.00
## 520       3030.43        1.65     107.93
## 521       1489.25        1.22      61.03
## 522       3035.50        1.29      94.32
## 523       2358.00        1.42     118.40
## 524       3759.67        1.50     118.10
## 525       2317.00        1.43      84.34
## 526       3673.33        1.42     119.67
## 527       2686.00        1.38      98.00
## 528       1558.25        1.02      39.61
## 529       2500.00        1.25    -999.00
## 530       2470.00     -999.00    -999.00
## 531       1945.00     -999.00    -999.00
## 532       1700.00     -999.00    -999.00
## 533        494.50        1.27      30.62
## 534        950.00        1.19    -999.00
## 535       1233.00        1.11    -999.00
## 536        902.60        0.93      30.00
## 537       2120.67        1.26      57.67
## 538        707.67        0.90      28.17
## 539        759.96        0.97    -999.00
## 540       1269.00        0.90      34.33
## 541        909.38        0.94      34.50
## 542        167.00     -999.00    -999.00
## 543       -999.00        0.75      11.20
## 544        129.00        1.00    -999.00
## 545        115.00     -999.00       7.00
## 546        128.00     -999.00    -999.00
## 547       -999.00        1.00       7.87
## 548        140.20        1.00      10.67
## 549       -999.00     -999.00    -999.00
## 550       -999.00        0.83       7.00
## 551       -999.00        0.74       7.00
## 552        250.00        0.86      11.40
## 553         60.00        1.87    -999.00
## 554       -999.00     -999.00    -999.00
## 555         51.95        1.70      10.00
## 556         51.94        1.80       8.10
## 557         48.00        2.50    -999.00
## 558         58.00        1.93      10.73
## 559         44.33     -999.00    -999.00
## 560         40.00        2.14       7.00
## 561        220.00     -999.00      31.00
## 562        540.00        1.40      80.00
## 563     250000.00       11.97   29166.67
## 564     275000.00        9.83    -999.00
## 565     384000.00       13.32   40000.00
## 566     296000.00       12.02   30000.00
## 567     257000.00       12.16   32292.00
## 568     230000.00       11.44    -999.00
## 569    2233333.33       15.87   51166.67
## 570    1266666.67        7.75   23000.00
## 571     927766.67       16.12   34166.67
## 572    1602333.33       16.44   58204.55
## 573    1750000.00       16.50    -999.00
## 574     148950.00       13.09    4270.00
## 575     200000.00       13.18    5417.50
## 576     296250.00       12.76    7100.00
## 577     300000.00       13.17    9400.00
## 578      33000.00     -999.00     500.00
## 579       5150.00     -999.00    -999.00
## 580       2350.00     -999.00      92.50
## 581       1480.00        4.00     120.00
## 582       3900.00        2.25     331.75
## 583       2750.00     -999.00    -999.00
## 584       7230.00        4.63     338.00
## 585        558.33        5.18      49.07
## 586        343.33     -999.00      34.50
## 587        357.25     -999.00    -999.00
## 588        116.83        4.60      16.16
## 589        307.00     -999.00    -999.00
## 590        406.00     -999.00    -999.00
## 591        309.00        4.90      27.12
## 592        558.00        4.35      55.07
## 593        490.00     -999.00      44.00
## 594        445.80     -999.00      35.00
## 595        465.00        5.33    -999.00
## 596        411.00     -999.00      43.70
## 597        526.13        5.00      46.90
## 598        499.33        4.67      46.03
## 599        370.00        4.91      39.60
## 600        401.00        5.84      40.22
## 601        501.33        4.83      42.33
## 602        466.75        4.60      40.00
## 603      11600.00        6.23     480.00
## 604       5555.29        6.37     295.00
## 605       5659.14        6.22     368.75
## 606       5353.00        6.23     187.50
## 607        833.56        4.67      91.18
## 608        874.00        4.43      98.00
## 609       1230.00     -999.00    -999.00
## 610       5400.00        4.63    -999.00
## 611       6265.80        7.39     447.50
## 612       7758.80        7.39     461.67
## 613       7761.80        7.47     235.00
## 614      11142.50        7.76    -999.00
## 615       4092.00        6.00    -999.00
## 616       1050.00     -999.00    -999.00
## 617       1120.00        4.33      74.00
## 618        850.00        5.49      72.20
## 619       2410.00     -999.00    -999.00
## 620       2602.57        5.70     237.25
## 621       2528.50        5.33     225.42
## 622       2539.07        5.17     232.42
## 623       2900.00        5.00    -999.00
## 624       2750.00        5.00    -999.00
## 625       6076.25        8.35     213.96
## 626       1926.67     -999.00     120.67
## 627       1377.20        5.32    -999.00
## 628        580.00     -999.00    -999.00
## 629        607.80        5.71     113.25
## 630       3301.67     -999.00     221.00
## 631       5425.75        5.85    -999.00
## 632       7036.67        5.61    -999.00
## 633       2870.00     -999.00     435.00
## 634       4700.00     -999.00    -999.00
## 635       3833.33     -999.00     283.00
## 636       4225.33        5.67     406.00
## 637       -999.00     -999.00    -999.00
## 638       2866.25        5.67     339.00
## 639       2973.67        5.67     339.00
## 640       3392.60        5.00     371.00
## 641       3150.00        6.00    -999.00
## 642       5685.71        4.50     391.65
## 643       3920.00     -999.00    -999.00
## 644       4670.17        5.75     305.00
## 645       4216.50     -999.00     463.00
## 646       3732.64        5.62     337.79
## 647       9000.00     -999.00    -999.00
## 648       9500.00        6.50    -999.00
## 649       8508.00        6.26     573.40
## 650       9725.17        5.67     497.00
## 651       5883.40        5.56     546.50
## 652       6725.80        5.97     462.50
## 653      10036.67        5.67     533.33
## 654       8857.50        5.72     504.96
## 655       5575.00        5.43     389.50
## 656       9752.60        5.49     450.00
## 657       7307.67        6.00     486.20
## 658       6211.67        5.78     457.67
## 659       3495.00     -999.00     446.00
## 660       4875.00        5.94     418.00
## 661       5413.40        5.47     476.20
## 662       6316.67        5.40     401.00
## 663       6133.10        5.71     476.24
## 664       3456.29        5.49     407.82
## 665       3735.00        5.43     391.33
## 666       9087.50        6.19     772.00
## 667      11916.67        6.02     751.50
## 668       1093.33        5.40     187.50
## 669       9462.60        5.53     452.00
## 670      14028.57        5.94     836.97
## 671       6200.00     -999.00    -999.00
## 672       6300.00     -999.00    -999.00
## 673       6400.00     -999.00    -999.00
## 674       6600.00     -999.00    -999.00
## 675       3600.00     -999.00    -999.00
## 676       6163.50        5.63    -999.00
## 677       9960.00     -999.00     427.00
## 678       8310.00        6.25     463.00
## 679      11253.33        6.30     500.00
## 680      12242.33        5.81     464.50
## 681       7325.00     -999.00     457.00
## 682       8100.00     -999.00    -999.00
## 683      12000.00     -999.00    -999.00
## 684       6572.00     -999.00    -999.00
## 685       7081.75        6.95     432.33
## 686       6426.00        4.92     329.83
## 687       8400.00        5.50    -999.00
## 688        394.20        2.35      18.04
## 689        170.60        2.16      16.33
## 690         69.00     -999.00       6.50
## 691        306.67        2.95      14.50
## 692         71.00        1.84       5.78
## 693        400.00     -999.00    -999.00
## 694       2610.33        5.53     123.00
## 695        280.00        4.50    -999.00
## 696        289.20        4.47      24.00
## 697        180.00        4.10      12.10
## 698        171.38        4.23      14.05
## 699         66.00        3.12      10.58
## 700        144.00        4.10      14.55
## 701       1143.33        4.41      51.21
## 702        731.33        4.40      49.00
## 703     101386.11        8.47    2077.50
## 704      37618.18        7.36    1669.92
## 705      32733.33        7.75    1411.20
## 706      37115.60        8.67    1671.93
## 707       6048.40        7.50    -999.00
## 708       5900.00        7.00    -999.00
## 709       6500.00     -999.00    -999.00
## 710       6389.67        6.84    -999.00
## 711       5666.67     -999.00    -999.00
## 712       9554.67        7.74     527.33
## 713       5050.56        7.08     325.71
## 714       1094.43        4.50    -999.00
## 715       7918.00        4.85     300.00
## 716       3545.00     -999.00      98.00
## 717       6260.00        5.93     135.00
## 718       3657.13        4.70      77.64
## 719       1765.33        4.28      85.50
## 720       2171.83        4.37      74.67
## 721       1666.20        4.29      58.93
## 722       1389.25        4.12      59.00
## 723       2426.29        4.02      78.40
## 724       1390.00     -999.00    -999.00
## 725       1202.71        4.73      44.80
## 726       2466.67        4.43      72.14
## 727       3431.43        3.34      91.99
## 728        314.14        4.46      29.69
## 729        237.00        5.56      12.34
## 730        307.00        6.17      21.50
## 731        966.20        6.34      49.94
## 732       1083.50        6.44      40.51
## 733        700.00     -999.00    -999.00
## 734        779.00     -999.00    -999.00
## 735        713.00        4.38      37.17
## 736       -999.00     -999.00    -999.00
## 737        107.00     -999.00    -999.00
## 738        112.00        5.98      25.62
## 739        101.20        5.93      25.42
## 740        179.60        5.62      25.70
## 741    3178000.00       21.12  100038.90
## 742    3507000.00       21.46   99006.25
## 743        250.00        3.78      12.25
## 744        307.00     -999.00    -999.00
## 745       9000.00        3.77     682.40
## 746        389.00     -999.00    -999.00
## 747        770.00     -999.00    -999.00
## 748       1650.00     -999.00    -999.00
## 749         15.75     -999.00    -999.00
## 750        687.00        0.98      23.58
## 751        635.00        2.26      34.00
## 752        332.00     -999.00      15.40
## 753        144.00        3.05       9.00
## 754        132.50        2.67       8.63
## 755        200.00     -999.00    -999.00
## 756        181.00        1.47       8.40
## 757        160.00        2.90       7.00
## 758         35.00        2.23       1.88
## 759       4683.33        4.25     209.50
## 760        660.00        3.85      78.00
## 761       1500.00        3.23    -999.00
## 762       -999.00        6.63    -999.00
## 763       -999.00     -999.00    -999.00
## 764       1267.00        4.50     105.85
## 765      19000.00        3.51     537.94
## 766      19606.67        3.76     455.43
## 767        637.50        2.11    -999.00
## 768        341.00        2.07      59.66
## 769        728.00        2.24      85.14
## 770       1600.00        2.57     196.00
## 771      12500.00        2.81     561.94
## 772        326.00        1.78    -999.00
## 773        337.85        1.78      37.99
## 774        950.00        2.53      80.33
## 775        350.00        1.80      30.40
## 776        500.00        4.27    -999.00
## 777        642.50        3.70      39.27
## 778        600.00        4.39     260.00
## 779       1270.00        4.04     180.00
## 780       3250.00        5.14     196.00
## 781        174.75        2.00      18.30
## 782        288.80        2.44      29.90
## 783        194.00     -999.00      20.50
## 784        275.00        3.53    -999.00
## 785        164.00     -999.00    -999.00
## 786        490.00        4.00      34.70
## 787        100.00        3.87       8.00
## 788        400.00     -999.00    -999.00
## 789       2675.00        2.80      22.70
## 790       2650.00     -999.00    -999.00
## 791       3265.00        3.47    -999.00
## 792        775.00        3.30      76.80
## 793      12500.00        8.42     730.54
## 794         52.00     -999.00    -999.00
## 795         35.90     -999.00    -999.00
## 796        117.50     -999.00    -999.00
## 797         58.67     -999.00    -999.00
## 798         87.00        0.92    -999.00
## 799         51.00     -999.00    -999.00
## 800        134.00        1.15    -999.00
## 801         55.00        1.28       2.00
## 802       -999.00     -999.00    -999.00
## 803         21.33        0.77       0.96
## 804       -999.00     -999.00    -999.00
## 805         52.33        0.92    -999.00
## 806       -999.00     -999.00    -999.00
## 807       -999.00        0.69    -999.00
## 808          8.00        0.97    -999.00
## 809         55.00     -999.00    -999.00
## 810         28.75        0.60       0.80
## 811         24.00        0.69       0.81
## 812         18.25        0.63       0.82
## 813        640.00     -999.00    -999.00
## 814        504.00     -999.00      24.30
## 815        460.00     -999.00    -999.00
## 816        276.00     -999.00    -999.00
## 817        356.50        2.10      24.70
## 818        500.00        2.01      23.00
## 819        350.00        2.09      21.63
## 820        373.50        3.10      21.10
## 821       3900.00        6.67     407.90
## 822       9000.00        6.78     678.20
## 823       1750.00     -999.00    -999.00
## 824       2000.00     -999.00    -999.00
## 825        176.67        0.88       5.51
## 826        142.50        0.93       5.80
## 827        397.00     -999.00    -999.00
## 828        210.00     -999.00    -999.00
## 829        650.00     -999.00    -999.00
## 830        225.00     -999.00    -999.00
## 831        266.00     -999.00       6.07
## 832       -999.00     -999.00    -999.00
## 833         80.00     -999.00    -999.00
## 834        100.00     -999.00    -999.00
## 835         91.40        0.87       3.12
## 836        359.90     -999.00       6.11
## 837        103.50        0.87       3.30
## 838        233.00     -999.00    -999.00
## 839         14.40        1.00    -999.00
## 840         15.23        0.84    -999.00
## 841         25.50        0.83       1.75
## 842         16.50     -999.00    -999.00
## 843         18.70        0.84    -999.00
## 844         19.45        1.00       1.00
## 845         35.25     -999.00    -999.00
## 846         85.00        1.00    -999.00
## 847         35.50        1.13       3.18
## 848         72.40        0.99       4.50
## 849         55.16        1.04       4.00
## 850         60.57     -999.00    -999.00
## 851         64.50     -999.00       4.40
## 852         82.00     -999.00    -999.00
## 853         40.00        0.91       2.92
## 854        119.60        0.78       7.75
## 855         84.96     -999.00    -999.00
## 856        132.00     -999.00    -999.00
## 857         65.00        1.03       3.91
## 858         54.50        0.99    -999.00
## 859        112.00        1.01       3.04
## 860         70.00     -999.00       3.30
## 861         81.00     -999.00    -999.00
## 862         85.00     -999.00    -999.00
## 863         77.00        0.92       3.00
## 864         50.00        0.83       2.75
## 865         42.50     -999.00    -999.00
## 866         65.00     -999.00    -999.00
## 867         41.00        0.92       1.90
## 868         13.55     -999.00       1.00
## 869         13.45     -999.00    -999.00
## 870         11.55        1.00    -999.00
## 871          9.00        0.77       0.78
## 872          7.83        0.83    -999.00
## 873          9.00        0.85    -999.00
## 874         20.10        0.80       1.50
## 875          8.00     -999.00    -999.00
## 876          8.65     -999.00    -999.00
## 877      55000.00        8.82    1537.50
## 878       2000.00     -999.00    -999.00
## 879       3180.00        3.50     148.13
## 880       2740.00     -999.00    -999.00
## 881       8000.00        4.00     445.00
## 882      14650.00        3.73    -999.00
## 883      18333.33        2.50    1000.00
## 884      15680.00        2.42     331.15
## 885       -999.00        1.27    -999.00
## 886         54.43        1.13       7.00
## 887         20.00        1.27    -999.00
## 888         45.25        1.23       5.77
## 889        107.00        0.82    -999.00
## 890        198.00        0.90       6.10
## 891         78.55        0.83       4.45
## 892         47.56     -999.00       2.50
## 893         37.30     -999.00    -999.00
## 894         39.70     -999.00    -999.00
## 895         25.95     -999.00    -999.00
## 896         33.00        0.77       3.00
## 897         50.00     -999.00       3.00
## 898         27.33        0.79       2.20
## 899         37.55     -999.00       3.30
## 900         28.03     -999.00    -999.00
## 901         50.00     -999.00    -999.00
## 902       -999.00     -999.00    -999.00
## 903         35.00     -999.00    -999.00
## 904         50.00        0.67       3.00
## 905         37.70     -999.00    -999.00
## 906       -999.00     -999.00    -999.00
## 907         32.90     -999.00       2.00
## 908       -999.00     -999.00    -999.00
## 909         45.60        0.77       3.00
## 910         29.35        0.85       2.40
## 911         21.50        0.71       1.90
## 912         23.38        0.77       1.50
## 913         36.00     -999.00    -999.00
## 914         23.00        1.15       2.57
## 915         23.00     -999.00    -999.00
## 916         64.50        0.73       4.15
## 917        187.50        0.73       6.00
## 918        120.00        0.71       5.86
## 919         72.60     -999.00    -999.00
## 920          7.83        0.74       1.16
## 921        545.00        0.69       9.99
## 922        166.67        0.64       4.43
## 923        101.67        0.83       3.20
## 924         39.93        0.74       3.45
## 925         26.60     -999.00       2.05
## 926         34.00        0.83    -999.00
## 927         27.00        0.83    -999.00
## 928         41.00        0.73       2.34
## 929         17.60        0.74    -999.00
## 930         20.40     -999.00    -999.00
## 931         20.40     -999.00    -999.00
## 932        650.00        1.38       7.00
## 933         54.00        0.69       3.70
## 934       -999.00     -999.00    -999.00
## 935         25.50        0.67       2.80
## 936         43.40     -999.00    -999.00
## 937         20.57        0.59       1.61
## 938         29.50     -999.00    -999.00
## 939         20.77        0.69       1.82
## 940         23.60        0.62    -999.00
## 941         25.00        0.77       2.95
## 942         58.50     -999.00    -999.00
## 943        144.00        1.16    -999.00
## 944         14.10     -999.00    -999.00
## 945         59.80     -999.00    -999.00
## 946       1092.60        1.17      23.10
## 947       -999.00     -999.00       2.00
## 948         30.80        0.49    -999.00
## 949        506.67        0.71       5.05
## 950        106.18     -999.00    -999.00
## 951       -999.00     -999.00    -999.00
## 952       -999.00     -999.00    -999.00
## 953          7.20     -999.00    -999.00
## 954         10.60     -999.00    -999.00
## 955          7.36        0.83    -999.00
## 956         45.00     -999.00    -999.00
## 957         10.00        0.96       0.90
## 958         54.50        0.94       3.12
## 959       -999.00        0.70       5.20
## 960         55.00        0.68       4.00
## 961         57.00        0.67    -999.00
## 962         85.00        0.60       2.97
## 963         55.05        0.71       4.35
## 964         56.00        1.00    -999.00
## 965         21.40     -999.00       1.73
## 966         80.00     -999.00    -999.00
## 967         38.00        0.87    -999.00
## 968         26.00     -999.00    -999.00
## 969         38.60        0.70       2.30
## 970         28.50        0.79       2.10
## 971         24.00     -999.00       1.90
## 972         26.10        0.67       1.90
## 973         22.00     -999.00    -999.00
## 974         11.70     -999.00    -999.00
## 975         25.00     -999.00    -999.00
## 976         24.40        0.84    -999.00
## 977       -999.00        0.67       2.24
## 978       -999.00     -999.00    -999.00
## 979         43.35     -999.00    -999.00
## 980         18.50        0.72    -999.00
## 981         37.00        0.95       2.55
## 982         65.00     -999.00    -999.00
## 983         53.00        0.83    -999.00
## 984         43.70        0.80       4.20
## 985       -999.00     -999.00    -999.00
## 986         66.00     -999.00    -999.00
## 987        368.00     -999.00    -999.00
## 988        155.00        0.94       5.00
## 989         51.80        1.00       4.40
## 990        606.00        1.17      24.39
## 991         20.00        0.97       1.50
## 992         16.70        0.97       1.49
## 993        882.00     -999.00    -999.00
## 994       -999.00     -999.00    -999.00
## 995         52.60     -999.00    -999.00
## 996       1250.00        4.00    -999.00
## 997         20.30        0.66       1.35
## 998       -999.00     -999.00       1.90
## 999         17.50        1.05    -999.00
## 1000        20.00     -999.00    -999.00
## 1001        27.17        0.82       1.16
## 1002        51.67        0.68       3.92
## 1003        59.20        0.70       3.78
## 1004        59.00     -999.00    -999.00
## 1005        42.30        0.83       1.70
## 1006       332.50        1.24    -999.00
## 1007       755.00     -999.00    -999.00
## 1008      -999.00        1.07       9.50
## 1009      -999.00     -999.00    -999.00
## 1010        55.00        1.01       6.50
## 1011        44.50        1.00       7.50
## 1012      -999.00     -999.00    -999.00
## 1013        12.33        0.88       1.20
## 1014        37.77        0.70    -999.00
## 1015        44.97        0.77       2.07
## 1016       111.00     -999.00       4.50
## 1017        81.60     -999.00    -999.00
## 1018        45.90     -999.00    -999.00
## 1019        57.40     -999.00    -999.00
## 1020        89.80     -999.00    -999.00
## 1021        96.00     -999.00    -999.00
## 1022        65.00     -999.00       6.50
## 1023        62.00     -999.00    -999.00
## 1024        94.00        1.30    -999.00
## 1025       100.00        0.84       5.00
## 1026       105.00        0.85       3.00
## 1027        77.00        0.84       5.33
## 1028       185.00        0.86       4.46
## 1029       150.00        0.72       3.00
## 1030        48.30        0.82       3.40
## 1031      -999.00     -999.00       3.03
## 1032        53.00        0.77    -999.00
## 1033        70.00        0.97       3.50
## 1034        53.20        0.84       2.90
## 1035       268.50        1.57    -999.00
## 1036       900.00        1.46      34.90
## 1037       197.50        0.50    -999.00
## 1038      -999.00     -999.00    -999.00
## 1039       105.00        0.54       2.31
## 1040         6.00        0.65       0.90
## 1041      -999.00        0.67       1.70
## 1042      -999.00     -999.00       2.80
## 1043      -999.00     -999.00       2.21
## 1044        50.00        0.70       3.45
## 1045        35.00     -999.00    -999.00
## 1046      -999.00     -999.00    -999.00
## 1047        54.00        0.73       3.50
## 1048        39.85        0.97       2.45
## 1049        54.80        0.75    -999.00
## 1050        39.50        0.70       2.60
## 1051        36.70     -999.00    -999.00
## 1052        39.00        0.67    -999.00
## 1053        35.30        0.73       2.43
## 1054       106.20        0.90       5.05
## 1055       141.50     -999.00       3.50
## 1056        43.67        0.70       2.46
## 1057        25.50        0.75       2.32
## 1058        47.50     -999.00    -999.00
## 1059        51.60        0.70       3.00
## 1060        93.33        0.71       2.43
## 1061        46.00        0.68       2.30
## 1062        19.50        0.71       1.60
## 1063        40.00        0.74       3.02
## 1064        20.50        0.78       1.63
## 1065        49.50        0.70       3.05
## 1066        53.50        0.71       2.83
## 1067        48.00        0.65       2.10
## 1068        27.50        0.69       1.85
## 1069        63.00     -999.00    -999.00
## 1070        70.00        0.62    -999.00
## 1071        11.25        0.69       1.20
## 1072        12.80     -999.00    -999.00
## 1073      -999.00     -999.00    -999.00
## 1074        17.70        0.65       1.50
## 1075         6.00     -999.00    -999.00
## 1076        28.20     -999.00    -999.00
## 1077         9.22     -999.00    -999.00
## 1078        12.45        0.67       1.30
## 1079         7.25        0.67       0.97
## 1080        20.50        0.69       1.25
## 1081        30.00     -999.00    -999.00
## 1082        32.00     -999.00    -999.00
## 1083        33.50        0.97       1.50
## 1084        25.00        0.71       3.20
## 1085      -999.00     -999.00    -999.00
## 1086       106.00        1.26       6.25
## 1087       178.00     -999.00       5.00
## 1088        19.00     -999.00    -999.00
## 1089       290.00     -999.00    -999.00
## 1090       257.50     -999.00    -999.00
## 1091       269.00        0.93      11.08
## 1092        96.70        1.20      10.00
## 1093       233.58        1.02      12.10
## 1094       142.00        1.03      10.60
## 1095       335.50        0.98      13.50
## 1096       227.50     -999.00    -999.00
## 1097       203.00        1.09      10.40
## 1098       198.00        1.19      11.35
## 1099       125.33        1.10       8.96
## 1100       236.33        1.14      11.70
## 1101       370.50        1.20      13.28
## 1102        50.00        0.91       3.40
## 1103       143.50        0.57    -999.00
## 1104        66.40     -999.00       3.75
## 1105        35.00        1.40       3.00
## 1106        35.00        1.14    -999.00
## 1107        39.00        1.75    -999.00
## 1108        52.00        1.21    -999.00
## 1109        35.00        1.16       2.83
## 1110        53.33        1.09       5.20
## 1111        22.00        0.95       2.63
## 1112        60.67     -999.00    -999.00
## 1113        85.50     -999.00    -999.00
## 1114        22.65        0.83       3.30
## 1115        21.00     -999.00    -999.00
## 1116        27.75     -999.00    -999.00
## 1117      1135.80        0.91      21.92
## 1118        40.00        1.08       2.65
## 1119        19.00        0.97       2.32
## 1120         7.50     -999.00    -999.00
## 1121        47.67        0.80       3.42
## 1122        63.15        0.88       3.85
## 1123       121.00        1.27      11.40
## 1124      -999.00     -999.00      12.50
## 1125      -999.00     -999.00      20.00
## 1126       150.95     -999.00    -999.00
## 1127       146.85        1.30      14.50
## 1128       101.00        1.81      10.20
## 1129        85.50     -999.00    -999.00
## 1130        32.50        0.71    -999.00
## 1131       120.00     -999.00    -999.00
## 1132        50.00     -999.00    -999.00
## 1133       118.00     -999.00    -999.00
## 1134        36.00        1.12       2.62
## 1135        71.00     -999.00       3.90
## 1136        59.00        1.12       4.50
## 1137        60.50        1.09       4.40
## 1138      -999.00     -999.00       2.74
## 1139        40.00        1.44       3.00
## 1140        40.00        0.82    -999.00
## 1141        31.50        0.77    -999.00
## 1142        26.90        0.87    -999.00
## 1143        28.70        0.82       2.20
## 1144        26.30        1.03       2.50
## 1145        29.00        0.83       2.20
## 1146        28.00     -999.00    -999.00
## 1147        30.00     -999.00    -999.00
## 1148        28.00     -999.00    -999.00
## 1149        28.30     -999.00    -999.00
## 1150        16.33        0.82       2.20
## 1151        14.00        0.79       1.63
## 1152        27.00        0.99       2.32
## 1153        20.50        0.88       1.83
## 1154        25.00        0.85       2.33
## 1155        23.00        0.83       1.89
## 1156        42.00        0.97       4.46
## 1157        39.60        0.84       1.67
## 1158        21.00     -999.00       2.10
## 1159        27.00        0.75       2.40
## 1160        33.00        0.71       2.18
## 1161        23.40     -999.00    -999.00
## 1162        23.40        0.65       1.77
## 1163      -999.00        0.70       1.45
## 1164        50.83        1.12    -999.00
## 1165       104.00     -999.00    -999.00
## 1166        31.25        0.77       2.40
## 1167        60.90     -999.00    -999.00
## 1168        39.10     -999.00    -999.00
## 1169        95.00     -999.00    -999.00
## 1170        45.10     -999.00    -999.00
## 1171        40.00        1.18    -999.00
## 1172        21.00        1.04       2.70
## 1173        36.97        0.80       2.70
## 1174        27.00     -999.00    -999.00
## 1175       177.33        0.88       6.25
## 1176       148.00        1.28       7.25
## 1177        95.00     -999.00    -999.00
## 1178        12.00        1.06    -999.00
## 1179        11.00        0.93    -999.00
## 1180        11.00        0.99       1.00
## 1181        63.00        0.90       4.35
## 1182        25.00        0.98    -999.00
## 1183        34.00        0.80    -999.00
## 1184        65.00        1.02       4.00
## 1185        45.00        0.82    -999.00
## 1186        45.00        1.00    -999.00
## 1187        64.00     -999.00    -999.00
## 1188        26.00        1.27    -999.00
## 1189        60.10        1.07       5.00
## 1190        70.00     -999.00    -999.00
## 1191        20.00        1.48    -999.00
## 1192        18.00        1.06       1.80
## 1193        61.00     -999.00    -999.00
## 1194       200.00     -999.00    -999.00
## 1195       127.50        0.77       4.10
## 1196       124.00        0.75    -999.00
## 1197       155.00     -999.00    -999.00
## 1198       139.35     -999.00    -999.00
## 1199       113.50        0.72    -999.00
## 1200       125.00        0.72       3.00
## 1201       202.00        0.71    -999.00
## 1202       115.00        0.88       4.87
## 1203       133.00        0.86       4.50
## 1204        70.00        0.73       2.62
## 1205       280.00        0.71       5.81
## 1206       246.50        0.74       4.55
## 1207        72.17     -999.00    -999.00
## 1208        10.30        0.75       1.09
## 1209        11.03        0.76       1.33
## 1210         9.00        0.74       1.04
## 1211        11.05     -999.00    -999.00
## 1212        12.50     -999.00       1.08
## 1213        51.00        0.83       2.67
## 1214        57.50     -999.00    -999.00
## 1215        75.00     -999.00    -999.00
## 1216      3000.00     -999.00    -999.00
## 1217      2450.00     -999.00    -999.00
## 1218       143.00        0.92       4.75
## 1219        47.38        0.69       2.60
## 1220        12.00        1.01       1.35
## 1221        15.00        1.09       1.35
## 1222        38.50     -999.00    -999.00
## 1223       135.50        1.17    -999.00
## 1224       113.67        1.15       5.55
## 1225       211.00        1.17    -999.00
## 1226       185.00        0.89       6.69
## 1227        55.70     -999.00    -999.00
## 1228      -999.00     -999.00    -999.00
## 1229        24.00     -999.00    -999.00
## 1230        25.53     -999.00       1.55
## 1231        74.50     -999.00    -999.00
## 1232       334.00     -999.00    -999.00
## 1233        37.05        0.77       3.46
## 1234        21.30     -999.00    -999.00
## 1235      -999.00        1.58      14.00
## 1236       207.50        1.36      20.00
## 1237        84.00     -999.00    -999.00
## 1238       131.00        0.77    -999.00
## 1239        64.86     -999.00       2.80
## 1240        93.00     -999.00    -999.00
## 1241       113.00     -999.00    -999.00
## 1242        75.00        0.75       5.13
## 1243       146.67        0.87       3.00
## 1244       114.00     -999.00    -999.00
## 1245        74.80        0.75       4.50
## 1246      -999.00     -999.00    -999.00
## 1247        48.10        0.88    -999.00
## 1248        51.85        0.87    -999.00
## 1249        77.43     -999.00       2.65
## 1250        65.00        0.80    -999.00
## 1251       280.00        1.32      16.77
## 1252        47.00     -999.00    -999.00
## 1253       625.00        1.29      20.00
## 1254        56.60     -999.00    -999.00
## 1255        47.00     -999.00    -999.00
## 1256        54.50        1.03    -999.00
## 1257        58.00        0.87       3.64
## 1258        94.00     -999.00    -999.00
## 1259        50.00        1.00    -999.00
## 1260       130.00     -999.00    -999.00
## 1261      7150.00        4.43     196.36
## 1262      -999.00     -999.00    -999.00
## 1263        25.00        0.81       1.60
## 1264       115.00        0.74    -999.00
## 1265        27.00        1.00    -999.00
## 1266      -999.00     -999.00    -999.00
## 1267        24.00        0.80       3.50
## 1268        68.80     -999.00    -999.00
## 1269        27.33        0.79       0.80
## 1270       125.00        0.94       1.50
## 1271       235.00        2.96      14.10
## 1272       158.00        3.39      16.67
## 1273        98.05     -999.00    -999.00
## 1274      3500.00        2.53     264.50
## 1275       200.00     -999.00    -999.00
## 1276       126.00        0.97       3.80
## 1277       154.50        0.87       4.88
## 1278       110.20     -999.00    -999.00
## 1279        97.50        1.04       3.36
## 1280       400.00        1.57      16.35
## 1281        30.00     -999.00    -999.00
## 1282       202.00     -999.00    -999.00
## 1283       190.00     -999.00    -999.00
## 1284       863.00        1.11      15.38
## 1285       816.67        1.00    -999.00
## 1286       516.00     -999.00    -999.00
## 1287       873.50        1.00    -999.00
## 1288       828.10     -999.00    -999.00
## 1289       172.50     -999.00    -999.00
## 1290       388.00     -999.00    -999.00
## 1291        14.60     -999.00    -999.00
## 1292      -999.00     -999.00    -999.00
## 1293      -999.00        1.13    -999.00
## 1294       147.65        1.33    -999.00
## 1295       218.00     -999.00    -999.00
## 1296       141.00     -999.00    -999.00
## 1297       271.67     -999.00    -999.00
## 1298       106.00        1.73       9.96
## 1299       132.17        1.32       5.62
## 1300        65.38        1.32       3.49
## 1301       326.50     -999.00    -999.00
## 1302       240.00     -999.00    -999.00
## 1303       510.00     -999.00    -999.00
## 1304       120.00     -999.00    -999.00
## 1305      -999.00     -999.00    -999.00
## 1306      -999.00     -999.00      33.00
## 1307      4750.00        1.00    -999.00
## 1308      6300.00        1.00    -999.00
## 1309      6343.33        0.94    -999.00
## 1310      -999.00        1.35      35.50
## 1311      2930.00        1.00      33.80
## 1312      3180.00     -999.00    -999.00
## 1313      2010.00        1.17      29.67
## 1314      8000.00        1.37    -999.00
## 1315      3413.00        1.09      27.43
## 1316      4100.00        1.00    -999.00
## 1317      -999.00        1.33    -999.00
## 1318        16.50     -999.00    -999.00
## 1319      -999.00     -999.00    -999.00
## 1320       134.00     -999.00       9.91
## 1321      -999.00     -999.00    -999.00
## 1322       295.00        2.05      15.21
## 1323       216.00        1.88      12.88
## 1324      -999.00     -999.00       5.00
## 1325      1273.33     -999.00    -999.00
## 1326      1780.00     -999.00    -999.00
## 1327      -999.00        1.50      56.00
## 1328      1330.00     -999.00    -999.00
## 1329       110.00        1.77    -999.00
## 1330        42.25     -999.00    -999.00
## 1331        37.00     -999.00    -999.00
## 1332       712.00     -999.00    -999.00
## 1333       130.00        1.00    -999.00
## 1334      1060.00        2.75    -999.00
## 1335      1280.00        0.93    -999.00
## 1336      2150.00        1.05      77.00
## 1337       221.00     -999.00    -999.00
## 1338        39.00     -999.00    -999.00
## 1339       595.00     -999.00    -999.00
## 1340       225.00     -999.00    -999.00
## 1341       461.00     -999.00    -999.00
## 1342       760.50     -999.00    -999.00
## 1343       751.67        1.44    -999.00
## 1344       702.50        1.43      12.00
## 1345       803.70        1.49      15.44
## 1346       540.33        1.43      15.15
## 1347       374.00     -999.00       9.50
## 1348       324.75        1.25       9.57
## 1349      -999.00        1.50    -999.00
## 1350       600.00     -999.00    -999.00
## 1351       751.00        0.83    -999.00
## 1352       190.00        0.92       4.50
## 1353       200.00     -999.00    -999.00
## 1354       157.60        1.00       6.26
## 1355       278.50        0.87       6.94
## 1356       308.00        0.79    -999.00
## 1357      -999.00     -999.00    -999.00
## 1358      -999.00     -999.00    -999.00
## 1359       136.00        0.88    -999.00
## 1360      -999.00     -999.00    -999.00
## 1361       165.40        0.78       3.95
## 1362       707.00     -999.00    -999.00
## 1363       466.33        0.84       9.37
## 1364       275.00        0.93       5.97
## 1365       840.00        0.92      11.08
## 1366       130.95        0.97       4.10
## 1367       401.05        0.80       6.02
## 1368       163.33        0.93       3.90
## 1369       205.00     -999.00    -999.00
## 1370       609.33        0.97      10.00
## 1371       596.00        1.00    -999.00
## 1372      -999.00        0.80    -999.00
## 1373       342.50        0.78       6.35
## 1374       459.00        0.92    -999.00
## 1375       155.00        0.80       3.61
## 1376       203.00     -999.00    -999.00
## 1377       172.67        0.92       3.24
## 1378       217.00        0.89    -999.00
## 1379       663.03        1.00       7.80
## 1380       119.50        0.93    -999.00
## 1381        67.00     -999.00    -999.00
## 1382        75.00     -999.00    -999.00
## 1383        94.10     -999.00    -999.00
## 1384        59.70        1.10    -999.00
## 1385        75.00     -999.00    -999.00
## 1386        70.00     -999.00    -999.00
## 1387        75.00     -999.00    -999.00
## 1388        57.29        1.03    -999.00
## 1389        54.15        1.20       4.00
## 1390        60.00     -999.00    -999.00
## 1391        84.00        0.93       3.55
## 1392        94.81        0.93    -999.00
## 1393        44.15        0.97       2.30
## 1394        62.10        1.00    -999.00
## 1395        88.45        1.03    -999.00
## 1396        48.25        0.98       2.62
## 1397        85.00        1.14       4.00
## 1398        58.13        1.05       2.60
## 1399        62.80        0.99    -999.00
## 1400        95.70        1.03       3.50
## 1401       229.80        1.29       5.00
## 1402       194.50        1.22       7.00
## 1403      -999.00        2.71    -999.00
## 1404       502.00     -999.00    -999.00
## 1405       588.00        1.54      20.00
## 1406      1880.00        3.00    -999.00
## 1407      3687.50        3.56     105.00
## 1408       283.00        1.65      11.00
## 1409       700.00     -999.00    -999.00
## 1410       797.00     -999.00    -999.00
## 1411       159.00        1.52      12.94
## 1412      -999.00        1.50      10.00
## 1413       350.00        1.85      19.98
## 1414        42.50     -999.00      10.00
## 1415    479500.00       12.21   27500.00
## 1416   4000000.00     -999.00    -999.00
## 1417    500000.00     -999.00    -999.00
## 1418    387500.00        9.94   28633.33
## 1419    480000.00       10.25   12500.00
## 1420     60000.00        7.08    1734.00
## 1421      3900.00     -999.00    -999.00
## 1422      4860.00        5.37     290.00
## 1423      3770.00        4.63    -999.00
## 1424      2750.00     -999.00    -999.00
## 1425      2150.00     -999.00    -999.00
## 1426      2020.00        2.18     131.40
## 1427     10150.00     -999.00    -999.00
## 1428      1150.00        3.00    -999.00
## 1429      1500.00        4.00    -999.00
## 1430      1475.00        4.34    -999.00
## 1431      4300.00        4.36      66.33
## 1432      4600.00        2.09     105.00
## 1433     50000.00        4.00     113.00
## 1434      1225.00        4.75      99.00
## 1435      1500.00        2.00     105.00
## 1436      4750.00        9.41     387.25
## 1437      6070.00        8.67     354.77
## 1438      5070.00        8.92    -999.00
## 1439     28500.00        6.19    1491.17
## 1440      5030.00        5.22    -999.00
```




```r
new_data[which.min(new_data$newborn), ]
```

```
##      order          family  genus species mass gestation newborn weaning
## 5 Primates Cercopithecidae Macaca   maura 5575      5.43   389.5   16.67
##   wean_mass afr max_life litter_size litters_per_year mass.1 gestation.1
## 5      -999  60     -999           1             0.55  28500         6.8
##   newborn.1
## 5      -999
```

## Wrap-up  

Please review the learning goals and be sure to use the code here as a reference when completing the homework.  
-->[Home](https://jmledford3115.github.io/datascibiol/)
