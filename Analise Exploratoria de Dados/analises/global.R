library(tidyverse)
library(dlookr)
library(summarytools)
library(readxl)
library(knitr)
library(stargazer)
library(mice)
library(rmarkdown)
library(tinytex)
library(sandwich)
library(magrittr)
library(data.table)


#Funções de binarizacao de histograma
fd <- function(x) {
  n <-length(x)
  return((2*IQR(x))/n^(1/3))
}


sr <- function(x) {
  n <-length(x)
  return((3.49*sd(x))/n^(1/3))
}


#Importando dados mais explorados na disciplina Análise Exploratórioa de Dados

salarios <- readxl::read_excel("dados_utilizados/dados_bussab_m.xlsx")

crimes <- readr::read_csv2("dados_utilizados/BaseDPEvolucaoMensalCisp.csv")

crimes.aisp <- crimes %>% dplyr::select(CISP, mes, ano,  AISP,  RISP, roubo_transeunte, roubo_celular) %>% dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::group_by(AISP, mes.ano) %>% dplyr::summarise(roubo_transeunte = sum(roubo_transeunte), roubo_celular = sum(roubo_celular))

crimes.aisp <- crimes.aisp %>% dplyr::left_join(crimes %>% dplyr::select(AISP, Regiao, mes, ano) %>% 
                                                  dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y")) %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% dplyr::distinct(AISP, mes.ano, Regiao), by = c("AISP" = "AISP", "mes.ano"="mes.ano"))

crimes <- crimes %>% dplyr::mutate(mes.ano = as.IDate(paste("01", mes, ano, sep = "-"), format = "%d-%m-%Y"))



