Webclone

Descarga sitios web con automatización de wget.
Created by: F@br1x and 你好😜

Pasos de Instalación

Actualizamos Repositorios:

apt update && apt upgrade -y

Instalamos los requisitos:

apt install git wget pv -y

Clonamos el repositorio:


git clone https://github.com/Fabr1x/Webclone

Entramos al directorio:

cd Webclone

Listamos:

ls

Damos permisos de ejecución:

chmod +x webclone.sh

Ejecutamos el script

./webclone.sh

Modo de uso:

Uso: ./webclone.sh <enlace web> [compress 0|1] [verbose 0|1]

Ejemplos:

Ejemplo: ./webclone.sh 'https://m.facebook.com/login/?next&ref=dbl&fl&refid=8' 1 1

or

Ejemplo: ./webclone.sh 'https://facebook.com'


Created by: F@br1x and 你好😜
