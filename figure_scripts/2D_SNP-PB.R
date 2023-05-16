library("ggplot2")
library("dplyr")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Figures/SNPs")

df <- read.csv("TRPM2_14058256_PB_BT.txt", sep = "\t")
df2 <- read.csv("spp-tribe.txt", sep = "\t")

colnames(df) <- c("spp", "PB", "SNP")
colnames(df2)

df_final <- inner_join(df, df2, by="spp")

SNP_vs_PB <- ggplot(df_final, aes(x = PB, y = SNP, color = tribe)) +
  geom_point(position=position_jitter(width=0.2, height = 0.2)) +
  scale_x_continuous(breaks = c(0, 1), limits = c(-0.2, 1.2)) +
  scale_y_continuous(breaks = c(0, 1), limits = c(-0.2, 1.2))

SNP_vs_PB

ggsave("SNP_vs_PB.pdf", plot = SNP_vs_PB, device = "pdf", width = 7, height = 7)
