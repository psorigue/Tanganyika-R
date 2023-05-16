install.packages("ggVennDiagram")
library("ggVennDiagram")

oxtp = unlist(read.delim(paste("dataset-array/genes/oxtpallR.txt", sep = ""), sep = " ", header = F))
serp = unlist(read.delim(paste("dataset-array/genes/serpallR.txt", sep = ""), sep = " ", header = F))
dopp = unlist(read.delim(paste("dataset-array/genes/doppallR.txt", sep = ""), sep = " ", header = F))

x <- list(OXTP=oxtp, SERP=serp, DOPP=dopp)

ggVennDiagram(x, label = "count")+
  ggplot2::scale_fill_gradient(low="blue",high = "yellow")

