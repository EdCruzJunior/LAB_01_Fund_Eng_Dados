import pandas as pd

df1 = pd.read_csv("acidentes_2022.csv")
df2 = pd.read_csv("acidentes_2023.csv")
df3 = pd.read_csv("acidentes_2024.csv")
df4 = pd.read_csv("acidentes_2025.csv")
df5 = pd.read_csv("acidentes_2026.csv")

df = pd.concat([df1, df2, df3, df4, df5])

df.to_csv("acidentes_rodovias.csv", index=False)