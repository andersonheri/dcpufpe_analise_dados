## Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 2 de julho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Exercicio 3

# Definir pasta de destino

setwd("~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Doutorado/Analise de Dados")


# Carregando os pacotes  necessarios para o exercicio 3

library(Hmisc)
library(funModeling)
library(tidyverse)
library(stringr)
library(zoo)
library(lubridate)


## Atv. 1 - Extraia a base geral de covid em Pernambuco disponível neste 

covid_pe <- read.csv("basegeral.csv", sep = ";", na.strings = "")

# Meu computador nao estava lendo a base online. Tive que baixar o arquivo para executar



## Atv. 2 - Corrija os NAs da coluna "sintomas" através de imputação randômica

# Ver qts valores ausentes existem no arquivo

status(covid_pe)

# Imputar valores aleatorios para a variavel sintoma

covid_pe$sintomas <- impute(covid_pe$sintomas, "random")



## Atv. 3 - Calcule, para cada município do Estado, o total de casos confirmados e negativos

# Variavel binaria para "Confirmado" 
covid_pe$confirmados <- ifelse(covid_pe$classe == "CONFIRMADO", 1, 0)

# Totais de "confirmado' por municipio de Pernambuco
covid_pe <- covid_pe %>% group_by(cd_municipio) %>% mutate(casos_confirmados = sum(confirmados))


# Variavel binaria para "Negativo" 
covid_pe$negativos <- ifelse(covid_pe$classe == "NEGATIVO", 1, 0)


# Totais de "confirmado' por municipio de Pernambuco
covid_pe <- covid_pe %>% group_by(cd_municipio) %>% mutate(casos_confirmados = sum(negativos))



## Atv. 4 - Crie uma variável binária se o sintoma inclui tosse ou não e
#calcule quantos casos confirmados e negativos tiveram tosse como sintoma


# Variavel sintoma "tosse"
covid_pe <- covid_pe %>% mutate(tosse = ifelse(grepl(paste("TOSSE", collapse="|"), sintomas), 'Sim', 'Não'))

# Calculando os casos com tosse
covid_pe <- covid_pe %>% group_by(tosse) %>% mutate(tosse_confirmado = sum(confirmados))



## Atv.5  - Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos

# Passo 1 - Transformar variavel "dt_notificacao" no formato 'as.Date'
covid_pe$dt_notificacao <- as.Date(covid_pe$dt_notificacao, format = "%Y-%m-%d") 

#  Passo 2 - Separar a variavel de "Pernambuco"

covid_pe <- covid_pe %>% mutate(estado = "PE")

# Passo 3 -Agrupar por dia (Confirmados)
covid_pe <- covid_pe %>% group_by(estado) %>% group_by(dt_notificacao) %>% mutate(soma_casos_dia = sum(confirmados))

# Passo 4 - Média móvel (Confirmados)
covid_pe <- covid_pe %>% mutate(confirmados_mm = round(rollmean(x = soma_casos_dia, 7, align = "right", fill = NA), 2))


# Passo 3 - Agrupar por dia (Negativo)
covid_pe <- covid_pe %>% group_by(estado) %>% group_by(dt_notificacao) %>% mutate(soma_negativos_dia = sum(negativos))

# Passo 4 - Média móvel (Negativo)
covid_pe <- covid_pe %>% mutate(negativos_mm = round(rollmean(x = soma_negativos_dia, 7, align = "right", fill = NA), 2))





