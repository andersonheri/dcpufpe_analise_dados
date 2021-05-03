# Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 28 de abril de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##

## Atividade: leitura

##########

# Instalar pacote de dados 'Microbenchmark' e 'Mess'


install.packages("microbenchmark")
install.packages("MESS")
install.packages("yaml")
XML


#Abrir pacotes
library(microbenchmark)
library(MESS)

# carrega base de dados em formato nativo R
sinistrosRecife <- readRDS('sinistrosRecife.rds')

# carrega base de dados em formato .csv para leitura em outros programas
sinistrosRecife <- read.csv2('sinistrosRecife.csv', sep = ';')

# Comparar em formato .xml
write.xml(sinistrosRecife, file = 'sinistrosRecife.xml')

# Comparar os tres processos

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds"), 
               b <- write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv"), 
               c <- write.xml(sinistrosRecife, file = 'sinistrosRecife.xml'), times = 10L)


microbenchmark(a <- readRDS('sinistrosRecife.rds'),
               b <- read.csv2('sinistrosRecife.csv', sep = ';'), 
               c <- read.xml('sinistrosRecife.xml'), times = 10L)
