library(tidyverse)
library(dlookr)
library(summarytools)
library(readxl)
library(knitr)
library(data.table)
library(ggpubr)
library(corrplot)
library(mice)

salarios <- readxl::read_excel("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Estatistica para Ciência de Dados/dados_utilizados/dados_bussab_m.xlsx")


imp <- mice(salarios %>% dplyr::mutate(estado_civil = as.factor(estado_civil), Grau_de_instrucao = as.factor(Grau_de_instrucao), regiao = as.factor(regiao)), print = FALSE, m = 5, max.iter = 5 , seed = 512) 
fit <- with(data = imp, exp = lm(salario ~idade_anos + factor(n_filhos) +factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao))) 
est <- pool(fit)

summary(lm(salario ~ idade_anos, data = salarios, na.action=na.omit))

summary(lm(salario ~ idade_anos + factor(estado_civil), data = salarios, na.action=na.omit))

summary(lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao), data = salarios, na.action=na.omit))

summary(lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao), data = salarios, na.action=na.omit))
res <- lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao), data = salarios, na.action=na.omit)$residuals
res.aux <- lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  , data = salarios, na.action=na.omit)$residuals


a.out <- amelia(salarios, print = FALSE, m = 5 , seed = 512, noms = c("Grau_de_instrucao", "regiao"), idvars = c("estado_civil")) 
a.out$imputations[1:5] <- lapply(a.out$imputations, function(df) df %>% dplyr::mutate(n_filhos = abs(as.integer(df$n_filhos))))

imp.models <- with(
  a.out,
  lm(salario ~ idade_anos + factor(round(n_filhos)) +factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao))
)
out <- mi.combine(imp.models, conf.int = TRUE)
out



