##Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 23 de Maio de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##


## Atividade: Exercicio 2


# Definir pasta de salvamento

setwd("~/Documents/OneDrive/OneDrive - Universidade Federal de Pernambuco/UFPE/Doutorado/Analise de Dados/Bases_tratada")

# Instalar/Abrir pacotes

if(require(ff) == F) install.packages('ff'); require(ff)
if(require(ffbase) == F) install.packages('ffbase'); require(ffbase)
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(rvest) == F) install.packages('rvest'); require(rvest)
if(require(rio) == F) install.packages('rio'); require(rio)


## Atividade 1 - Carregar todas as bases do site


# Etapa 1 - Carregar todos os bancos de dados de resultados dos alunos do Recife de 2011 -2020

res20 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/9dc84eed-acdd-4132-9f1a-a64f7a71b016/download/situacaofinalalunos2020.csv")

res19 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/3b03a473-8b20-4df4-8628-bec55541789e/download/situacaofinalalunos2019.csv")

res18 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/8f3196b8-c21a-4c0d-968f-e2b265be4def/download/situacaofinalalunos2018.csv")

res17 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/70c4e6fc-91d2-4a73-b27a-0ad6bda1c84d/download/situacaofinalalunos2017.csv")

res16 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f42a3c64-b2d7-4e2f-91e5-684dcd0040b9/download/situacaofinalalunos2016.csv")

res15 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/264f0a37-ad1c-4308-9998-4f0bd3c6561f/download/situacaofinalalunos2015.csv")

res14 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/0a2aec2f-9634-4408-bbb4-37e1f9c74aa1/download/situacaofinalalunos2014.csv")

res13 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/95eb9ea8-cd75-4efa-a1ba-ba869f4e92b9/download/situacaofinalalunos2013.csv")

res12 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f6633c26-be36-4c27-81cb-e77d90316cff/download/situacaofinalalunos2012.csv")

res11 <- read.csv2.ffdf(file = "http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/9a694ab5-99ab-4ff1-ac6b-c97917c6a762/download/situacaofinalalunos2011.csv")


## Atividade 2 - Juntar todas as bases



res_aluno_rec <- ffdfrbind.fill(res20, res19, res18, res17, 
                                res16, res15, res14, res13, 
                                res12, res11, clone = TRUE)


# Checar as primeiras linhas do banco

head(res_aluno_rec)



## Atividade 3 - Salvar o banco de dados juntos nativo do .rds

saveRDS(res_aluno_rec, 'res_aluno_rec.rds')


## Atividade 4 - Limpar a Stage Area

rm(list=ls())

