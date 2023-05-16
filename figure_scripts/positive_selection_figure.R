library("ggplot2")
library("dplyr")

pway="oxtp"

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Figures/figure_top10")
df <- read.csv(paste(pway, "_FEL_dNdS.txt", sep = ""), sep = "\t")

#Rename columns and select the ones required
colnames(df) <- c("gene", "w", "3", "4", "5", "6", "site_density")
dfr <-df[1:10,]
dff <- select(dfr, c(gene, w, site_density))
dff$site_density <- round(dff$site_density, round(2))

#Order by w value
df_s <- dff[order(dff$w, decreasing = T), ]
gene_order = c(df_s$gene)

dff$gene <- factor(dff$gene, levels = rev(gene_order))


#Plot
dNdS_top10 <- ggplot(dff, aes(x = gene, y = w)) +
  geom_segment(aes(x = gene, xend = gene, y = 0.2, yend = w), linetype=2, color = "black", linewidth = 0.6) +
  geom_point(aes(size = site_density), fill = "gray", color = "black", shape = 21, alpha = 1, stroke = 1) +
  geom_text(aes(label = paste(site_density, " %", sep = "")), size = 3, color = "black", hjust = -1.5) +
  scale_size(range = c(1, 10)) +
  labs(title = "Top 10 genes dNdS ratio OXT Pathway.",
       x = "Gene",
       y = "dN/dS",
       size = "Positive sites\ndensity\n(% of sites)") +
  ylim(0.2, 0.7) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10)) + 
  coord_flip()

dNdS_top10

ggsave("dNdS_top10.pdf", plot = dNdS_top10, device = "pdf", width = 7, height = 5)
