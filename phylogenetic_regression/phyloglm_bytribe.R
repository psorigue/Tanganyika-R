library("pegas")
library("ape")
library("phylolm")
library("broom")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Expression")

#Read phylogeny
treetan <- read.nexus("../map_traits/tree_tan_ed.trees")

#Read csv expression data
df <- read.csv("cichl_exp_avgbyspp.csv")

#Filter NA in pair_bonding
df_filt <- na.omit(df)
str(df_filt)
#Select columns of interest
#colsub <- colnames(df_nna)#[c(1:104)]
#df_filt <- df_nna[colsub]

#Remove columns only 0
##col0 <- df_filt[,df_filt == 'NA']
##df_ncol <- df_filt[, df_filt[,colSums(df_filt[c(4:32599)]) > 0]]
##colSums(df_filt[c(4:32599)]) == 0
##df_ncol["geneID_100692127"]

#Select only males
#df_male <- df_filt[df_filt["sex"]=="F",]

#Label rows with spp name
#rownames(df_male) <- df_male$spp
rownames(df_filt) <- df_filt$spp

#Select tribe
df_tri <- df_filt[df_filt['Tribe'] == 'Tropheini',]
str(df_tri)

#Start logging in 'summary.txt' file
file.create("summary_phyloglm_tropheini.txt")
sink(file = "summary_phyloglm_tropheini.txt", append = TRUE)

#colns <- "geneID_100693145"
#for (colns in colnames(df_male)[4:32599]) {
for (colns in colnames(df_tri)[4:32599]) {
  
  #Create small dataset with only the gene column
  #df_ind <- df_male[c("spp", "pair_bond", "sex", colns)]
  df_ind <- df_tri[c("spp", "pair_bond", colns)]
  
  #Add 'std_counts' column
  df_ind["std_counts"] <- (df_ind[[colns]] - mean(df_ind[[colns]]))/sd(df_ind[[colns]])
  
  try(
    {
      #Phylogenetic regression function
      fit_model=phyloglm(pair_bond~std_counts, data = df_ind, phy = treetan, method = "logistic_IG10")
    }
    , silent = T
  )
  #Statistics of the model
  print(colns)
  print(summary(fit_model))
  
} 

closeAllConnections()

