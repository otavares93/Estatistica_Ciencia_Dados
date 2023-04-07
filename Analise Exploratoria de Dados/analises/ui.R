library(dplyr)
library(tidyr)
library(data.table)
library(scales)
library(markdown)
library(shiny)
library(htmlwidgets)
library(shinyWidgets)
library(RColorBrewer)
library(knitr)
#library(gganimate)


shinyUI(
	fluidPage(
	tags$head(tags$style(
	      "body { word-wrap: break-word; }"
			)),
	tags$head(
      tags$link(rel = "shortcut icon", href = "img/logo_infnet"),
      #-- biblio js ----
      tags$link(rel="stylesheet", type = "text/css",
                href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"),
      tags$link(rel="stylesheet", type = "text/css",
                href = "https://fonts.googleapis.com/css?family=Open+Sans|Source+Sans+Pro")
			),
	includeCSS("www/styles.css"),
	navbarPage("Análise exploratória de dados",
     tabPanel("Referências e Introdução", 
              
              #Introduzindo a primeira página com sugestões de leitura 
              flowLayout(img(src='logo_infnet.png', align = "left", height = '100px', width = '100px'),
               includeMarkdown("introducao.Rmd"))),
		 tabPanel("Análise de Salários",
		          p("Gráfico de linhas sob seleção de variáveis"),
		          
		          #Painel principa com plot de salarios por linha
		          mainPanel(plotOutput("salarios_linha")),
		          
		          #Layout em flow para melhor justaposicao das opcoes
		          flowLayout(
		            
		          #Selecao das variaveis na base salarios
		          varSelectInput("variaveis_salarios", "Variáveis Salários:", salarios, multiple = FALSE),
		          
		          #Selecao de cores
		          selectInput('cor', label = 'Escolha uma cor:',
		            choices = c("lightblue", "lightgreen", "red"), selected = "red"),
		          
		          ),
		          
		          #Definindo o range do eixo x
		          numericRangeInput(inputId = "x_lim", label = "Insira valor mínimo e máximo para eixo x:",
		                            value = c(min(salarios$n), max(salarios$n))
		          ),
		          
		          #Definindo o range do eixo y
		          numericRangeInput(inputId = "y_lim", label = "Insira valor mínimo e máximo para eixo y:",
		                            value = c(min(salarios$n), max(salarios$n))
		          ),
		          

        ),
		tabPanel("Análise de crimes para o Estado do Rio de Janeiro",
		         
		    sidebarLayout(
		      # Painel principal com os plots de crimes
		        mainPanel(
		          div(class="span6",plotOutput("crimes")),
		          div(class="span6",plotOutput("crimes_evo")),
		        ),
		        sidebarPanel(
		        
		        #Inserindo texto com titulo do gráfico histograma
		        textInput("titulo_crimes", "Título do histograma:", "insira seu titulo"),
		        verbatimTextOutput("titulo_crimes"),
		        
		        #Criando os botoes para trocar o tipo de gráfico
		        actionButton("botao_cdf", "Trocar de histograma para acumulada"),
		        actionButton("reiniciar", "Voltar para histograma"),
		        
		        #Slider para trocar qual batalhao mostrar como gráfico de linhas
		        sliderInput("batalhoes_crimes","Selecione os batalhões:", min = min(crimes.aisp$AISP), max = max(crimes.aisp$AISP), value = 19), 
		      )
		    )
      )
    )
	)
)
