#!/bin/bash
clear
set -u
#colores
v='\e[1;32m'
n='\e[1;30m'
c='\e[1;36m'
r='\e[1;31m'
am='\e[1;33m'
b='\e[1;37m'
d='\e[0m'

banner(){
	printf "${b}"
	figlet -t W3b
	sleep 1
	printf "${v}"
	figlet -t Clon3
	sleep 1
	printf "${n}Created by: ${c}F@br1x ${n}and ${c}JH1 ${d}"|pv -qL 12
	printf "\033[3;39mGrupo de telegram:\033[1;36m https://t.me/DarkJsociety"|pv -qL 12
	sleep 1
	echo ""
	echo ""
}
banner
uso_script="${b}Uso: ./webclone.sh ${v}<enlace web> ${b}[compress 0|1] [verbose 0|1]${d}"
ejemplo_uso="${b}Ejemplo: ./webclone.sh ${v}'https://m.facebook.com/login/?next&ref=dbl&fl&refid=8'${b} 1 1${d}"

echo
 
descargar() {
    url=$1
    compress=$2
    if [ $3 -eq 1 ]; then
        verbose=""
    else
        verbose="--quiet"
    fi
    domain=$(echo "$url" | sed 's/https\?:\/\///')
    #domain=$(echo "$domain" | sed 's/www\.//g')
    uri="${domain#*\/|*}"
    domain="${domain%%\/*}"
    params="${uri#*\?}"
    uri=$(echo "$uri" | sed "s/\?$params//g")
    uri=$(echo "$uri" | sed "s/$domain//g")
    params=$(echo "$params" | sed "s!$domain/!!g")
    params=$(echo "$params" | sed "s!$domain!!g")
    website=$(echo "$url" | sed "s!$uri?$params!!g")
         
    echo -e "${n}-Enlace: ${am}$url"|pv -qL 15
    sleep 0.5
    echo -e "${n}-Sitio: ${am}$website"|pv -qL 15
    sleep 0.5
    echo -e "${n}-Dominio: ${am}$domain"|pv -qL 15
    sleep 0.5
    echo -e "${n}-URI: ${am}$uri"|pv -qL 15
    sleep 0.5
    echo -e "${n}-Parametros: ${am}$params"|pv -qL 15
    sleep 0.5
    echo
 
    #Analizando web
    if [ "$params" != "" ]; then
        echo -e "${b}-Analizando sitio web..."|pv -qL 15
	sleep 1
        wget ${website}${uri} $verbose --post-data "$params" --save-cookies $domain.cookie --no-check-certificate -O - > /dev/null
        if [ ${PIPESTATUS[0]} -eq 0 ]; then
            echo -e "${b}-Guardando cookies ${am}($domain.cookie)${d}"|pv -qL 15
	    sleep 1
        else
            echo -e "${r}-Error de cookies${d}"|pv -qL15
	    sleep 1
            if [ -f $domain.cookie ]; then
                rm $domain.cookie
            fi
            exit 1
        fi
    fi
     
    #Descarga
    echo -e "${am}Descargando sitio web..."|pv -qL 15
    sleep 1
    if [ "$params" != "" ]; then
        wget -rkcp -e robots=off -U Mozilla --limit-rate=80K --random-wait --domains $domain --html-extension $domain $verbose
    else
        wget -rkcp -e robots=off -U Mozilla --limit-rate=80K --random-wait --load-cookies $domain.cookie --domains $domain --html-extension $domain $verbose
    fi
     
    if [ ${PIPESTATUS[0]} -eq 0 ]; then
        echo -e "${v}Descargado correctamente!!"|pv -qL 15
	sleep 1
    else
	    echo -e "${r}Error de descarga ):"|pv -qL 15
	    sleep 1
        exit 2
    fi
     
    #Comprension
    if [ $compress -eq 1 ]; then
        echo -e "${v}Comprimiendo sitio web..."|pv -qL 15
	sleep 1
        tar -czvf $domain.tgz $domain/*
        if [ ${PIPESTATUS[0]} -eq 0 ]; then
            echo -e "${b}Descomprimiendo ${c}($domain.tgz)"|pv -qL 15
	    sleep 1
            if [ -f $domain.cookie ]; then
                rm $domain.cookie
            fi
            rm -r $domain
        else
		echo -e "${r}Error no se clonó el sitio web ):"|pv -qL 15
		sleep 1
            exit 3
        fi
    fi
     
    echo -e "${c}Sitio web clonado correctamente${d}"|pv -qL 15
    sleep 1
}
 
#Analizando parametros
if [ $# -eq 1 ]; then
    descargar $1 0 0
elif [ $# -eq 2 ]; then
    descargar $1 $2 0
elif [ $# -eq 3 ]; then
    descargar $1 $2 $3
else
    echo -e "${uso_script}"|pv -qL 15
    sleep 1
    echo
    echo -e "${ejemplo_uso}"|pv -qL 15
    sleep 1
    exit 1
fi
