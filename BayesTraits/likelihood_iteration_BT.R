library("ggplot2")

df = read.csv("dataset_uni.txt", sep = "\t")

dflh = df[c("Iteration", "Lh")]

dflh
y = dflh$Lh
x = dflh$Iteration

glm(y ~ x)

ggplot(dflh, aes(x=Iteration, y=Lh))+
  geom_point()
