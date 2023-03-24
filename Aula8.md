Análise descritiva de uma base de dados
================
Otto Tavares
2023-02-13

## Introdução

Na Aula 8, temos o objetivo de abrir uma base de dados e dar os
primeiros passos em análise estatística dessa base.

Como sempre, o primeiro passo é importar as bibliotecas que serão
utilizadas para análise, como tydiverse, summarytools e dlookr.

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

#crimes.furtos %>% dplyr::filter(mes_ano == "2022m12") %>% diagnose()

#crimes.furtos %>% dplyr::filter(mes_ano == "2022m12") %>% dfSummary() %>% view()
```

A base trabalhada nesta aula, será a base de dados hipotética
disponbilizada no livro texto dos autores Bussab e Moretim. Vamos
importá-la e imprimir as primeiras observações para conhecimento das
variáveis.

``` r
kable(salarios)
```

<table>
<thead>
<tr>
<th style="text-align:right;">
n
</th>
<th style="text-align:left;">
estado_civil
</th>
<th style="text-align:left;">
Grau_de_instrucao
</th>
<th style="text-align:right;">
n_filhos
</th>
<th style="text-align:right;">
salario
</th>
<th style="text-align:right;">
idade_anos
</th>
<th style="text-align:right;">
idade_meses
</th>
<th style="text-align:left;">
regiao
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
4.00
</td>
<td style="text-align:right;">
26
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4.56
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
5.25
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
5.73
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
6.26
</td>
<td style="text-align:right;">
40
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
6.66
</td>
<td style="text-align:right;">
28
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
6.86
</td>
<td style="text-align:right;">
41
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
7.39
</td>
<td style="text-align:right;">
43
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
7.59
</td>
<td style="text-align:right;">
34
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
7.44
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
8.12
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
8.46
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
8.74
</td>
<td style="text-align:right;">
37
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
8.95
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
9.13
</td>
<td style="text-align:right;">
30
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
9.35
</td>
<td style="text-align:right;">
38
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
9.77
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
9.80
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
10.53
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
10.76
</td>
<td style="text-align:right;">
37
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
11.06
</td>
<td style="text-align:right;">
30
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
11.59
</td>
<td style="text-align:right;">
34
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
12.00
</td>
<td style="text-align:right;">
41
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
12.79
</td>
<td style="text-align:right;">
26
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
13.23
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
13.60
</td>
<td style="text-align:right;">
35
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
ensino fundamental
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
13.85
</td>
<td style="text-align:right;">
46
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
14.69
</td>
<td style="text-align:right;">
29
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
14.71
</td>
<td style="text-align:right;">
40
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
15.99
</td>
<td style="text-align:right;">
35
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
16.22
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
outra
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
16.61
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
interior
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
17.26
</td>
<td style="text-align:right;">
43
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;">
solteiro
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
18.75
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
ensino médio
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
19.40
</td>
<td style="text-align:right;">
48
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
capital
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;">
casado
</td>
<td style="text-align:left;">
superior
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
23.30
</td>
<td style="text-align:right;">
42
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
interior
</td>
</tr>
</tbody>
</table>

\###Identificando os tipos de cada variável na base

Para identificar os tipos de cada variável na base, vamos utilizar a
função diagnose do pacote dlookr e reportar o tipo de cada um para
melhor trabalharmos os dados.

``` r
salarios %>% dlookr::diagnose()
```

    ## # A tibble: 8 × 6
    ##   variables         types     missing_count missing_percent unique_count uniqu…¹
    ##   <chr>             <chr>             <int>           <dbl>        <int>   <dbl>
    ## 1 n                 numeric               0             0             36  1     
    ## 2 estado_civil      character             0             0              2  0.0556
    ## 3 Grau_de_instrucao character             0             0              3  0.0833
    ## 4 n_filhos          numeric              16            44.4            6  0.167 
    ## 5 salario           numeric               0             0             36  1     
    ## 6 idade_anos        numeric               0             0             24  0.667 
    ## 7 idade_meses       numeric               0             0             12  0.333 
    ## 8 regiao            character             0             0              3  0.0833
    ## # … with abbreviated variable name ¹​unique_rate

É fácil ver que na base há três variáveis qualitativas, sendo as
variáveis Estado Civil e região nominais, enquanto a variável Grau de
Instrução é ordinal.

Sobre as variáveis quantitativas, temos número de filhos e idade com
variáveis discretas, equanto a variável salário é contínua.

\##Análise de frequências de variáveis qualitativas

A variável região é uma das variáveis qualitativas nominais da base,
sendo uma variável interessante para extraírmos as frequências. Para
esse caso, vamos utilizar a função freq() do pacote summarytools

``` r
salarios %>% dplyr::select(regiao) %>% summarytools::freq()
```

    ## Frequencies  
    ## salarios$regiao  
    ## Type: Character  
    ## 
    ##                  Freq   % Valid   % Valid Cum.   % Total   % Total Cum.
    ## -------------- ------ --------- -------------- --------- --------------
    ##        capital     11     30.56          30.56     30.56          30.56
    ##       interior     12     33.33          63.89     33.33          63.89
    ##          outra     13     36.11         100.00     36.11         100.00
    ##           <NA>      0                               0.00         100.00
    ##          Total     36    100.00         100.00    100.00         100.00

Nas colunas Freq, temos a frequência absoluta, mostrando um grau de
bastante homogeneidade entre as classes. Padrão esse, que é confirmado
com a coluna Valid, que apresenta as frequências relativas de cada opção
de região.

Podemos fazer a mesma análise para os dados de estado civil, os quais
podemos estar interessados em buscar evidência se há mais funcionários
casados ou solteiros na empresa. A seguir, temos a tabela destas
proporções, onde é perceptível que há maior proporção de funcionários
casados.

``` r
salarios %>% dplyr::select(estado_civil) %>% summarytools::freq()
```

    ## Frequencies  
    ## salarios$estado_civil  
    ## Type: Character  
    ## 
    ##                  Freq   % Valid   % Valid Cum.   % Total   % Total Cum.
    ## -------------- ------ --------- -------------- --------- --------------
    ##         casado     20     55.56          55.56     55.56          55.56
    ##       solteiro     16     44.44         100.00     44.44         100.00
    ##           <NA>      0                               0.00         100.00
    ##          Total     36    100.00         100.00    100.00         100.00

É importante destacar, que lemos a coluna Valid sem nos preocupar nestes
casos, pois não há dados faltantes para nenhumas das duas variáveis.

Por fim, podemos criar tabelas de frequências para uma variável
quantitativa discreta, como é o caso do número de filhos dos
funcionários da empresa.

``` r
salarios %>% dplyr::select(n_filhos) %>% summarytools::freq()
```

    ## Frequencies  
    ## salarios$n_filhos  
    ## Type: Numeric  
    ## 
    ##               Freq   % Valid   % Valid Cum.   % Total   % Total Cum.
    ## ----------- ------ --------- -------------- --------- --------------
    ##           0      4     20.00          20.00     11.11          11.11
    ##           1      5     25.00          45.00     13.89          25.00
    ##           2      7     35.00          80.00     19.44          44.44
    ##           3      3     15.00          95.00      8.33          52.78
    ##           5      1      5.00         100.00      2.78          55.56
    ##        <NA>     16                              44.44         100.00
    ##       Total     36    100.00         100.00    100.00         100.00

Como há dados faltantes para essa variável, é importante o analista
determinar qual o espaço amostral está interessado em focar sua análise.

A fim de ser comparável às análises pregressas, é importante que as
frequências absoluta e relativa do total de dados seja considerada, isto
é, leitura da coluna Total, a fim de manter o mesmo espaço amostral.

Caso, ele esteja interessado em analisar apenas os dados válidos, ele
pode redefinir o espaço amostral, ler apenas a coluna Valid, porém
recalculando as tabelas anteriores, considerando os indivíduos apenas
com dados preenchidos para a variável filhos.

``` r
summarytools::ctable(x = salarios$Grau_de_instrucao, 
       y = salarios$regiao, 
       prop = "r") 
