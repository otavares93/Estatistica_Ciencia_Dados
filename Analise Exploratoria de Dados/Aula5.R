library(tidyverse)
library(dlookr)
library(summarytools)
library(readxl)
library(knitr)
library(data.table)
library(ggpubr)
library(corrplot)
library(mice)
library(Amelia)

#crimes <- readr::read_csv2("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Estatistica para Ciência de Dados/dados_utilizados/BaseDPEvolucaoMensalCisp.csv")

salarios <- readxl::read_excel("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Estatistica para Ciência de Dados/dados_utilizados/dados_bussab_m.xlsx")

#Rodando a regressao linear sem a variável n_filhos
#Simples, variavel explicativa idade
summary(lm(salario ~ idade_anos, data = salarios))

#Multivariada, com a variável estado civil de controle
summary(lm(salario ~ idade_anos + factor(estado_civil), data = salarios))

#Multivariada, com as variáveis estado civil, grau de instrucao de controle
summary(lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao), data = salarios))

#Multivariada, com as variáveis estado civil, grau de instrucao e regiao de controle
summary(lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao), data = salarios))


#Analise dos Residuos
#Modelo com todas as variáveis com excecao de n_filhos
res <- lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao), data = salarios)$residuals

#Modelo com todas as variáveis com excecao de n_filhos e regiao
res.aux <- lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  , data = salarios)$residuals

modelo.escolhido <- lm(salario ~ idade_anos + factor(estado_civil) + factor(Grau_de_instrucao)  , data = salarios)
plot(predict(modelo.escolhido, salarios), salarios$salario)

#Imputando dados com mice
#Imputando os dados com o pacote mice sem fazer nenhum pós processamento
imp <- mice(salarios %>% dplyr::mutate(estado_civil = as.factor(estado_civil), Grau_de_instrucao = as.factor(Grau_de_instrucao), regiao = as.factor(regiao)), print = FALSE, m = 5, max.iter = 5 , seed = 512) 
fit <- with(data = imp, exp = lm(salario ~idade_anos + factor(n_filhos) +factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao))) 
est <- pool(fit)

#Imputando os dados com o pacote mice com pós processamento
imp <- mice(salarios %>% dplyr::mutate(estado_civil = as.factor(estado_civil), Grau_de_instrucao = as.factor(Grau_de_instrucao), regiao = as.factor(regiao)), print = FALSE, m = 5, max.iter = 5 , seed = 512) 
fit <- with(data = imp, exp = lm(salario ~idade_anos + factor(n_filhos) +factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao))) 
est <- pool(fit)


#Imputando os dados com o pacote amelia com pós processamento
a.out <- amelia(salarios, print = FALSE, m = 5 , seed = 512, noms = c("Grau_de_instrucao", "regiao"), idvars = c("estado_civil")) 
a.out$imputations[1:5] <- lapply(a.out$imputations, function(df) df %>% dplyr::mutate(n_filhos = abs(as.integer(df$n_filhos))))

imp.models <- with(
  a.out,
  lm(salario ~ idade_anos + factor(round(n_filhos)) +factor(estado_civil) + factor(Grau_de_instrucao)  + factor(regiao))
)
summary(imp.models)
#out <- mi.combine(imp.models, conf.int = TRUE)
#out



#Exemplo com dados em painel
income <- readxl::read_excel("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Análise Exploratoria de Dados/dados_utilizados/income_democracy.xlsx")
names(income)[c(1:2, 4:length(names(income)))] <- c("pais", "ano", "Log.pib.real", "Log.populacao", "fracao.pop.0_14", "fracao.pop.15_19", "fracao.pop.30_44", "fracao.pop.45_59","fracao.pop.60_mais", "educ.adultos", "idade.mediana", "pais.idx")
summary(plm(Log.pib.real ~ educ.adultos + idade.mediana + Log.populacao, data=income, index=c("pais", "ano"), model="within", effect = "individual"))


