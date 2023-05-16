library("ggplot2")

setwd("C:/Users/Pol/Desktop/param_distributions/independent")
#genes=c( "APP", "CACNA1S", "CD38b1", "CLOCK", "CYP19A1A_h1", "DRD3", "EGFR", "FOXL2_h2", "HSD17B4", "MAO", "RAF1" )

gen = "EGFR_h2"

df = read.csv(paste("dataset_", gen, ".txt", sep=""), sep = "\t")  

trait1 <- ggplot(df, aes(x=beta1, y=alpha1))+
  geom_point()

trait2 <- ggplot(df, aes(x=beta2, y=alpha2))+
  geom_point()

trait2
