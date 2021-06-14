##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 7 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Outliers


# Definir o caminho das bases

getwd()

# Abrir pacotes de dados
install.packages("plotly")
library(dplyr)
library(data.table)
library(plotly)
library(rio)


# Abrir banco de dados do QoG - Quality of Goverment da Universidade de Gotenburgo 


qog <- import ("qog_bas_cs_jan21.xlsx")

# Identificar nomes das variáveis

names(qog)

# Fazer a analise do Indice de Felicidade no Mundo (World Happiness Index) 
summary(qog$whr_hap)


## transformando e acrescentando estruturas na base: 

# Analise da variavel ˜whr_hap˜

qog_mod <- qog %>% mutate(hap_2 = sqrt(whr_hap), hap_Log = log10(whr_hap))


# Plotar as variaveis 

plot_ly(y = qog$whr_hap, type = "box", text = qog$cname, boxpoints = "all", jitter = 0.3)


#Identificar valores máximos e minimos da variável felicidade

lower_bound <- median(qog$whr_hap) - 3 * mad(qog$whr_hap, constant = 1)
upper_bound <- median(qog$whr_hap) + 3 * mad(qog$whr_hap, constant = 1)
(outlier_ind <- which(qog$whr_hap < lower_bound | qog$whr_hap > upper_bound))

# buscando em outras variáveis ajustadas:

plot_ly(y = qog$hap_2, type = "box", text = qog$cname, boxpoints = "all", jitter = 0.3)

plot_ly(y = qog$hap_Log, type = "box", text = qog$cname, boxpoints = "all", jitter = 0.3)







