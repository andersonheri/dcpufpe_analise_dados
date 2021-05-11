# Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 10 de maio 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Web Scrapping


# arquivos html
install.packages("rvest")
install.packages("dplyr")

library(rvest)
library(dplyr)

# tabelas da wikipedia de Melhores filmes do Oscar
url <- "https://pt.wikipedia.org/wiki/Oscar_de_melhor_filme"


# Extrair o elemento 'table' que seráaextraido da pagina
urlTables <- url %>% read_html %>% html_nodes("table")

# identificar a posicao da tabela da pagina
urlTables

# Extrair o link da pagina
urlLinks <- url %>% read_html %>% html_nodes("link")


#Transformar em dataframe a tabela
filmesPremiados <- as.data.frame(html_table(urlTables[3]))


#Renomear as colunas com o primeiro nome da linha extraida, que sao os nomes das colunas
names(filmesPremiados) <- filmesPremiados[1,]


# Retirar a primeira linha
filmesPremiados <- filmesPremiados[-1,]

