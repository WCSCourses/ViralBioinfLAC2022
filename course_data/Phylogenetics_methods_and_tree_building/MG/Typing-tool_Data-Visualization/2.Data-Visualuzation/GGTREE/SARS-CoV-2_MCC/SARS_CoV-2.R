#Installing packages
devtools::install_github("GuangchuangYu/ggtree")

library(ggplot2)
library(cowplot)
library(ggtree)
library(treeio)
library(dplyr)
library(tidytree)


##MCC
MCCtree <- read.beast("MCC_SARS_a2.5.tre")    
location <- read.delim2("metadata.txt")

ggtree(MCCtree) + geom_text2(aes(subset=!isTip, label=node), size=3,hjust=-.3)  #Label nodes

ggtree(MCCtree, mrsd = "2021-03-24")%<+% location +
  theme(legend.position = "left")  + 
  geom_tippoint(aes(color=Country), size= 1.8) +
  geom_hilight(node=230, fill="#1f78b4",alpha=.15, extend=.015) +
  annotate("text", fontface =2,x=2020.785, y=16.5, label="2020-11-29", col='red') +
    annotate("text", fontface =2, x=2020.94, y=18, label="2021-12-21", col='red') +
  theme_tree2() +
  scale_color_manual(values= c("Canada" = "#3E5ACF", "CostaRica" = "#457FCB", "DominicanRepublic" = "#529AB6", "Italy" = "#7BB77A", "Luxembourg" = "#96BD60", "Mexico" = "#B3BD4D", "Panama" = "#CDB642", "Portugal" = "#DFA43B", "UnitedArabEmirates" = "#E68434", "UnitedKingdom" = "#E2582C", "USA" = "#DB2823", "Australia" = "#4433BE"))

