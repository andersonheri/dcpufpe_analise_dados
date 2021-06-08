##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 31 de maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Data table

# Carregando pacotes
library(data.table)
library(dplyr)

general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")


# Selecionar os casos
ocde_countries <- c("Austria", "Australia", "Belgium", "Canada", "Chile", "Colombia", "Czech Republic", "Denmark", 
                    "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel", 
                    "Italy", "Japan", "Korea", "Latvia", "Lithuania", "Luxembourg", "Mexico", "Netherlands", 
                    "New Zealand", "Norway", "Poland", "Portugal", "Slovak Republic", "Slovenia", "Spain", 
                    "Sweden", "Switzerland", "Turkey", "United Kingdom", "United States")


# Filtrar os casos usando %in%
ocde <- general_data %>% filter(location %in% ocde_countries)


# Criar uma variável dummy de Ano 2020

ocde$year_2020 <- ifelse (ocde$date < "2020-12-31", 1, 0)

table(ocde$year_2020)


# Criando uma label para essa variavel

recode <- c(Ano_1 = 1, Ano_2 = 0)
ocde$year_period <- factor(ocde$year_2020, levels = recode, labels = names(recode))

# variáveis para a regressao linear

class(ocde$total_deaths_per_million) #VD
class(ocde$new_cases_per_million) #VI
class(ocde$human_development_index) #VI
class(ocde$people_fully_vaccinated) #VI

# Transformando o banco pro formato data.table
ocdedt <- ocde %>% setDT()


# aplicar a regressao linear
ocdedt[ , lm(formula = ocde$total_deaths_per_million ~ ocde$new_cases_per_million
             + ocde$human_development_index + ocde$people_fully_vaccinated)]


