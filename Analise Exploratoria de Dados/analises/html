---
title: "Análise de dados criminais"
author: "Otto Tavares"
date: "03 April, 2023"
output: html_document
---




## Introdução


```r
library(tidyverse)
library(dlookr)
library(summarytools)
library(readxl)
library(knitr)
library(data.table)
library(ggpubr)
library(corrplot)
library(stargazer)
```


#```{r importando dados, echo = FALSE}
#crimes <- readr::read_csv2("/Users/ottotavares/Library/Mobile Documents/com~apple~CloudDocs/Documents/infnet/Análise Exploratoria de Dados/dados_utilizados/BaseDPEvolucaoMensalCisp.csv")
#```


#```{r filtrando os dados e descrevendo a base, echo = FALSE}

#crimes.aisp <- crimes %>% dplyr::select(CISP, mes, ano,  AISP,  RISP, roubo_transeunte, roubo_celular) %>% dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::group_by(AISP, mes.ano) %>% dplyr::summarise(roubo_transeunte = sum(roubo_transeunte), roubo_celular = sum(roubo_celular))

#crimes.aisp <- crimes.aisp %>% dplyr::left_join(crimes %>% dplyr::select(AISP, Regiao, mes, ano) %>% 
#dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::distinct(AISP, mes.ano, Regiao), by = c("AISP" = "AISP", "mes.ano"="mes.ano"))

```
## # A tibble: 5 × 6
##   variables        types     missing_count missing_percent unique_count unique_rate
##   <chr>            <chr>             <int>           <dbl>        <int>       <dbl>
## 1 AISP             numeric               0               0           39      0.5   
## 2 mes.ano          IDate                 0               0            2      0.0256
## 3 roubo_transeunte numeric               0               0           63      0.808 
## 4 roubo_celular    numeric               0               0           50      0.641 
## 5 Regiao           character             0               0            4      0.0513
```

# Descrição via boxplot e tabelas de contingência

![plot of chunk descrevendo a base com box plot roubo transeunte](figure/descrevendo a base com box plot roubo transeunte-1.png)

![plot of chunk descrevendo a base com box plot roubo celular](figure/descrevendo a base com box plot roubo celular-1.png)


```
## Cross-Tabulation, Row Proportions  
## mes.ano * Regiao  
## Data Frame: crimes.aisp  
## 
## ------------ -------- -------------------- ------------ ------------------- ------------ -------------
##                Regiao   Baixada Fluminense      Capital   Grande Niter<f3>i     Interior         Total
##      mes.ano                                                                                          
##   2019-12-01                     6 (15.4%)   17 (43.6%)            2 (5.1%)   14 (35.9%)   39 (100.0%)
##   2022-12-01                     6 (15.4%)   17 (43.6%)            2 (5.1%)   14 (35.9%)   39 (100.0%)
##        Total                    12 (15.4%)   34 (43.6%)            4 (5.1%)   28 (35.9%)   78 (100.0%)
## ------------ -------- -------------------- ------------ ------------------- ------------ -------------
```


# Construindo os histogramas da Aula 1

![plot of chunk filtrando os dados e visualizando dists.](figure/filtrando os dados e visualizando dists.-1.png)

# Aplicando estimativa de densidade via kernel, através do kernel de epanechnikov

![plot of chunk filtrando os dados e visualizando dists. com kernel](figure/filtrando os dados e visualizando dists. com kernel-1.png)


# Calculando a distribuição acumulada empírica do fenômeno observado

![plot of chunk filtrando os dados e visualizando dists. acumuladas](figure/filtrando os dados e visualizando dists. acumuladas-1.png)



# Calculando a dispersão e as correlações

![plot of chunk calculando dispersao para as duas datas](figure/calculando dispersao para as duas datas-1.png)


![plot of chunk calculando corrplot pearson](figure/calculando corrplot pearson-1.png)


![plot of chunk calculando corrplot spearman](figure/calculando corrplot spearman-1.png)


# Realizando o teste de Shapiro Wilk nas amostras pré e pós pandemia


## Pré Pandemia

```
## Adding missing grouping variables: `AISP`
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  pre.pandemia$roubo_transeunte
## W = 0.83822, p-value = 5.717e-05
```

## Pós Pandemia

```
## Adding missing grouping variables: `AISP`
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  pos.pandemia$roubo_transeunte
## W = 0.83333, p-value = 4.419e-05
```

## Teste de Wilcoxon para checar o pareamento

Realizado o teste de Wilcoxon para checar o pareamento entre as distribuições de roubo a transeunte do pré e do pós pandemia.


```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  pre.pandemia$roubo_transeunte and pos.pandemia$roubo_transeunte
## V = 669, p-value = 1.726e-06
## alternative hypothesis: true location shift is not equal to 0
```

