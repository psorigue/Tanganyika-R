library("stats")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/Expression")

#Read csv expression data
df <- read.csv("outputs/glm_byspp_values.txt", header = F, sep = "\t")

data = df[, 2]
View(data)

out = p.adjust(data, method = "fdr")
out
write.csv(out, "outputs/out_glm_byspp_fdr.csv")
