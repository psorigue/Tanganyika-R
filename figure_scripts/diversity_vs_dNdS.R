library("ggplot2")
library("dplyr")
library("ggpubr")

colors_pways <- c("STEP" = "#F8766D", "DOPP" = "#7CAE00", "VT-R" = "#00BFC4", "SERP" = "#C77CFF", "OXTP" = "#619CFF")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Figures/overview")

# Read dataset and group pathways
df <- read.csv("dataset_overview_genes.txt", sep = "\t")
df
# Omit genes discarded (NA in "dNdS_FEL")
dff <- df[!(is.na(df$dNdS_FEL)), ] 
dff

dffg <- group_by(dff, pathway)
dffg

# Return column names
colnames(dffg)

dffgf <- select(dffg, c(gene, pathway, nucl_div, dNdS_FEL))

dffgf  

w_vs_pi <- ggplot(dffgf, aes(x = nucl_div, y = dNdS_FEL, color = pathway)) +
  geom_point() +
  scale_color_manual(values = colors_pways, name = "Pathway") +
  geom_smooth(method = "lm", se = FALSE)

w_vs_pi

dffgf_model <- filter(dffgf, pathway != "VT-R")
dffgf_model

#Check slope difference significance
# Fit ANCOVA with interaction
ancova_fit <- lm(dNdS_FEL ~ nucl_div * pathway, data = dffgf_model)
anova(ancova_fit)
summary(ancova_fit)

ggsave("w_vs_pi.pdf", plot = w_vs_pi, device = "pdf", width = 7, height = 7)
