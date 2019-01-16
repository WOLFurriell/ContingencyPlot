# Contingency Plot with line for total sum in ggplo2

To make this plot I use the libraries below

```r
library(ggplot2);library(dplyr);library(reshape);library(grid)
```

First we have to import and agroup the dataset using dplyr, this data have 3 columns 
Var1:The genre of the movie
Var2:The order of genre in IMD
Freq:The frequency of genre

```r
tab  <- read.table("PUT YOUR PATH",sep = ";",header = T)

tab1 <- tab %>%
        group_by(Var1,Var2) %>%
        summarize(Freq = sum(Freq)) %>% as.data.frame()

levels(tab1$Var2) <- c("1º", "2º","3º")
```
In the next dataset we need to summarize the frequency by genre without considering the position see in Var2

```r
tab2 <- tab %>%
  group_by(Var1) %>%
  summarize(Freq = sum(Freq)) %>% as.data.frame()
tab1$soma <- rep(tab2$Freq, each=length(levels(tab1$Var2)))
```
