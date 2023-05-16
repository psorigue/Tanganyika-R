#install.packages("reshape2")
library("ggplot2")
library("reshape2")
library("dplyr")

#colors_pways <- c("STEP" = "#F8766D", "DOPP" = "#7CAE00", "VT-R" = "#00BFC4", "SERP" "#C77CFF", "OXTP" = "#619CFF")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Figures/overview")

df <- read.csv("dataset_overview_pathways_tr.txt", sep = "\t", row.names = 1)
df$pathway <- rownames(df)

colnames(df)
#Select columns for plot genes (dff_g) and plot sites (dff_s)
dff_g <- select(df, c(pathway, total_genes, total_genes_analyzed, FEL_pos_genes, M7_pos_genes))
dff_s <- select(df, c(pathway, total_sites_FEL, total_sites_FEL.M7, sites_high_evidence..FEL.MEME.M1.M7.))

df_long <- melt(dff_g, id.vars = "pathway")
df_s_long <- melt(dff_s, id.vars = "pathway")
df_long
df_s_long
df_long$pathway <- factor(df_long$pathway, levels = c("OXTP", "DOPP", "SERP", "STEP", "VT-R"))
df_s_long$pathway <- factor(df_s_long$pathway, levels = c("OXTP", "DOPP", "SERP", "STEP", "VT-R"))

colors_pways_g <- c("total_genes" = "#E69F00", "total_genes_analyzed" = "#56B4E9", "FEL_pos_genes" = "#009E73", "M7_pos_genes" = "#F0E442")
colors_pways_s <- c("total_sites_FEL" = "#E69F00", "total_sites_FEL.M7" = "#56B4E9", "sites_high_evidence..FEL.MEME.M1.M7." = "#009E73")

genes_ovw_plot <- ggplot(df_long, aes(x=pathway, y=value, fill=variable))+
  geom_bar(position = "dodge", stat = "identity", width = 0.6) +
  scale_fill_manual(values = colors_pways_g) +
  labs(x = "Pathway", y = "Number of genes", fill = "Category") +
  ggtitle("Genes analyzed")+
  theme_minimal()+
  theme(legend.title = element_text(size = 12),
        legend.key.size = unit(0.5, "cm"),
        axis.text.x = element_text(vjust = 0.5, hjust=1),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18),
        panel.spacing = unit(1.5, "cm"))

sites_ovw_plot <- ggplot(df_s_long, aes(x=pathway, y=value, fill=variable))+
  geom_bar(position = "dodge", stat = "identity", width = 0.6) +
  scale_fill_manual(values = colors_pways_s) +
  labs(x = "Pathway", y = "Number of sites", fill = "Category") +
  ggtitle("Sites analyzed")+
  theme_minimal()+
  theme(legend.title = element_text(size = 12), 
        legend.position = "top",
        legend.key.size = unit(0.5, "cm"),
        axis.text.x = element_text(vjust = 0.5, hjust=1),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18),
        panel.spacing = unit(1.5, "cm"))

genes_ovw_plot
sites_ovw_plot

ggsave("genes_ovw_plot.pdf", plot = genes_ovw_plot, device = "pdf", width = 7, height = 7)
ggsave("sites_ovw_plot.pdf", plot = sites_ovw_plot, device = "pdf", width = 7, height = 7)
