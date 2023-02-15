Transformando a aula anterior em um código versionado e ‘reprodutível’
================
Otto Tavares
2023-02-13

## Introdução

Na Aula 5 o objetivo é transformar as manipulações de dados realizadas
na Aula 4 em um código R Markdown. Ao fazermos isso, teremos o passo a
passo da análise com todas as decisões tomadas facilmente acessadas e de
forma convidativa ao usuário.

O objetivo principal dessa abordagem é garantir que outro usuário ao se
deparar com esse código, seja capaz de reproduzir cada passo em seu
ambiente de análise.

Para que isso seja possível, os dados devem ser compartilhados, ou a
forma de coleta deve estar bem explícita, bem como o versionamento do
código deve estar registrado por um documento git e salvo em
respositório online através do GitHub.

Relembrando a análise que fizemos na aula passada:

- Importamos dados dos 10 países mais populosos do mundo através do site
  do wikipedia
- Limpamos as colunas de interesse de análise, como o número absoluto da
  população reportada, a Data de coleta da informação e qual a proporção
  da população mundial aquele dado representava.

## Preparando o ambiente de análise

Dessa forma, o primeiro passo de nossa análise será importar as
bilbiotecas que foram necessárias para o desenvolvimento.

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.4.0     ✔ purrr   1.0.1
    ## ✔ tibble  3.1.8     ✔ dplyr   1.1.0
    ## ✔ tidyr   1.3.0     ✔ stringr 1.5.0
    ## ✔ readr   2.1.3     ✔ forcats 1.0.0
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(rvest)
```

    ## 
    ## Attaching package: 'rvest'
    ## 
    ## The following object is masked from 'package:readr':
    ## 
    ##     guess_encoding

``` r
library(data.table)
```

    ## 
    ## Attaching package: 'data.table'
    ## 
    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last
    ## 
    ## The following object is masked from 'package:purrr':
    ## 
    ##     transpose

``` r
library(robotstxt)
library(knitr)
```

Posteriomente, vamos trocar o diretório de referência para o trabalho,
mas não vamos deixas essa informação pública para o usuário.

## Importando os dados

A partir da definição do ambiente partiremos para importação dos dados
web, partindo do link do wikipedia e utilizando a bibliotca rvest, para
ler o arquivo html e processá-lo até chegarmos nas tabelas presentes no
site.

O que nos permite escolher a quarta tabela, sendo essa a do ranking
populacional do nosso interesse.

``` r
populacao.mundial.web <- rvest::read_html("https://en.wikipedia.org/wiki/World_population")
lpop <- populacao.mundial.web %>% rvest::html_nodes("table") %>% rvest::html_table()
pop.mundial <- lpop[[4]]
kable(head(pop.mundial))
```

| Rank | Country / Dependency | Population    | Percentage of the world | Date        | Source (official or from the United Nations) |
|-----:|:---------------------|:--------------|:------------------------|:------------|:---------------------------------------------|
|    1 | China                | 1,412,600,000 | 17.6%                   | 31 Dec 2021 | National annual estimate\[93\]               |
|    2 | India                | 1,373,761,000 | 17.1%                   | 1 Mar 2022  | Annual national estimate\[94\]               |
|    3 | United States        | 333,672,582   | 4.16%                   | 14 Feb 2023 | National population clock\[95\]              |
|    4 | Indonesia            | 275,773,800   | 3.44%                   | 1 Jul 2022  | National annual estimate\[96\]               |
|    5 | Pakistan             | 229,488,994   | 2.86%                   | 1 Jul 2022  | UN projection\[97\]                          |
|    6 | Nigeria              | 216,746,934   | 2.71%                   | 1 Jul 2022  | UN projection\[97\]                          |

## Limpando os dados

Ao termos acesso aos dados, percebemos a necessidade de limpeza dos
mesmos, da seguinte forma:

1.  Criando uma função auxiliar customizada, que nos permita trocar os
    espaços dos nomes pelo sinal de ’\_’
2.  Selecionando apenas as variáveis de interesse para análise
3.  Convertendo os dados de população para número
4.  Convertendo os dados de percentual de população em relação à
    população total do mundo para número.
5.  Convertendo os dados de data para o formato IDate o que permite a
    manipulação matemática dos mesmos.

#### 1. Criando função auxiliar customizada para limpar os nomes das variáveis

``` r
limpeza.nomes <- function(nomes)
{
  nomes.limpos <- nomes %>% stringr::str_replace_all("/", "") %>% stringr::str_replace_all("\\s", "_") %>% stringr::str_replace_all("__", "_")
  return(nomes.limpos)  
}

names(pop.mundial) <- limpeza.nomes(names(pop.mundial))
names(pop.mundial)
```

    ## [1] "Rank"                                        
    ## [2] "Country_Dependency"                          
    ## [3] "Population"                                  
    ## [4] "Percentage_of_the_world"                     
    ## [5] "Date"                                        
    ## [6] "Source_(official_or_from_the_United_Nations)"

#### 2. Selecionando apenas as variáveis de interesse para análise

``` r
pop.mundial <- pop.mundial %>% dplyr::select(Rank:Date)
```

#### 3. Convertendo os dados de população para número

``` r
pop.mundial <- pop.mundial %>% dplyr::mutate(Population = as.numeric(stringr::str_replace_all(Population, "\\,", "")))
```

#### 4. Convertendo os dados de percentual de população em relação à população total do mundo para número.

``` r
pop.mundial <- pop.mundial %>% dplyr::mutate(Percentage_of_the_world = as.numeric(stringr::str_replace_all(Percentage_of_the_world, "%", ""))/100)
```

#### 5. Convertendo os dados de data para o formato IDate o que permite a manipulação matemática dos mesmos.

``` r
pop.mundial <- pop.mundial %>% dplyr::mutate(Date = as.IDate(gsub(" ", "-", Date), format = "%d-%b-%Y"))
```

#### Dados após limpeza

Após passar pelo passo a passo de limpeza dos dados podemos ver como ele
se encontra ao final do processo.

``` r
kable(head(pop.mundial))
```

| Rank | Country_Dependency | Population | Percentage_of_the_world | Date       |
|-----:|:-------------------|-----------:|------------------------:|:-----------|
|    1 | China              | 1412600000 |                  0.1760 | 2021-12-31 |
|    2 | India              | 1373761000 |                  0.1710 | 2022-03-01 |
|    3 | United States      |  333672582 |                  0.0416 | 2023-02-14 |
|    4 | Indonesia          |  275773800 |                  0.0344 | 2022-07-01 |
|    5 | Pakistan           |  229488994 |                  0.0286 | 2022-07-01 |
|    6 | Nigeria            |  216746934 |                  0.0271 | 2022-07-01 |

Reparem que agora podemos filtrar os dados por data de atualização, fato
que não era possível quando as datas eram tratadas como texto.

``` r
pop.mundial %>% dplyr::filter(year(Date) > '2022')
```

    ## # A tibble: 2 × 5
    ##    Rank Country_Dependency Population Percentage_of_the_world Date      
    ##   <int> <chr>                   <dbl>                   <dbl> <IDate>   
    ## 1     3 United States       333672582                  0.0416 2023-02-14
    ## 2     7 Brazil              215772066                  0.0269 2023-02-14

## Vem mais por aí

Podemos criar um plot e reportá-lo em nosso documento a partir dos
dados, que tal?

``` r
ggplot(pop.mundial %>% dplyr::select(Country_Dependency, Population), aes(x = Country_Dependency, y =Population)) + geom_bar(stat = "identity")
```

![](Aula5_files/figure-gfm/plotando%20a%20informacao%20populacao-1.png)<!-- -->
