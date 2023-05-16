install.packages("BSDA")
library("pegas")
library("ape")
library("phylolm")
library("BSDA")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Expression")

#Read phylogeny
treetan <- read.nexus("../map_traits/tree_tan_ed.trees")

#Read csv expression data
df <- read.csv("cichl_exp_avgbyspp.csv")

#Filter NA in pair_bonding
df_filt <- na.omit(df)

#Remove columns with all zeros (?and problematic columns:"geneID_100705412")
col_rm <- names(which(colSums(df_filt[5:length(df_filt)])==0))
col_df_filt <- colnames(df_filt)
newcol <- col_df_filt[! col_df_filt %in% col_rm]
df_sub <- df_filt[newcol]

#Label rows with spp name
rownames(df_filt) <- df_filt$spp

#Start logging in 'summary.txt' file
sink(file = "summary_poiss_byspp.txt", append = TRUE)
#colns <- "geneID_100693145"

for (colns in colnames(df_filt)[5:32599]) {
  colns <- "geneID_100693145"
  df_ind <- df_filt[c("spp", "pair_bond", colns)]
  df_ind[colns] <- round(df_ind[colns], digits = 0)
  
      #Phylogenetic regression function
      df_ind["test"] = df_ind[colns]
      
      #fit_model=
      fit_model = phyloglm(test~pair_bond, data = df_ind, phy = treetan, method = "poisson_GEE")
      
      #Z-test
      sd_colns = fit_model$sd[2]
      coef_colns = fit_model$coefficients[2]
      z.test(x = coef_colns, mu = 0, sigma.x = sd_colns) # Error: not enough observations

} 

closeAllConnections()

