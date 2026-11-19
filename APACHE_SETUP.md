# Guía de Configuración: Servidor Web Apache (HTTP Server)
### NODO - Pasarela de Pagos & E-commerce Transfronterizo

Esta aplicación web está completamente optimizada para ejecutarse sobre el servidor **Apache HTTP Server**, **XAMPP**, **WampServer**, **Laragon** o cualquier hosting Apache en producción.

---

## Opción A: Usando XAMPP (La opción más común en Windows)

1. Abre el **Panel de Control de XAMPP**.
2. Asegúrate de que el módulo **Apache** esté iniciado (botón *Start* en verde).
3. Copia o mueve la carpeta de este proyecto a la ruta pública de XAMPP:
   ```
   C:\xampp\htdocs\nodes\
   ```
4. Abre tu navegador web en:
   ```
   http://localhost/nodes/index.html
   ```

---

## Opción B: Ejecución Automática con `iniciar_apache.bat`

Hemos incluido un script por lotes [`iniciar_apache.bat`](file:///c:/Users/Neil%20Campos/Documents/Proyectos/Aplicaciones/Nodes/iniciar_apache.bat):
1. Haz doble clic en `iniciar_apache.bat`.
2. El script detectará si tienes instalado Apache en `C:\xampp`, `C:\Program Files\Apache Software Foundation` o `C:\wamp64`.
3. Si lo encuentra, iniciará el servicio y abrirá automáticamente tu navegador en `http://localhost/index.html`.
4. Si no tienes Apache instalado aún, te dará las instrucciones y abrirá el archivo directamente en el navegador con soporte completo.

---

## Opción C: Configuración de Virtual Host en Apache (`httpd-vhosts.conf`)

Si deseas que responda a un dominio local limpio como `http://nodo.local`:

1. Abre tu archivo `httpd-vhosts.conf` (en XAMPP suele estar en `C:\xampp\apache\conf\extra\httpd-vhosts.conf`).
2. Agrega el siguiente bloque (ya generado en [`apache-vhost.conf`](file:///c:/Users/Neil%20Campos/Documents/Proyectos/Aplicaciones/Nodes/apache-vhost.conf)):

```apache
<VirtualHost *:80>
    ServerAdmin admin@nodo.bo
    DocumentRoot "C:/Users/Neil Campos/Documents/Proyectos/Aplicaciones/Nodes"
    ServerName nodo.local
    ServerAlias www.nodo.local

    <Directory "C:/Users/Neil Campos/Documents/Proyectos/Aplicaciones/Nodes">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog "logs/nodo-error.log"
    CustomLog "logs/nodo-access.log" combined
</VirtualHost>
```

3. Abre el archivo de hosts de Windows (`C:\Windows\System32\drivers\etc\hosts`) como Administrador y agrega:
   ```
   127.0.0.1  nodo.local
   ```
4. Reinicia Apache y visita `http://nodo.local`.

---

## Archivo `.htaccess` Incluido

El proyecto ya contiene un archivo [`.htaccess`](file:///c:/Users/Neil%20Campos/Documents/Proyectos/Aplicaciones/Nodes/.htaccess) preconfigurado que:
- Habilita `mod_rewrite` para enrutamiento SPA sin recargas.
- Configura cabeceras de seguridad (`X-Frame-Options`, `X-Content-Type-Options`, `X-XSS-Protection`).
- Habilita CORS (`Access-Control-Allow-Origin: *`) para conectar con microservicios externos.
- Optimiza tipos MIME (`UTF-8`, SVG, JSON, JS).
- Activa compresión y directivas de expiración para carga ultra-rápida.
