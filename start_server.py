#!/usr/bin/env python3
"""
Servidor local para NODO - Pasarela Transfronteriza (Bolivia ↔ Internacional)
Abre automáticamente el navegador y sirve la aplicación interactiva.
"""

import http.server
import socketserver
import webbrowser
import os
import sys

PORT = 8000
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

def run():
    os.chdir(DIRECTORY)
    server_address = ("", PORT)
    
    # Intenta enlazar al puerto, si está ocupado prueba el siguiente
    port = PORT
    httpd = None
    while port < 8020:
        try:
            httpd = socketserver.TCPServer(("", port), Handler)
            break
        except OSError:
            port += 1
            
    if not httpd:
        print(f"Error: No se pudo enlazar ningún puerto entre {PORT} y 8020.")
        sys.exit(1)

    url = f"http://localhost:{port}/index.html"
    print("=" * 70)
    print("🚀 NODO | Pasarela Transfronteriza de Pagos & E-commerce")
    print(f"📡 Servidor activo en: {url}")
    print("💡 Presiona Ctrl + C para detener el servidor.")
    print("=" * 70)

    try:
        webbrowser.open(url)
    except Exception as e:
        print(f"Aviso: Abre manualmente tu navegador en {url}")

    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServidor detenido.")
        httpd.server_close()

if __name__ == "__main__":
    run()
