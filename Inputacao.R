#Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 7 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Imputacao


# Definir o caminho das bases

getwd()

# Abrir pacotes de dados
install.packages("Hmisc")
library(Hmisc) 
library(rio)


# Abrir banco de dados do QoG - Quality of Goverment da Universidade de Gotenburgo 

qog <- import ("qog_bas_cs_jan21.xlsx")


#Definir criterios para inputacao pela media e mediana para a variavavel 
# Political corruption index (vdem_corr)

qog$vdem_corr <- impute (qog$vdem_corr, fun = mean) 
qog$vdem_corr <- impute(qog$vdem_corr, fun = median) 

is.imputed(qog$vdem_corr) 

table(is.imputed(qog$vdem_corr))

# Analise dos valores imputados

summary(qog$vdem_corr)

# Escolha para elaborar a tendencia HOT DECK - para visualizacao

(qog$vdem_corr <- impute(qog$vdem_corr, "random")) 

summary(qog$vdem_corr)