```

    ## Cross-Tabulation, Row Proportions  
    ## Grau_de_instrucao * regiao  
    ## Data Frame: salarios  
    ## 
    ## -------------------- -------- ------------ ------------ ------------ -------------
    ##                        regiao      capital     interior        outra         Total
    ##    Grau_de_instrucao                                                              
    ##   ensino fundamental             4 (33.3%)    3 (25.0%)    5 (41.7%)   12 (100.0%)
    ##         ensino médio             5 (27.8%)    7 (38.9%)    6 (33.3%)   18 (100.0%)
    ##             superior             2 (33.3%)    2 (33.3%)    2 (33.3%)    6 (100.0%)
    ##                Total            11 (30.6%)   12 (33.3%)   13 (36.1%)   36 (100.0%)
    ## -------------------- -------- ------------ ------------ ------------ -------------

``` r
summarytools::ctable(x = factor(salarios$n_filhos), 
       y = salarios$estado_civil, 
       prop = "r") 
```

    ## Cross-Tabulation, Row Proportions  
    ## factor(salarios$n_filhos) * estado_civil  
    ## 
    ## --------------------------- -------------- ------------- ------------- -------------
    ##                               estado_civil        casado      solteiro         Total
    ##   factor(salarios$n_filhos)                                                         
    ##                           0                   4 (100.0%)    0 (  0.0%)    4 (100.0%)
    ##                           1                   5 (100.0%)    0 (  0.0%)    5 (100.0%)
    ##                           2                   7 (100.0%)    0 (  0.0%)    7 (100.0%)
    ##                           3                   3 (100.0%)    0 (  0.0%)    3 (100.0%)
    ##                           5                   1 (100.0%)    0 (  0.0%)    1 (100.0%)
    ##                        <NA>                   0 (  0.0%)   16 (100.0%)   16 (100.0%)
    ##                       Total                  20 ( 55.6%)   16 ( 44.4%)   36 (100.0%)
    ## --------------------------- -------------- ------------- ------------- -------------

``` r
salarios %>% ggplot(aes(x = estado_civil, y = Grau_de_instrucao, fill = salario)) + geom_tile() + xlab('Estado Civil') + ylab('Grau de Instrução')
```

![](Aula8_files/figure-gfm/heatmat%20estado%20civil%20e%20instrucao-1.png)<!-- -->

``` r
salarios %>% ggplot(aes(x = regiao, y = Grau_de_instrucao, fill = salario)) + geom_tile() + xlab('Região') + ylab('Grau de Instrução')
```

![](Aula8_files/figure-gfm/heatmat%20estado%20civil%20e%20regiao-1.png)<!-- -->

\##Análise descritiva e de histogramas de uma variável contínua

Já para a variável salários, podemos analisar a centralidade dos dados,
dipersão, assimetria, bem como suas estatísticas de ordem, a fim de
checar se há presença de outliers.

Para realizar essa análise, podemos utilizar a função descr do pacote
summarytools, e posteriormente realizar a leitura desses dados.

``` r
salarios %>% dplyr::select(salario) %>% summarytools::descr()
```

    ## Descriptive Statistics  
    ## salarios$salario  
    ## N: 36  
    ## 
    ##                     salario
    ## ----------------- ---------
    ##              Mean     11.12
    ##           Std.Dev      4.59
    ##               Min      4.00
    ##                Q1      7.52
    ##            Median     10.16
    ##                Q3     14.27
    ##               Max     23.30
    ##               MAD      4.72
    ##               IQR      6.51
    ##                CV      0.41
    ##          Skewness      0.60
    ##       SE.Skewness      0.39
    ##          Kurtosis     -0.33
    ##           N.Valid     36.00
    ##         Pct.Valid    100.00

É possível ver pelo critério de skewness discutido em aula, que o valor
de 0.6 para assimetria, nos faz interpretar essa distribução como
levemente assimétrica, com cauda à direita.

Em decorrência desta assimetria, observamos que média e mediana
apresentam valores distintos, com a média tendo valor levemente
superior, o que aponta que os valores mais distantes do centro da
distribuição puxam o valor da média pra cima.

Já a mediana por ser uma estatística de ordem, não é sensível a dados
que apresentam alto valor na distribuição, o que é reforçado por seu
valor levemente mais baixo que a média.

Reparem que se tivéssemos outliers nesta distribuição a média se
descolaria ainda mais da mediana, pois estaria totalmente suscetível à
contaminação.

\##Análise visual da variável salário

Para realizar a análise visual da variável salários, seguimos o padrão
de binarização recomendado pelos detentores dos dados. No entanto,
reparem que se estivésses interessados em outras regras de binarização
seríamos livres para escolher.

Devemos sempre ter em mente que escolher bins para aproximar a
distribuição de probabilidade de uma determinada variável nos incorre em
perda de informação, uma vez que estamos tratando como indiferentes
eventos distintos para estarem em grupos contíguous do histograma.

``` r
salarios %>% dplyr::select(salario) %>% ggplot(aes(x=salario))+geom_histogram(aes(y = after_stat(density)) ,bins = 5, fill = 'lightblue') + xlab('Salário') + ylab('Densidade de Frequência') + geom_vline(xintercept=c(median(salarios$salario), mean(salarios$salario))) + annotate("text", x=median(salarios$salario) + 0.3, y=0.05, label="Mediana", angle=90) + annotate("text", x=mean(salarios$salario) + 0.3, y=0.05, label="Média", angle=90) + theme_classic()
```

![](Aula8_files/figure-gfm/analisando%20salario%20visualmente%20-1.png)<!-- -->

Reparem por essa visualização que a leitura visual nos leva a conclusões
semelhantes a nossa leitura das estatísticas descritas, como por
exemplo:

1.  Leve assimetria com cauda à direita
2.  Centralidade dos dados calculada pela média sofre leve contaminação
    dos valores mais distantes do centro da distribuição
3.  Por mais que sejam poucas observações os dados não apresentam
    dispersão elevada, tendo a maioria dos dados concentrada próxima ao
    centro da distribuição.

É importante dizer, que o tamanho da perda de informação, ao aproximar a
distribuição por um histograma, será proporcional ao espaço que o
histograma deixa de preencher como distância da distribuição original
dos dados.

Por mais que a estimativa por kernel não seja a distribuição original
dos dados, ela tende a ser mais próxima da mesma. Logo, temos uma certa
leitura aproximada do tamanho de informação perdida com a análise que
segue.

``` r
salarios %>% dplyr::select(salario) %>% ggplot(aes(x=salario))+geom_histogram(aes(y = after_stat(density)) ,bins = 5, fill = 'lightblue') + xlab('Salário') + ylab('Densidade de Frequência') + labs(title = "Distribuição dos dados de salário aproximada por Histograma", subtitle = "Binarização sugerida pelos detentores dos Dados") + geom_vline(xintercept=c(median(salarios$salario), mean(salarios$salario))) + annotate("text", x=median(salarios$salario) + 0.3, y=0.05, label="Mediana", angle=90) + annotate("text", x=mean(salarios$salario) + 0.3, y=0.05, label="Média", angle=90) + geom_density(linetype = 2) + theme_classic()
```

![](Aula8_files/figure-gfm/analisando%20salario%20visualmente%20com%20kernel%20-1.png)<!-- -->

Poderíamos também considerar outras regra de binarização levando em
consideração regras disponíveis na literatura, como a regra de
Freedman-Diaconis, bem como a regra de Sturge, como segue:

``` r
fd <- function(x) {
  n <-length(x)
  return((2*IQR(x))/n^(1/3))
}


