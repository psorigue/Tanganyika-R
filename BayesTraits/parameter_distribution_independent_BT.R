library("ggplot2")
library("plotly")
setwd("C:/Users/Pol/Desktop/param_distributions/independent")

#genes=c( "APP", "CACNA1S", "CD38b1", "CLOCK", "CYP19A1A_h1", "DRD3", "EGFR", "FOXL2_h2", "HSD17B4", "MAO", "RAF1" )

gen="CLOCK"

df = read.csv(paste("dataset_", gen, ".txt", sep=""), sep = "\t")  

dfa1 = df[c("Iteration", "alpha1")]
dfb1 = df[c("Iteration", "beta1")]
dfa2 = df[c("Iteration", "alpha2")]
dfb2 = df[c("Iteration", "beta2")]

qa1 <- ggplot(dfa1, aes(x = alpha1)) +
  geom_histogram()
qb1 <- ggplot(dfb1, aes(x = beta1)) +
  geom_histogram()
qa2 <- ggplot(dfa2, aes(x = alpha2)) +
  geom_histogram()
qb2 <- ggplot(dfb2, aes(x = beta2)) +
  geom_histogram()

annotations = list(
  list(x=0, y=1.05, text="a1", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=1.05, text="b1", showarrow=F, yref='paper', xref= 'paper'),
  list(x=0, y=0.4, text="a2", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=0.4, text="b2", showarrow=F, yref='paper', xref= 'paper')
)


comb <- subplot(qa1, qb1, qa2, qb2, nrows = 2, shareX = F, shareY = F)
comb %>%
  layout(annotations = annotations, title = list(text = "Parameter distribution"))
  
