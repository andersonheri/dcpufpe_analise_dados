##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 22 de maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Descoberta

getwd()

# Instalar pacotes

install.packages("siconvr")

library(siconvr)

install.packages("funModeling")
library(funModeling) 

library(tidyverse) 

library(dplyr)

# Puxar dados de convenios

emendas <- get_siconv(dataset = "emendas")


## analisando as características 

glimpse(emendas) 

status(emendas) 

freq(emendas) 

plot_num(emendas) 

profiling_num(emendas) 


## Atividade: Estruturação


# # Instalar pacotes


install.packages("data.table")
library(data.table) 

library(tidyverse) 

library(dplyr)

# Pegar dados de Covid-19

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")


# Selecionar os casos
ocde_countries <- c("Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Czech Republic", "Denmark", 
                    "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", 
                    "Italy", "Japan", "Korea", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", 
                    "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", 
                    "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States")


# Filtrar os casos usando %in%
ocde <- general_data %>% filter(location %in% ocde_countries)


# Agrupar por regiao

ocde_group <- ocde %>% group_by(location) %>% mutate(row = row_number()) %>% select(location, new_cases, row) 


# Pegar maior numero de casos

result <- ocde_group %>% group_by(location) %>% filter(row == max(row))

ocde_group <- ocde_group  %>% filter(row<=min(result$row)) 


# pivota o data frame de long para wide

ocde_w <- ocde_group %>% pivot_wider(names_from = row, values_from = new_cases) 
%>% remove_rownames %>% column_to_rownames(var="location") 


## Atividade: Limpeza de dados

# Usando a base de dados anterior

ocde <- ocde %>% select(location, new_cases, new_deaths)


# Abrir pacote

library(funModeling) 

# Descricao

status(ocde) # Descrição dos dados numericamente
freq(ocde) # Frequencia
plot_num(ocde)+theme_bw() #Frequencia de casos novos e mortes

profiling_num(ocde)  # Estatistica descritiva das variaveis numericas

ocde %>% filter(new_cases < 0) # Selecionar abaixo de 0 que sao possiveis erros 

ocde <- ocde %>% filter(new_cases>=0) # Selcionar acima de 0



## Atividade: Validacao


# Instalar pacotes de dados

install.packages("validate")

library(validate)

## recriando a base:

# Pegar dados de Covid-19

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")


# Selecionar os casos
ocde_countries <- c("Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Czech Republic", "Denmark", 
                    "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", 
                    "Italy", "Japan", "Korea", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", 
                    "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", 
                    "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States")


# Filtrar os casos usando %in%
ocde <- general_data %>% filter(location %in% ocde_countries)


names(ocde)


#Selecionar apenas as variaveis localizacao, numero de casos e mortes

ocde <- ocde %>% select(location, new_cases, new_deaths)


# Criar o validador com novos casos acima ou igualde 0 e mortes acima ou igual a 0
cond_ocde <- validator(new_cases >= 0, new_deaths >= 0)

# Validar confrontando

validacao_ocde <- confront(ocde, cond_ocde)

# Resumo 
summary(validacao_ocde)

# Representacao grafica
plot(validacao_ocde)






