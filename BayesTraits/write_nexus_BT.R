library("ape")
library("TreeTools")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/BayesTraitsV4/trees_to_translate")
list_f <- read.delim(file = "list.txt", sep = " ", header = F)

for (file_t in list_f) {

    tree_file_name = file_t

    tree <- read.nexus(tree_file_name)
    write.nexus(tree, file = paste("../trees_translated/", tree_file_name, sep = ""), translate = T)
    
}
