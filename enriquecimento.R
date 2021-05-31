###Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 22 de maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Enriquecimento 


## chamando bases de dados

setwd(""~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Dissertação/Dados - Bruto"")

# Abrir pacote de importacao

library(rio)

reelicao <- import("reeleição.xlsx")
gasto <- import("bancoPedro.xlsx")

## enriquecendo as informações

gastos_all <- left_join(gasto, reelicao, by = ('codibge6' = 'codibge6'))


#Checar os nomes
names(gastos_all)

