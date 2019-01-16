# Contingency Plot with line for total sum in ggplot2

Do you know how to add a line to represent the sum on top of mutiple bars in ggplot2? 
In this simple tutorial I will show you how to do that.
To make this plot I use the libraries below

```r
library(ggplot2);library(dplyr);
```

First of all we have to import the dataset [plotGG.csv](https://github.com/WOLFurriell/ContingencyPlot/blob/master/plotGG.csv) and agroup by genre using dplyr, this data have 3 columns these are:
Var1 - The genre of the movie
Var2 - The order of genre in IMDb
Freq - The frequency of genre

```r
tab  <- read.table("\\XXX PUT YOUR DIRECTORY XXX\\plotGG.csv",sep = ";",header = T)

tab1 <- tab %>%
        group_by(Var1,Var2) %>%
        summarize(Freq = sum(Freq)) %>% as.data.frame()

levels(tab1$Var2) <- c("1º", "2º","3º")
```
In the next dataset we need to summarize the frequency by genre without considering the order(Var2) and repeat this information to each combination of gender and order, in this case we repeat 3 times. This information will be use to put the sum line.

```r
tab2 <- tab %>%
  group_by(Var1) %>%
  summarize(Freq = sum(Freq)) %>% as.data.frame()
tab1$soma <- rep(tab2$Freq, each=length(levels(tab1$Var2)))
```

I like to use cleaner themes in my graphics, so I create this function, but you can use another one of your preference or use the default

```r
my_theme <- function(){
  theme_light() +
    theme(text = element_text(family = "Open Sans"),  
          panel.grid = element_blank(),
          panel.border = element_blank(),
          axis.ticks = element_blank(),
          axis.text.x = element_text(size = 12, color = "gray10"),
          axis.text.y = element_blank(),
          legend.position="bottom")
}
```
Here is the syntax in ggplot2 to make the plot, beyond the line a put the sum points too. For layers not be grouped in the legend I made some changes in guides.

```r
ggplot(data = tab1, aes(x = reorder(Var1, -Freq), y = Freq, fill = Var2)) +
  geom_bar(stat = "identity", position = "dodge", color = "white")  +
  geom_text(position = position_dodge(width = .9), aes(label = Freq),
            family = "Open Sans", fontface = "bold",
            size = 3, hjust = 0.5, vjust = -0.9, color="black") + 
  geom_point(aes(x = reorder(Var1, -Freq), y = soma,colour=Var2), alpha = 0.4, color = "gray50", size = 1.5) +
  geom_line(aes(x = reorder(Var1, -Freq), y = soma,colour=Var2, group = Var2), alpha = 0.4, color = "gray50", size = 1) +
  scale_fill_manual(values = c("#00b3b3", "#006699", "#003366")) +
  xlab("") + ylab("") + guides(fill = guide_legend(override.aes = list(color = NA), title = "Ordem"), 
                               color = FALSE, 
                               shape = FALSE)  +
  my_theme() -> genreP;genreP
```
After this list of commands finally we can see the plot

<img align="center" width="800" height="400" src="https://github.com/WOLFurriell/ContingencyPlot/blob/master/genre2018.jpeg">
