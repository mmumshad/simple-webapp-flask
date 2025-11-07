"""Módulo principal da aplicação Flask.
Este arquivo inicializa o servidor e define as rotas principais.
"""

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    """Rota principal da aplicação.
    Retorna uma mensagem simples para o usuário.
    """
    return "Hello, World!"

def main():
    """Função principal responsável por iniciar o servidor Flask."""
    app.run(host='0.0.0.0', port=8080)
