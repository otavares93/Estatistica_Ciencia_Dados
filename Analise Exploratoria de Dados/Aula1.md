Visualização da Distribuição de Dados
================
Otto Tavares
2023-02-13

## Introdução

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
library(dlookr)
```

    ## 
    ## Attaching package: 'dlookr'
    ## 
    ## The following object is masked from 'package:tidyr':
    ## 
    ##     extract
    ## 
    ## The following object is masked from 'package:base':
    ## 
    ##     transform

``` r
library(summarytools)
```

    ## 
    ## Attaching package: 'summarytools'
    ## 
    ## The following object is masked from 'package:tibble':
    ## 
    ##     view

``` r
library(readxl)
library(knitr)
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
library(ggpubr)
library(corrplot)
```

    ## corrplot 0.92 loaded

    ## ℹ Using "','" as decimal and "'.'" as grouping mark. Use `read_delim()` for more control.

    ## Rows: 32245 Columns: 63
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ";"
    ## chr  (3): mes_ano, munic, Regiao
    ## dbl (60): CISP, mes, ano, AISP, RISP, mcirc, hom_doloso, lesao_corp_morte, l...
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

# Limpando os dados e realizando diagnóstico

    ## `summarise()` has grouped output by 'AISP'. You can override using the
    ## `.groups` argument.

    ## # A tibble: 5 × 6
    ##   variables        types     missing_count missing_percent unique_count unique…¹
    ##   <chr>            <chr>             <int>           <dbl>        <int>    <dbl>
    ## 1 AISP             numeric               0               0           39   0.5   
    ## 2 mes.ano          IDate                 0               0            2   0.0256
    ## 3 roubo_transeunte numeric               0               0           63   0.808 
    ## 4 roubo_celular    numeric               0               0           50   0.641 
    ## 5 Regiao           character             0               0            4   0.0513
    ## # … with abbreviated variable name ¹​unique_rate

# Descrição via boxplot e tabelas de contingência

![](Aula1_files/figure-gfm/descrevendo%20a%20base%20com%20box%20plot%20roubo%20transeunte-1.png)<!-- -->

![](Aula1_files/figure-gfm/descrevendo%20a%20base%20com%20box%20plot%20roubo%20celular-1.png)<!-- -->

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

# Construindo os histogramas da Aula 1

![](Aula1_files/figure-gfm/filtrando%20os%20dados%20e%20visualizando%20dists.-1.png)<!-- -->

# Aplicando estimativa de densidade via kernel, através do kernel de epanechnikov

![](Aula1_files/figure-gfm/filtrando%20os%20dados%20e%20visualizando%20dists.%20com%20kernel-1.png)<!-- -->

# Calculando a distribuição acumulada empírica do fenômeno observado

![](Aula1_files/figure-gfm/filtrando%20os%20dados%20e%20visualizando%20dists.%20acumuladas-1.png)<!-- -->

# Calculando a dispersão e as correlações

![](Aula1_files/figure-gfm/calculando%20dispersao%20para%20as%20duas%20datas-1.png)<!-- -->

![](Aula1_files/figure-gfm/calculando%20corrplot%20pearson-1.png)<!-- -->

![](Aula1_files/figure-gfm/calculando%20corrplot%20spearman-1.png)<!-- -->
