## Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 28 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Data na Prática


# Carregando os pacotes e instalando dados

library(lubridate)
install.packages("drc")
library(drc) 
library(plotly) 



# Abrir banco de sinistros em RECIFE em 2019

url <- 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' 

covidBR <- read.csv2(url, encoding='latin1', sep = ',') 

# Apenas casos do Amazonas

covidAM <- subset(covidBR, state == 'AM') 



# Tranformacao

str(covidAM) # Checar o formato do banco

covidAM$date <- as.Date(covidAM$date, format = "%Y-%m-%d")  #Trandormar no formato de data

covidAM$dia <- seq(1:length(covidAM$date)) # Criar variável de dias

# Predicao

predDia <- data.frame(dia = covidAM$dia) # Criar vetores para dias
predSeq <-  data.frame(dia = seq(max(covidAM$dia)+1, max(covidAM$dia)+180)) 

predDia <- rbind(predDia, predSeq) #juntar bancos


# Estimar predicao

fitLL <- drm(tests ~ dia, fct = LL2.5(),
             data = covidAM, robust = 'mean') 

plot(fitLL, log="", main = "Log logistic")  #ajuste da curva

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) 

predLL$data <- seq.Date(as.Date('2020-04-26'), by = 'day', length.out = length(predDia$dia))

predLL <- merge(predLL, covidAM, by.x ='data', by.y = 'date', all.x = T) 


# Plotando as predições no Amazonas 


am_graph <- plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines',
  name = "Testes - Predição") %>% add_trace(x = ~data, y = ~tests, name = "Testes - Observados", mode = 'lines') %>% 
  layout(title = 'Predição de Testes de COVID 19 no Amazonas', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Volume de Testes Acumulados por Dia', showgrid = FALSE),
  hovermode = "compare") 

am_graph

