# Programa de Pos Graduacao em Ciencia Politica - UFPE ##
## Data: 28 de abril de 2021 ##
## Eletiva de Analise de Dados - prof. Hugo Medeiros ## 
## Anderson Henrique da Silva ##

## Atividade: Staging Area


# Listar todos os objetos 

ls()

# Funçao para identificar a quantidade de armazenamento de dados

for (i in ls()){
  print(formatC(c(i, object.size(get(i))),
                format= 'd',
                width = 30),
        quote = F )
}


# Coletor de lixo para saber as informações dos bancos utilizados
gc()


# Remover os objetos que não usaremos deletando todos os objetos menos os selecionados


rm(list = c('sinistrosRecife2019mod', 'sinistrosRecife2019Raw',
            'sinistrosRecife2020Raw', 'sinistrosRecife2021Raw'))



#Identificar o tamanho dos objetos na área depois de removidos

for (i in ls()){
  print(formatC(c(i, object.size(get(i))),
                format= 'd',
                width = 30),
        quote = F )
}


# O objeto que estava com maior memória foram 'sinistrosRecife2019Raw' e 'sinistrosRecife2019mod'.


# Exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds")

# Exporta em formato tabular .csv
write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv")

