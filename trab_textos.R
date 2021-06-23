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

## Carregar arquivo

emenda <- read_pdf("emenda_projeto.pdf", ocr = T)


# Juntar os elementos em apenas um arquivo

emenda <- emenda %>%
  group_by(element_id) %>%
  mutate(all_text = paste(text, collapse = " | ")) %>%
  select(element_id, all_text) %>%
  unique()



# Elaborar banco de dados

data <- str_extract_all(emenda$all_text, "\\d{2}/\\d{2}")

View(data)

# identificar a mudança
emenda_data <- gsub("02/02", "02-02", emenda$all_text)

# Subsituir 

emenda_data <- str_replace_all(string = emenda_data, pattern = "/", replacement = "-") 

View(emenda_data)
