library("ggplot2")
library("plotly")
setwd("C:/Users/Pol/Desktop/param_distributions")

genes = c("APP", "CACNA1S", "CD38b1", "CLOCK", "CYP19A1A_h1", "DRD3", "RAF1", "MAO", "HSD17B4", "FOXL2_h2")

gen = "EGFR_19"

df = read.csv(paste("dataset_", gen, ".txt", sep=""), sep = "\t")

dfq12 = df[c("Iteration", "q12")]
dfq13 = df[c("Iteration", "q13")]
dfq21 = df[c("Iteration", "q21")]
dfq24 = df[c("Iteration", "q24")]
dfq31 = df[c("Iteration", "q31")]
dfq34 = df[c("Iteration", "q34")]
dfq42 = df[c("Iteration", "q42")]
dfq43 = df[c("Iteration", "q43")]

q12 <- ggplot(dfq12, aes(x = q12)) +
  geom_histogram()
q13 <- ggplot(dfq13, aes(x = q13)) +
  geom_histogram()
q21 <- ggplot(dfq21, aes(x = q21)) +
  geom_histogram()
q24 <- ggplot(dfq24, aes(x = q24)) +
  geom_histogram()
q31 <- ggplot(dfq31, aes(x = q31)) +
  geom_histogram()
q34 <- ggplot(dfq34, aes(x = q34)) +
  geom_histogram()
q42 <- ggplot(dfq42, aes(x = q42)) +
  geom_histogram()
q43 <- ggplot(dfq43, aes(x = q43)) +
  geom_histogram()

annotations = list(
  list(x=0, y=1.05, text="q12", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=1.05, text="q13", showarrow=F, yref='paper', xref= 'paper'),
  list(x=0, y=0.74, text="q21", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=0.74, text="q24", showarrow=F, yref='paper', xref= 'paper'),
  list(x=0, y=0.46, text="q31", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=0.46, text="q34", showarrow=F, yref='paper', xref= 'paper'),
  list(x=0, y=0.19, text="q42", showarrow=F, yref='paper', xref= 'paper'),
  list(x=1, y=0.19, text="q43", showarrow=F, yref='paper', xref= 'paper')
  )

#Title font specification
t1 <- list(
  family = "Arial",
  color = "blue",
  size = 12
)

comb <- subplot(q12, q13, q21, q13, q31, q34, q42, q43, nrows = 4, shareX = T, shareY = T)
comb %>%
  layout(annotations = annotations, title = list(text = "Parameter distribution", font = t1))

