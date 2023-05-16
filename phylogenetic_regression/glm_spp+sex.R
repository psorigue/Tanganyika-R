setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Expression")

df_csv <- read.csv("cichl_exp_pol.csv")

df_filt <- na.omit(df_csv)

#Remove columns with all zeros (?and problematic columns:"geneID_100705412")
col_rm <- names(which(colSums(df_filt[5:32599])==0))
col_df_filt <- colnames(df_filt)
newcol <- col_df_filt[! col_df_filt %in% col_rm]
df_sub <- df_filt[newcol]
#head(df_sub[,c(29924,29925)])

sink(file = "summary_spp+sex.txt", append = TRUE)
colnames(df_sub[2434])
for (colns in colnames(df_sub[2434:32547])) { 
  
  df_ind <- df_sub[c("pair_bond", "sex", colns)]
  df_ind["std_counts"] <- (df_ind[[colns]] - mean(df_ind[[colns]]))/sd(df_ind[[colns]])
  
  print(colns)
  print(summary(glm(pair_bond ~ std_counts + sex, data = df_ind, family = 'binomial')))
  
}

closeAllConnections()
