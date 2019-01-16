# Contingency Plot with line for total sum in ggplo2

tab  <- read.table("PUT YOUR PATH",sep = ";",header = T)

tab1 <- tab %>%
        group_by(Var1,Var2) %>%
        summarize(Freq = sum(Freq)) %>% as.data.frame()

levels(tab1$Var2) <- c("1º", "2º","3º")
