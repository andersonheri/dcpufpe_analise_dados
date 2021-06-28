## Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 28 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Introdução a data e tempo


# Carregando os pacotes

library(lubridate)

# Converter os dados em classes distintas

(str(data1 <- as.Date(c("1993-03-10", "2010-03-10", "2020-03-10")) ) ) # Registra apenas datas

(str(date2 <- as.POSIXct(c("1993-03-10 10:30", "2010-03-10 11:00", "2020-03-10 19:30")) ) ) #Registra datas e segundos

(str(data3 <- as.POSIXlt(c("1993-03-10 10:30", "2010-03-10 11:00", "2020-03-10 19:30")) ) ) #Registra componentes de tempo


# Extracao dos componentes do dados 2


year(date2)

month(date2)

epiweek(date2)





