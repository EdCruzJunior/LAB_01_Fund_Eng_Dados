import pandas as pd
import matplotlib.pyplot as plt

# carregar dataset
df = pd.read_csv("acidentes_rodovias.csv")

# visualizar primeiras linhas
print(df.head())


# Contagem de Valores Nulos Identifica dados faltantes no dataset.
nulos = df.isnull().sum()
print(nulos)

#Gerar gráfico dos valores Nulos
plt.figure()

nulos.plot(kind="bar")

plt.title("Contagem de Valores Nulos por Coluna")
plt.xlabel("Colunas")
plt.ylabel("Quantidade de Nulos")

plt.xticks(rotation=85)

plt.tight_layout()
plt.show()

#Identificar os tipos das colunas
tipos_colunas = df.dtypes

print(tipos_colunas)

#Gerar gráfico da identificação dos tipos das colunas object → colunas de texto int64 → números inteiros float64 → números decimais

tipos_resumo = df.dtypes.value_counts()

print(tipos_resumo)

#Gráfico dos Tipos de Dados

plt.figure()

tipos_resumo.plot(kind="bar")

plt.title("Distribuição dos Tipos de Dados")
plt.xlabel("Tipo de Coluna")
plt.ylabel("Quantidade")

plt.tight_layout()
plt.show()

#Gerar Estatísticas Descritivas
estatisticas = df.describe()

print(estatisticas)

#Gráfico de Média e Desvio Padrão

estatisticas = df[['VITIMA_LEVE','VITIMA_GRAVE']].agg(['mean','std'])

plt.figure()

estatisticas.T.plot(kind='bar')

plt.title("Média e Desvio Padrão")
plt.xlabel("Variáveis")
plt.ylabel("Valores")

plt.tight_layout()
plt.show()

#Gráfico de Estatísticas Descritivas

estatisticas = df[['VITIMA_LEVE','VITIMA_GRAVE']].describe()

plt.figure()

estatisticas.loc[['mean','std','min','max']].T.plot(kind='bar')

plt.title("Estatísticas Descritivas")
plt.xlabel("Variáveis")
plt.ylabel("Valores")

plt.tight_layout()
plt.show()

#Identificar Outliers

plt.figure()

df[['VITIMA_LEVE','VITIMA_GRAVE']].plot(kind='box')

plt.title("Distribuição de Mortos e Feridos")

plt.tight_layout()
plt.show()

#Limpeza de Dados – Tratamento de Valores Ausentes
#Identificar valores ausentes
#Primeiro verificamos quantos valores nulos existem em cada coluna.

nulos = df.isnull().sum()

print(nulos)


#Imputação de valores ausentes
#A imputação consiste em preencher valores faltantes.
#Preencher valores numéricos com média

df['LATITUDE'] = df['LATITUDE'].fillna(df['LATITUDE'].mean())
df['LONGITUDE'] = df['LONGITUDE'].fillna(df['LONGITUDE'].mean())

#Padronizar nomes automaticamente ( Snake_Case )

df.columns = (
    df.columns
    .str.strip()          # remove espaços extras
    .str.lower()          # converte para minúsculas
    .str.replace(" ", "_") # substitui espaço por _
)

print(df.columns)

#Tratar caracteres especiais - Se existirem caracteres como /, -, (), pode-se usar: Isso remove:
#acentos símbolos caracteres especiais

df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("[^a-z0-9_]", "", regex=True)
)

#Salvar dataset em formato Parquet na pasta data/silver Garantir que o diretório existe

import os

os.makedirs("data/silver", exist_ok=True)

# criar pasta silver
os.makedirs("data/silver", exist_ok=True)

# salvar parquet
df.to_parquet(
    "data/silver/acidentes_rodovias.parquet",
    index=False
)

print("Arquivo salvo em data/silver/acidentes_rodovias.parquet")