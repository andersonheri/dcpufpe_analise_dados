## Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 20 de junho de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Trabalhando com textos


# Carregando os pacotes

library(dplyr)
library(pdftools)
library(textreadr)
library(stringr)
install.packages("fuzzyjoin")
library(fuzzyjoin)

# Abrir banco

qog <- read.csv2('https://www.qogdata.pol.gu.se/data/qog_bas_ts_jan21.csv', 
          sep = ',', encoding = 'UTF-8')


vdem <- read.csv2('v_dem.csv', sep = ",", encoding = 'UTF-8')

# Selecionar um periodo do tempo

vdem_2000_2020 <- filter(vdem, year >= "2000")                       

gog_2000_2020 <- filter(qog, year >= "2000")

names(vdem_2000_2020)
names (gog_2000_2020)

# Selecionar apenas as variavies de interesse

vdem_sel <- select(vdem_2000_2020, "country_name", "country_text_id", "historical_date", "year", "histname")

qog_sel <- select(gog_2000_2020, "ccode", "year", "cname", "ccodealp", "ccodewb", "version")


names(qog_sel)[3] <- "country_name"


# juntar bases

dados_country <- fuzzyjoin::stringdist_join(vdem_sel, qog_sel, mode='left')

names(dados_country)


# buscar apenas uma elemento - Apenas o "Brasil"

dados_country <- dados_country %>% filter(country_text_id == 'BRA')




