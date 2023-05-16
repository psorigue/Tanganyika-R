library("ggplot2")
library("plotly")

setwd("//files1.igc.gulbenkian.pt/folders/ANB/Pol/cov_corr/OXTP")
spp_tr = 72
spp_gn = 508
#72 or 508

gen = "CD38a1_tr1"
#Vectors pos_sites
sites=c()

df_gn = read.table(paste(gen,"_overall_cov.txt", sep = ""), sep = "\t", header = T)
df_tr = read.table(paste(gen,"_tr_overall_cov.txt", sep = ""), sep = "\t", header = T)
#View(df_gn)
#View(df_tr)

hline_tr = (10*spp_tr)/100
hline_gn = (10*spp_gn)/100
vline = sites

gn_plot <- ggplot(df_gn, aes(x=as.factor(pos), y=df_gn[,3])) +
  geom_bar(stat="identity") +
  geom_hline(yintercept = hline_gn, linetype="dashed", color = "red") +
  geom_vline(xintercept = vline, linetype="dashed", color = "blue") +
  geom_text(aes(800,hline_gn,label = "10%", vjust = -1, color = "red"), show.legend = F)
gn_plot

tr_plot <- ggplot(df_tr, aes(x=as.factor(pos), y=df_tr[,3])) +
  geom_bar(stat="identity") +
  geom_hline(yintercept = hline_tr, linetype="dashed", color = "red") +
  geom_vline(xintercept = vline, linetype="dashed", color = "blue") +
  geom_text(aes(800,hline_tr,label = "10%", vjust = -1, color = "red"), show.legend = F)
#tr_plot

#comb <- subplot(gn_plot, tr_plot, nrows = 2, shareX = T, shareY = F)
#comb

#Output intervals
#Function extract intervals
covint <- function(bins, threshold) {
  intervals <- list()
  i <- 1
  while (i <= length(bins)) {
    bin_i <- bins[i]
    if (bin_i > threshold) {
      j <- i
      while (j <= length(bins)) {
        bin_j <- bins[j]
        if (bin_j <= threshold) {
          intervals[[length(intervals) + 1]] <- c(i, j - 1)
          i <- j
          break
        }
        j <- j + 1
      }
    }
    i <- i + 1
  }
  return(intervals)
  
}

interv <- covint(df_gn[,2], 10)

#Transform index to intervals
df_out <- data.frame()
for (i in interv) {
  a = df_gn[i[1], 1]
  b = df_gn[i[2], 1]
  c = c(a,b)
  df_out <- rbind(df_out, t(data.frame(c)))
}

write.table(file = paste("./", gen, "/", gen, "_intervals_discarded.txt", sep = ""), x = df_out, col.names = F, row.names = F, sep = "\t")
