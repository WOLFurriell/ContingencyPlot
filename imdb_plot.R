
# --------------------------------------------------------------------------------------------------------
# - Gráficos dos filmes mais populares de 2018 segundo a IMDb ---------- ---------------------------------
# --------------------------------------------------------------------------------------------------------

library(ggplot2);library(dplyr);

#---------------------------------------------------------------------------------------------------------

tab  <- read.table("W:\\Projetos R\\Filmes\\Bases\\plotGG.csv",sep = ";",header = T)

tab1 <- tab %>%
  group_by(Var1,Var2) %>%
  summarize(Freq = sum(Freq)) %>% as.data.frame()

levels(tab1$Var2) <- c("1º", "2º","3º")

tab2 <- tab %>%
  group_by(Var1) %>%
  summarize(Freq = sum(Freq)) %>% as.data.frame()
tab1$soma <- rep(tab2$Freq, each=length(levels(tab1$Var2)))

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

#- Plot1 ------------------------------------------------------------------------------------------------

ggplot(data = tab1, aes(x = reorder(Var1, -Freq), y = Freq, fill=Var2)) +
  # annotation_custom(rasterGrob(image, 
  #                               width = unit(1,"npc"), 
  #                               height = unit(1,"npc")), 
  #                    -Inf, Inf, -Inf, Inf) +
  geom_bar(stat = "identity", position = "dodge", color="white")  +
  geom_text(position = position_dodge(width = .9), aes(label = Freq),
            family = "Open Sans", fontface = "bold",
            size = 3, hjust = 0.5, vjust = -0.9, color="black") + 
  geom_point(aes(x = reorder(Var1, -Freq), y = soma,colour=Var2), alpha=0.4, color = "gray50", size = 1.5) +
  geom_line(aes(x = reorder(Var1, -Freq), y = soma,colour=Var2, group=Var2), alpha=0.4, color = "gray50", size = 1) +
  scale_fill_manual(values=c("#00b3b3", "#006699", "#003366")) +
  xlab("") + ylab("") + guides(fill = guide_legend(override.aes = list(color = NA), title = "Ordem"), 
                               color = FALSE, 
                               shape = FALSE)  +
  my_theme() -> genreP; genreP

