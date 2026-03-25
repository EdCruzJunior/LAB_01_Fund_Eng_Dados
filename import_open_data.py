#!/usr/bin/env python3
"""
Script para importar arquivo de dados abertos de um site externo.
Baixa o arquivo e salva localmente, opcionalmente carrega com pandas.
"""

import argparse
import requests
import pandas as pd
import os

def download_file(url, output_path):
    """
    Baixa o arquivo da URL e salva no caminho especificado.
    """
    try:
        response = requests.get(url)
        response.raise_for_status()  # Verifica se houve erro na requisição
        with open(output_path, 'wb') as f:
            f.write(response.content)
        print(f"Arquivo baixado com sucesso: {output_path}")
    except requests.exceptions.RequestException as e:
        print(f"Erro ao baixar o arquivo: {e}")
        return False
    return True

def load_and_preview(file_path):
    """
    Carrega o arquivo com pandas e mostra uma prévia.
    Assume que é um CSV; ajuste se necessário.
    """
    try:
        df = pd.read_csv(file_path)
        print("Prévia dos dados:")
        print(df.head())
        print(f"\nShape: {df.shape}")
    except Exception as e:
        print(f"Erro ao carregar os dados: {e}")

def main():
    parser = argparse.ArgumentParser(description="Importar arquivo de dados abertos de um site externo.")
    parser.add_argument('--url', type=str, default='https://dadosabertos.artesp.sp.gov.br/dataset/5e3af2a0-3b6a-4ee6-8556-b59b5d813ffc/resource/5538779f-fc38-4909-82ce-219ccfd83174/download/acidentes_2026.csv',
                        help='URL do arquivo a ser baixado (padrão: dados Acidentes da ARTESP)')
    parser.add_argument('--output', type=str, default='acidentes_2026.csv',
                        help='Caminho para salvar o arquivo (padrão: dados_abertos.csv)')
    parser.add_argument('--preview', action='store_true',
                        help='Carregar e mostrar prévia dos dados com pandas')

    args = parser.parse_args()

    # Baixar o arquivo
    if download_file(args.url, args.output):
        # Se solicitado, carregar e pré-visualizar
        if args.preview:
            load_and_preview(args.output)

if __name__ == "__main__":
    main()