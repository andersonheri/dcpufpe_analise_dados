## Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 5 de julho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Avaliacao

# Definir pasta de destino

setwd("~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Doutorado/Analise de Dados")


# Carregando os pacotes  necessarios para o exercicio 3

library(dplyr)
library(tidyverse)
library(stringr)
library(lubridate)
library(data.table)
library(rio)


### Atv. 1 - Extraia a base geral de covid em Pernambuco disponível neste ####


covid <- fread("https://dados.seplag.pe.gov.br/apps/basegeral.csv", sep =';',
               na.strings=c(""," ","NA")) 


#### Atv. 2 -  criando variável de semana epidemiológica chamada "semana epi" e inserindo em uma base ####
### modificada chamada "dados_mod"

epiweek(covid$dt_notificacao) 

covid_mod <- covid %>% mutate("semana epi" = epiweek(covid$dt_notificacao)) 


### Calculando, para cada município do Estado, o total de casos confirmados e o total 
# de óbitos por semana epidemiológica

confirmados <- covid_mod %>% filter(classe == "CONFIRMADO") %>% group_by(municipio) %>% count(`semana epi`)
data_confirmados <- confirmados


obitos <- covid_mod %>% filter(evolucao == "OBITO") %>% group_by(municipio) %>% count(`semana epi`) 
data_obitos <- obitos

### Atv 3 - Enriqueça a base criada no passo 2 com a população de cada município, ####
#usando a tabela6579 do sidra ibge.

ibge <- import("tabela6579.xlsx")

# Retirar primeiras linhas e transformar nome da variavel

ibge <- ibge[-(1:4), ] #Retirar linha
ibge <- rename(ibge, municipio = `Tabela 6579 - População residente estimada`) #Renomear
ibge <- rename(ibge, populacao = `...2`) #Renomear
ibge$populacao <- as.numeric(ibge$populacao) # Transformar em numerico



# Corrigir espaco, letra maiscula e retirar os acentos das variaveis ===#

# Funcao para remover espaco em branco
trim <- function (x) gsub("^\\s+|\\s+$", "", x) 
ibge$municipio <- trim(ibge$municipio)



#Funcao para colocar em maiscula
ibge$municipio <- toupper(ibge$municipio) # coloca maiscula


# Listar todos os acentos

unwanted_array <- list(    'S'='S', 's'='s', 'Z'='Z', 'z'='z', 'À'='A', 'Á'='A', 'Â'='A', 'Ã'='A', 'Ä'='A', 'Å'='A', 'Æ'='A', 'Ç'='C', 'È'='E', 'É'='E',
                           'Ê'='E', 'Ë'='E', 'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I', 'Ñ'='N', 'Ò'='O', 'Ó'='O', 'Ô'='O', 'Õ'='O', 'Ö'='O', 'Ø'='O', 'Ù'='U',
                           'Ú'='U', 'Û'='U', 'Ü'='U', 'Ý'='Y', 'Þ'='B', 'ß'='Ss', 'à'='a', 'á'='a', 'â'='a', 'ã'='a', 'ä'='a', 'å'='a', 'æ'='a', 'ç'='c',
                           'è'='e', 'é'='e', 'ê'='e', 'ë'='e', 'ì'='i', 'í'='i', 'î'='i', 'ï'='i', 'ð'='o', 'ñ'='n', 'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o',
                           'ö'='o', 'ø'='o', 'ù'='u', 'ú'='u', 'û'='u', 'ý'='y', 'ý'='y', 'þ'='b', 'ÿ'='y' )




# Funcao para retirar os acentos 
for(i in seq_along(unwanted_array))
  ibge$municipio <- gsub(names(unwanted_array)[i],unwanted_array[i],ibge$municipio)




# ===== Organizando o banco ========== #

#Copiar os ultimos caracteres para criar UF
ibge$UF <- str_sub(ibge$municipio,-4, -1) # "-" indica que serao os ultimos caracteres

#Retirar os Ultimos digitos da coluna
ibge$municipio <- str_sub(ibge$municipio, 1, str_length(ibge$municipio)-4)

status (ibge)


# Pegar apenas PE
ibge_pe <- subset(ibge, UF =="(PE)")




# Criar no banco mod uma variavel "UF" para mergir

covid_mod$UF <- "(PE)" #Criar variavel PE em "Covid_mod"

final_covid <- left_join(covid_mod, ibge_pe, by = "municipio", "UF")



### Atv. 5

#incidencia
data_confirmados$inc <- (data_confirmados %>% group_by(municipio) %>% count(`semana epi`) %>% mutate(n = n/100000))

# letalidade
data_obitos$let <- (data_obitos %>% group_by(municipio) %>% count(`semana epi`) %>% mutate(n/100000))



