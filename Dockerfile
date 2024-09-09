# Utiliza una imagen base de Amazon Linux 2 compatible con EKS
FROM amazonlinux:2

# Instalar Apache, PHP y las extensiones necesarias
RUN yum update -y && \
    yum install -y httpd php php-mysqlnd wget unzip

# Crear un directorio temporal para descargar el archivo .zip
WORKDIR /tmp

# Descargar el archivo .zip desde GitHub
RUN wget https://github.com/halcon2025/stress/raw/main/lab-app2.zip -O lab-app2.zip

# Descomprimir el archivo y mover el contenido al directorio de Apache
RUN unzip lab-app2.zip && \
    cp -r * /var/www/html/ && \
    rm lab-app2.zip

# Cambiar permisos para que Apache pueda acceder a los archivos
RUN chown -R apache:apache /var/www/html/

# Exponer el puerto 80 para el tráfico web
EXPOSE 80

# Iniciar Apache cuando el contenedor se ejecute
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
