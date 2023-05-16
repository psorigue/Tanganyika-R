if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
library("WGCNA")
library("DESeq2")
library("tidyverse")
#library("CorLevelPlot")
library("gridExtra")
library("dplyr")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Expression/WGCNA")

df_counts <- read.delim("dataset_filt_BR_spp.txt", header = T, sep = "\t")
df_pheno <- read.delim("dataset_phenotype.txt", header = T, row.names = NULL, sep = "\t")

###################################################################################
#Filter dataset CichlidX_Expression_Data.txt
###################################################################################
##Only brains
###brain_cols_ind <- c("1", grep(colnames(df), pattern = "_BR_"))
###brain_cols_ind <- grep(colnames(df), pattern = "_BR_")
###brain_col_names <- colnames(df)[brain_cols_ind]

###df_brain <- select(df, all_of(c("X", brain_col_names)))
###colnames(df_brain)[1] <- "gene_ID"
###colnames(df_brain)

##Only spp for which we have phenotype information
###spp_to_select <- c('gene_ID', 'Altcom', 'Auldew', 'Batfas', 'Benhor', 'Boumic', 'Calmac', 'Calple', 'Chabri', 'Ctehor', 'Cyafur', 'Cphgib', 'Cyplep', 'Cypmic', 'Enamel', 'Erecya', 'Eremar', 'Gnapfe', 'Hapmic', 'Intloo', 'Juldic', 'Julorn', 'Lamkun', 'Lamlem', 'Lamoce', 'Lepatt', 'Lepelo', 'Lchaur', 'Loblab', 'Neobre', 'Neobue', 'Neocau', 'Neocyl', 'Neofas', 'Neofur', 'Neomod', 'Neomul', 'Neopul', 'Neosav', 'Neotet', 'Neotoa', 'Neowal', 'Ophven', 'Pcybrn', 'Pcynig', 'Permic', 'Petfam', 'Petfas', 'Petpol', 'Plepar', 'Plestr', 'Pscbab', 'Simdia', 'Spaery', 'Tanirs', 'Teldhs', 'Teltes', 'Telvit', 'Tromoo', 'Tronig', 'Varmoo', 'Xenbou', 'Xennas', 'Xenspi')
###spp_to_select_c <- paste(spp_to_select, collapse = "|")

###spp_cols <- grep(spp_to_select_c, colnames(df_brain))
###df_brain_filt <- df_brain[spp_cols] 

##Filter out columns with all '0'
###cols <- colnames(df_brain_filt)[! colnames(df_brain_filt) %in% "gene_ID"]
###df_filtered <- df[rowSums(df_brain_filt[cols]) != 0,]

##write.table(df_filtered, "dataset_filt_BR_spp.txt", sep = "\t")
###################################################################################

###################################################################################
#Prepare phenotype column
###################################################################################
#Match phenotype dataset with sample names
##Take columns from the count table
###samples <- colnames(df)[! colnames(df) %in% "gene_ID"]
##Create dataset with columns from count table and create new column for the phenotype
###pheno_df <- data.frame(row.names = samples)
###pheno_df["PB"] <- NA
##Read phenotype file
###Pheno <- read.csv("Phenotype.txt", sep = "\t", header = F)
###rownames(Pheno) <- Pheno$V1
###
##Fill pheno_df with phenotypes
###pat_no <- rownames(Pheno[Pheno$V2 == "no",])
###pat_yes <- rownames(Pheno[Pheno$V2 == "yes",])
###pheno_df[grepl(pattern = paste(pat_no, collapse = "|"), rownames(pheno_df)),] = "no"
###pheno_df[grepl(pattern = paste(pat_yes, collapse = "|"), rownames(pheno_df)),] = "yes"
###write.table(pheno_df, "dataset_phenotype.txt", sep = "\t", row.names = T)
###################################################################################

