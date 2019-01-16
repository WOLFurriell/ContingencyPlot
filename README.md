# Contingency Plot with line for total sum in ggplot2

To make this plot I use the libraries below

```r
library(ggplot2);library(dplyr);library(reshape);library(grid)
```

First we have to import and agroup the dataset using dplyr, this data have 3 columns 
Var1:The genre of the movie
Var2:The order of genre in IMDb
Freq:The frequency of genre

```r
tab  <- read.table("PUT YOUR PATH",sep = ";",header = T)

tab1 <- tab %>%
        group_by(Var1,Var2) %>%
        summarize(Freq = sum(Freq)) %>% as.data.frame()

levels(tab1$Var2) <- c("1º", "2º","3º")
```
In the next dataset we need to summarize the frequency by genre without considering the order(Var2) and repeat this information to each combination of gender and order, in this case we repeat 3 times.

```r
tab2 <- tab %>%
  group_by(Var1) %>%
  summarize(Freq = sum(Freq)) %>% as.data.frame()
tab1$soma <- rep(tab2$Freq, each=length(levels(tab1$Var2)))
```

I like to use cleaner themes in my graphics, so I create this function, but you can uso another one of your preference

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
Here is the syntax in ggplot2 to make the plot, 

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
And finally the plot

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)
