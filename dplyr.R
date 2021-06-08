##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 31 de maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##



## Atividade: Dplyr

# Abrir pacotes

library(rio) # abrir banco de dados
library(dplyr)


#Pasta de destino
setwd("~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Dissertação/Dados - Bruto")


#Abrir banco de dados

banco_pedro <- import("bancoPedro.xlsx")


# sumários
count(banco_pedro, regio) 


# sumários com agrupamentos 

#variável investimento
banco_pedro %>% group_by(regio) %>% summarise(avg = mean(inv))

# Transformacao

banco_pedro %>%  filter(regio != "1 - Norte") %>% summarise(avg = mean(inv)) #tudo menos, região norte
banco_pedro %>%  filter(regio != "1 - Norte") %>% group_by(regio, PORT) %>% summarise(avg = mean(inv))


# Manipulacao de coluna

banco_pedro %>% mutate(pib_pc = pib/pop)


