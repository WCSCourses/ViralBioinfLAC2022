setwd("/Users/eduan/Downloads/Archivio/")

# load libraries

library(dplyr)
library(data.table)
library(ape)
library(treeio)

# load tree file
tree <- read.tree("525only.nwk")

# create vector list of seqIDs to drop from the tree
drop_tip <- c("hCoV-19/India/TG-CCMB-BJ143/2021|EPI_ISL_1838719|2021-03-08", "hCoV-19/Turkey/HSGM-B4126/2021|EPI_ISL_1760146|2021-03-31", "hCoV-19/Turkey/HSGM-B1702/2021|EPI_ISL_1678513|2021-03-29", "hCoV-19/Turkey/HSGM-8429/2021|EPI_ISL_1403726|2021-03-03", "hCoV-19/Turkey/HSGM-11398/2021|EPI_ISL_2107334|2021-03-12", "hCoV-19/Germany/BY-RKI-I-074298/2021|EPI_ISL_1640628|2021-03-07", "hCoV-19/Germany/BY-RKI-I-101273/2021|EPI_ISL_1846811|2021-03-13", "hCoV-19/USA/IN-CDC-LC0057853/2021|EPI_ISL_2241690|2021-05-04")

# now drop the tips from the tree
new_tree <- drop.tip(tree, drop_tip, trim.internal = TRUE)

# write the tree to file
write.tree(new_tree, file="new_tree.nwk", append = FALSE)
