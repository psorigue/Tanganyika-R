library("ggplot2")
#install.packages("ggrepel")
library(ggrepel)
library("dplyr")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Figures/overview")

# Read dataset and group pathways
df <- read.csv("dataset_overview_genes.txt", sep = "\t")
dfg <- group_by(df, pathway)

# Replace names pathways
dfg$pathway <- gsub("OXTP", "OXT pathway", gsub("SERP", "5HT pathway", gsub("DOPP", "DA pathway", gsub("STEP", "Steroidogenesis", gsub("VT-R", "AVT ligand and receptors", x = dfg$pathway)))))

# Call levels so the plot will produce them in this order
dfg$pathway <- factor(dfg$pathway, levels = c("OXT pathway", "DA pathway", "5HT pathway", "Steroidogenesis", "AVT ligand and receptors"))

# Set colours
colors_pways <- c("Steroidogenesis" = "#F8766D", "DA pathway" = "#7CAE00", "AVT ligand and receptors" = "#00BFC4", "5HT pathway" = "#C77CFF", "OXT pathway" = "#619CFF")

# Return column names
colnames(dfg)

# Omit genes discarded (NA in "dNdS_FEL")
dfgf <- dfg[!(is.na(dfg$dNdS_FEL)), ] 
dfgf

plot_dNdS <- ggplot(dfgf, aes(x=pathway, y=dNdS_FEL, fill=pathway)) +
  geom_point(aes(color=pathway), position=position_jitter(width=0.1), size=0.5, alpha=0.6, stroke = 0.9, color = "black") +
  scale_fill_manual(values = colors_pways, ) +
  scale_color_manual(values = colors_pways) +
  geom_violin(alpha = 0.4, color = "transparent")+
  geom_hline(yintercept = 1, linetype="dashed", color = "red") +
  geom_hline(yintercept = 0.25, color = "gray", alpha = 0.3, linewidth = 15) +
  geom_text_repel(data = subset(dfgf, dNdS_FEL > 0.55), aes(label = gene), vjust = -1, size = 2) +
  #geom_text_repel(data = subset(dfgf, gene == "EGFR"), aes(label = gene), vjust = -1, hjust = -1, size = 2) +
  #geom_text_repel(data = subset(dfgf, gene == "OT"), aes(label = gene), vjust = -1, hjust = -1, size = 2) +
  labs(x="Pathway", y="dNdS ratio")+
  theme_minimal()+
  theme(legend.position = "none", 
        axis.title.x = element_text(vjust = -2),
        plot.title = element_text(hjust = 0.5, vjust = -0.2))+
  ggtitle("dSdN ratio")

plot_site_density <- ggplot(dfgf, aes(x=pathway, y=pos_site_density, fill=pathway)) +
  geom_point(aes(color=pathway), position=position_jitter(width=0.1), size=0.5, alpha=0.6, stroke = 0.9, color = "black") +
  scale_fill_manual(values = colors_pways, ) +
  scale_color_manual(values = colors_pways) +
  geom_violin(alpha = 0.4, color = "transparent")+
  #geom_text(data = subset(dfg, dNdS_FEL > 0.5), aes(label = gene), vjust = -1, size = 2) +
  geom_text_repel(data = subset(dfgf, pos_site_density > 42), aes(label = gene), vjust = -1, size = 2) +
  labs(x="Pathway", y="site density (‰)")+
  theme_minimal()+
  theme(legend.position = "none", 
        axis.title.x = element_text(vjust = -2),
        plot.title = element_text(hjust = 0.5, vjust = -0.2))+
  ggtitle("Site density")

plot_num_sites <- ggplot(dfgf, aes(x=pathway, y=sites_FEL, fill=pathway)) +
  geom_point(aes(color=pathway), position=position_jitter(width=0.1), size=0.5, alpha=0.6, stroke = 0.9, color = "black") +
  scale_fill_manual(values = colors_pways, ) +
  scale_color_manual(values = colors_pways) +
  geom_violin(alpha = 0.4, color = "transparent")+
  #geom_text(data = subset(dfg, dNdS_FEL > 0.5), aes(label = gene), vjust = -1, size = 2) +
  geom_text_repel(data = subset(dfgf, sites_FEL > 15), aes(label = gene), vjust = -1, size = 2) +
  labs(x="Pathway", y="number of sites")+
  theme_minimal()+
  ggtitle("Number of positively selected sites")

plot_pi <- ggplot(dfgf, aes(x=pathway, y=nucl_div, fill=pathway)) +
  geom_point(aes(color=pathway), position=position_jitter(width=0.1), size=0.5, alpha=0.6, stroke = 0.9, color = "black") +
  scale_fill_manual(values = colors_pways, ) +
  scale_color_manual(values = colors_pways) +
  geom_violin(alpha = 0.4, color = "transparent")+
  #geom_text(data = subset(dfg, dNdS_FEL > 0.5), aes(label = gene), vjust = -1, size = 2) +
  geom_text_repel(data = subset(dfgf, nucl_div > 0.018), aes(label = gene), vjust = -1, size = 2) +
  theme_minimal()+
  theme(legend.position = "none", 
        axis.title.x = element_text(vjust = -2),
        plot.title = element_text(hjust = 0.5, vjust = -0.2))+
  labs(x="Pathway", y="index"~pi*"")+
  ggtitle("Nucleotide diversity ("~pi*" )")

plot_dNdS
plot_num_sites
plot_site_density
plot_pi
 
ggsave("plot_dNdS.pdf", plot = plot_dNdS, device = "pdf", width = 9, height = 7)
ggsave("plot_num_sites.pdf", plot = plot_num_sites, device = "pdf", width = 7, height = 7)
ggsave("plot_site_density.pdf", plot = plot_site_density, device = "pdf", width = 9, height = 7)
ggsave("plot_pi.pdf", plot = plot_pi, device = "pdf", width = 9, height = 7)
# Save as image because of symbol pi, that is re-formatted in Inkscape
ggsave("plot_pi.png", plot_pi, width = 9, height = 7, dpi = 300, bg = "white")
