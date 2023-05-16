library("data.table")
library("ape")
library("pegas")
library("stringr")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol")

pways = c("oxtp", "dopp", "serp", "step")

for (pw in pways) {
    list <- read.delim(paste("dataset-array/genes/", pw, "gen.txt", sep = ""), sep = " ", header = F)
    list_tr <- transpose(list)
    pwuc <- toupper(pw)
    
    for (gen in list_tr) {
      filen <- paste("bc_Pathways/", pwuc, "/alignments/", gen, "/aln_", as.character(gen), "_CDS_p2n_bc.fa", sep = "")
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
    
    write.csv(df, file = paste("bc_Pathways/", pwuc, "/nucl_div_", pwuc, ".csv", sep = ""), row.names = F, col.names = T)
}
