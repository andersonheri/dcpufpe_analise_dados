##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 7 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Valores Ausentes


# Definir o caminho das bases

getwd()

# Abrir pacotes de dados

library(tidyverse)
library(data.table)
library(funModeling) 
library(rio)


# Abrir banco de dados do QoG - Quality of Goverment da Universidade de Gotenburgo 


qog <- import ("qog_bas_cs_jan21.xlsx")


# Processo de visualizacao

View(qog)

attach(qog)

# Identificar valores ausentes no banco de dados
is.na.data.frame(qog)

# Foi constatado que o banco de dados em questão possui valores ausentes.

## Portanto, é necessario criando a matriz sombras:

shadowmatrix <- as.data.frame(abs(is.na(qog)))

head(shadowmatrix)

## apenas as colunas com NA

col_na<- shadowmatrix[which(sapply(qog, sd) > 0)]

cor(col_na)

head(col_na)


## Através da analise mostra-se que  não há uma associação aleatórtia  do tipo MAR (que corresponde
# a dificuldade de relacionar algo para preencher os casos)