sr <- function(x) {
  n <-length(x)
  return((3.49*sd(x))/n^(1/3))
}
```

Como visto em aula, a definição do intervalo do bin pela regra de
Freedman-Diaconis leva em consideração o intervalo interquartil dos
dados, o que impede com que eventuais outliers tenham influência na
definição da amplitude do intervalo do bin.

Enquanto a regra de Sturge leva em consideração a dispersão da
distribuição para definir a amplitude. Em geral, a regra de Sturge é
mais recomendada quando o autor tem alguma evidência de que a
distribuição dos dados se aproximará de uma distribuiçao normal, pelo
menos no casso assintótico, isto é, quando a amostra dos dados é grande
o suficiente.

``` r
salarios %>% dplyr::select(salario) %>% ggplot(aes(x=salario))+geom_histogram(aes(y = after_stat(density)) , binwidth=fd, fill = 'lightblue') + xlab('Salário') + ylab('Densidade de Frequência') + labs(title = "Distribuição dos dados de salário aproximada por Histograma", subtitle = "Binarização pela Regra de FD") + geom_vline(xintercept=c(median(salarios$salario), mean(salarios$salario))) + annotate("text", x=median(salarios$salario) + 0.3, y=0.05, label="Mediana", angle=90) + annotate("text", x=mean(salarios$salario) + 0.3, y=0.05, label="Média", angle=90) + geom_density(linetype = 2) + theme_classic()
```

![](Aula8_files/figure-gfm/analisando%20salario%20visualmente%20com%20kernel%20e%20bin%20FD%20-1.png)<!-- -->

Após a aplicar a regra de Freedman-Diaconis, nosso histograma apresentou
um bin a mais, o que pode ser justificado pela extração de um maior
nível de detalhes da distribuição dos dados.

O que é interessante é que o padráo de assimetria fica ainda mais
evidente com a Moda da distribuição aproximada claramente à esquerda
mediana e da média.

``` r
salarios %>% dplyr::select(salario) %>% ggplot(aes(x=salario))+geom_histogram(aes(y = after_stat(density)) , binwidth=sr, fill = 'lightblue') + xlab('Salário') + ylab('Densidade de Frequência') + labs(title = "Distribuição dos dados de salário aproximada por Histograma", subtitle = "Binarização pela Regra de Sturge") + geom_vline(xintercept=c(median(salarios$salario), mean(salarios$salario))) + annotate("text", x=median(salarios$salario) + 0.3, y=0.05, label="Mediana", angle=90) + annotate("text", x=mean(salarios$salario) + 0.3, y=0.05, label="Média", angle=90) + geom_density(linetype = 2) + theme_classic()
```

![](Aula8_files/figure-gfm/analisando%20salario%20visualmente%20com%20kernel%20e%20bin%20SR%20-1.png)<!-- -->

Enquanto que ao utilizarmos a regra de Sturge, extraímos exatamente o
mesmo padrão sugerido pelos autores, o que nos levanta a desconfiança de
eles terem utilizado exatamente a mesma função para realizar a escolha
de bins.

\##Analisando a matriz de correlação da sub-amostra dos indivíduos que
preencheram a variável de filhos

Vamos filtrar apenas os indivíduos de um determinado setor de uma
empresa que tenham preenchido os dados de filhos no banco de dados. Aqui
é importante destacar, que ao fazer esse filtro, muda-se o espaço
amostral, esses valores não devem ser comparados com as tabelas
anteriores.

``` r
kable(cor(salarios %>% dplyr::filter(!is.na(n_filhos)) %>% dplyr::select(salario, n_filhos, idade_anos)))
```

<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
salario
</th>
<th style="text-align:right;">
n_filhos
</th>
<th style="text-align:right;">
idade_anos
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
salario
</td>
<td style="text-align:right;">
1.0000000
</td>
<td style="text-align:right;">
0.3580647
</td>
<td style="text-align:right;">
0.4816920
</td>
</tr>
<tr>
<td style="text-align:left;">
n_filhos
</td>
<td style="text-align:right;">
0.3580647
</td>
<td style="text-align:right;">
1.0000000
</td>
<td style="text-align:right;">
0.7465385
</td>
</tr>
<tr>
<td style="text-align:left;">
idade_anos
</td>
<td style="text-align:right;">
0.4816920
</td>
<td style="text-align:right;">
0.7465385
</td>
<td style="text-align:right;">
1.0000000
</td>
</tr>
</tbody>
</table>

É fácil ver que quanto maior a idade dos funcionários maior a quantidade
de filhos. Relação não tão direta quando o assunto são as comparações
entre salário e idade, ou salário e número de filhos.

Podemos a partir daí, contruir um scatterplot entre as variáveis idade e
quantidade de filhos a fim de ver a relação positiva de crescimento
propocional entre as variáveis, como segue:

``` r
salarios %>% dplyr::filter(!is.na(n_filhos)) %>% dplyr::select(idade_anos, n_filhos) %>% ggplot(aes(x=n_filhos, y =idade_anos)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + theme_classic()
```

    ## `geom_smooth()` using formula = 'y ~ x'

![](Aula8_files/figure-gfm/analisando%20scatter%20entre%20variaveis%20mais%20correlacionadas%20-1.png)<!-- -->
