library(dplyr)
library(tidyr)
library(data.table)
library(scales)
library(markdown)
library(shiny)
library(zoo)
library(htmlwidgets)
library(shinyWidgets)
library(RColorBrewer)
library(knitr)
library(ggplot2)
#library(gganimate)


shinyServer(function(input, output){
  
  
  ######Painel de Salários
  
  #Criando um evento reativo que gera um plot quando uma das ações relacionadas 
  #ao gráfico de linhas muda, sendo elas, eixos, cores, e variáveis
  plot_salarios_reativo <- eventReactive(c(input$variaveis_salarios, input$cor, input$x_lim, input$y_lim),{
    
    #Plotando o gráfico com as definições do eixo x, de cores, etc.
    ggplot(data = salarios, aes_string(x = "n", y = input$variaveis_salarios)) +
        geom_line(color = input$cor) + ggplot2::xlim(input$x_lim) + ggplot2::ylim(input$y_lim) + theme_classic()
  })
  
  #Atualizando o range do y quando uma variável é trocada
  update_ylim <- eventReactive(c(input$variaveis_salarios),{
    if(length(input$variaveis_salarios) == 0) return(numericRangeInput(inputId = "y_lim", label = "Insira valor mínimo e máximo para eixo y:", value = c(min(salarios$n), max(salarios$n))))
    updateNumericRangeInput(inputId = "y_lim", value = c(min(salarios[,input$variaveis_salarios], na.rm = T), max(salarios[,input$variaveis_salarios], na.rm = T))) 
  })
  
  #Renderizando o plot construído iterativamente 
  output$salarios_linha <- renderPlot({
    #Controlando para o caso de não selecionar nenhuma variável, ou de a variável não ser numérica
    #De modo a não introduzir limites ao eixo y, para uma variável que não é numérica
    if ((length(input$variaveis_salarios) == 0) | (!is.numeric(unlist(salarios[,input$variaveis_salarios][1]))))
      {
        if((!is.numeric(unlist(salarios[,input$variaveis_salarios][1]))) & (length(input$variaveis_salarios) != 0)) return(ggplot(salarios, aes_string(x="n", y = input$variaveis_salarios)) + geom_line() + geom_line(color = input$cor)  + theme_classic())
        else return(ggplot(salarios, aes(x=n, y = n)) + geom_line() + geom_line(color = input$cor))
      }
      
    #Atualizando o eixo y
    update_ylim()
    #Plotando o gráfico de linhas reativamente
    plot_salarios_reativo()
  })

  
  #####Painel de crimes
  
  
  ### Renderizando um gráfico de evoluacao temporal de crimes em graficos de linha ###
  output$crimes_evo <- renderPlot({
        ggplot(crimes, aes(x = mes.ano, y = roubo_transeunte, group = AISP, color = as.factor(AISP))) + geom_line() + theme_classic()
  })
  
  ### Criando um gráfico interativo selecionando um batalhao por vez para ver a evolucao temporal ###
  plot_crimes_reativo <- eventReactive(input$batalhoes_crimes,{
    ggplot(data = crimes %>% dplyr::filter(AISP %in% input$batalhoes_crimes), aes(x = mes.ano, y = roubo_transeunte, group = AISP, color = as.factor(AISP))) +
      geom_line() + theme_classic()
  })
  
  #Renderizando o gráfico após a seleção dos batalhões
  output$crimes_evo <- renderPlot({
    plot_crimes_reativo()
  })
  
  ### Botoes para diferentes graficos de crimes ###
  #Renderizando o gráfico de histograma de crimes quando nenhum botão é apertado
  output$crimes <- renderPlot({
    crimes.aisp %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% ggplot(aes(x = roubo_transeunte)) + geom_histogram(aes(y = after_stat(density)), binwidth=fd, fill = 'lightblue') + labs(title = input$titulo_crimes) + geom_density(kernel = 'epanechnikov') + facet_wrap(~mes.ano)
  })
  
  #Evento interativo para trocar o gráfico exposto de histograma para distribuição acumulada
  observeEvent(input$botao_cdf,{
    output$crimes <- renderPlot({
      crimes.aisp %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% ggplot(aes(x = roubo_transeunte)) +stat_ecdf(geom = "step") + facet_wrap(~mes.ano)
    })
  })

  #Evento interativo para reiniciar o gráfico e trocar de histograma para distribuicao acumulada
  observeEvent(input$reiniciar,{
    output$crimes <- renderPlot({
      crimes.aisp %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% ggplot(aes(x = roubo_transeunte)) + geom_histogram(aes(y = after_stat(density)), binwidth=fd, fill = 'lightblue') + labs(title = input$titulo_crimes) + geom_density(kernel = 'epanechnikov') + facet_wrap(~mes.ano)
    })
  })
  
  
  #Caso quiséssemos acrescentar um dos relatorios em markdown para a análise de salários ou de crimes
  # output$salarios <- renderUI({
  #HTML(markdown::markdownToHTML(knitr::knit('salarios_analise.Rmd', output = 'html', quiet = FALSE)))
  #})
  
  #output$crimes <- renderPlot({
  #  crimes.aisp %>% dplyr::filter(mes.ano %in% c(as.IDate("01-12-2019",format = "%d-%m-%Y") ,as.IDate("01-12-2022",format = "%d-%m-%Y"))) %>% ggplot(aes(x = roubo_transeunte)) + geom_histogram(aes(y = after_stat(density)), binwidth=fd, fill = 'lightblue') + geom_density(kernel = 'epanechnikov') + labs(title = input$titulo_crimes) + facet_wrap(~mes.ano)
  #})
  
  #Acrescentar um relatorio markdown
  #output$crimes <- renderUI({
  #       HTML(markdown::markdownToHTML(knitr::knit('crimes_analise.Rmd', output = 'html', quiet = FALSE)))
         #params = list(paramOne = isolate(input$param))
  #  })
  
  }
)
