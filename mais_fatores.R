##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 31 de maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##



## Atividade: Mais fatores

# Abrir pacotes

library(rio) # abrir banco de dados
library(ade4)
library(arules)
library(forcats)
library(funModeling) 

#Pasta de destino
setwd("~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Dissertação/Dados - Bruto")


#Abrir banco de dados

banco_pedro <- import("bancoPedro.xlsx")

# Ver a estrutura do banco
str(banco_pedro)

#função para transformar variáveis em fatores

for (i in 14:30) {
  banco_pedro[, i] <- as.factor(banco_pedro[, i])
}


# Transformar em fatores
bancoFactor <- unlist (lapply(banco_pedro, is.factor))
factorbanco <- banco_pedro [, bancoFactor ]

#C onsultar
str(factorbanco)


# Hot Incoding
banco_dummy <- acm.disjonctif(factorbanco)