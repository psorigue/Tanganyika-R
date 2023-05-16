library("data.table")
library("ape")
library("pegas")
library("stringr")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Ant_genes")

list <- read.delim(paste("ant_genes_array.txt", sep = ""), sep = " ", header = F)
list_tr <- transpose(list)
  
  for (gen in list_tr) {
    filen <- paste("bc_ant_genes/alignments/", gen, "/aln_", as.character(gen), "_CDS_p2n_bc.fa", sep = "")
  }
  
  df = data.frame()
  
  for (fn in filen) {
    if (file.size(fn) != 0) {
      dna <- ape::read.dna(fn, format = "fasta")
      nd <- nuc.div(dna, variance = F, pairwise.deletion = T)
      out <- c(fn, nd)
    } else {
      out <- paste(fn, "empty file", sep = "\t")
    }
    df = rbind(df, out)
  }
  
colnames(df) <- c('gene', 'pi')
gencol <- df$gene
gencol_df <- str_split_fixed(gencol, pattern = "/", n = 5)
df$gene <- gencol_df[,4]
  
write.csv(df, file = paste("bc_ant_genes/ant_nucl_div.csv", sep = ""), row.names = F, col.names = T)
