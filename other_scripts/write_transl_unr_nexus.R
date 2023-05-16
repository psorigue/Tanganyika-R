library("TreeTools")
library("data.table")
library("ape")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/bc_Pathways/trees")

#pways = c("oxtp", "dopp", "serp", "step")
pways = c("extra")

for (pw in pways) {
  
  list <- read.delim(file = paste('//files1.igc.gulbenkian.pt/folders/ANB/Pol/dataset-array/genes/', pw, "genR.txt", sep = ""), sep = " ", header = F)

  for (gen in list) {
      
      tree <- read.tree(file = paste(gen, "_gtree.nwk", sep = ""))
      tantree_un <- UnrootTree(tree)
      write.nexus(tantree_un, file = paste(gen, "_gtree_unr.nex", sep = ""), translate = T) # Nexus unrooted
      write.nexus(tree, file = paste(gen, "_gtree.nex", sep = ""), translate = T) # Nexus rooted
      
      if (file.exists(paste(gen, "_phtree.nwk", sep = ""))) {
          tree_ph <- read.tree(file = paste(gen, "_phtree.nwk", sep = ""))
          tree_ph_un <- UnrootTree(tree_ph)
          write.nexus(tree_ph_un, file = paste(gen, "_phtree_unr.nex", sep = ""))
          write.nexus(tree_ph, file = paste(gen, "_phtree.nex", sep = ""))
  
      }    
  }
}


