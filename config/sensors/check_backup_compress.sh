#!/bin/bash

# Programa..: check_bkp.sh
# Objetivo..: checar se os servidores ORACLE realizaram backup e compressao com sucesso.
# Parametro.: 1 ou 2 (1=backup,2=compressao)
# Versao....: v3.0a - 13/10/2012.
# Criado por: Patricia Cruz - 2Com
BASE=
tipo=$1   # 1=Backup, 2=Compressao Backup
tipo=2
retorno=2 # Critico
flog="N"

#flog=S - arquivo de LOG NAO ENCONTRADO conforme data/hora atual e horario de backup
#flog=N - arquivo de LOG ENCONTRADO conforme data/hora atual e horario de backup
#------------------------------

STATUS=0
DATA=`date +%d"-"%m"-"%Y`
DIR='/db/backup/checklist'

if [ $tipo -eq 1 ];then

   PREFIX='export_'

else

   PREFIX='compress_'

fi

cd $DIR

LOG=`ls -Frt $PREFIX*.log | tail -n1 `

if [ -z $LOG ] ; then
    #Critico
    retorno=2
    #   echo "CRITICAL - Log nao encontrado"
    echo "$retorno Oracle_Backup_Compress_${BASE} result=2;1;2;0;2  CRITICAL - Log nao encontrado"
    exit $retorno
fi

#Escolher uma das opcoes abaixo para definir a data do LOG Backup.
#Opcao1: verifica pela data do arqvivo
#xbkp=`ls -lha --time-style=full-iso $LOG | awk '{print $6" "$7x}' | cut -d"." -f1`
#Opcao2: verifica pelo nome do arquivo
xdt=`echo $LOG | cut -d"_" -f2 | awk 'BEGIN {FS="-"} {print $3"-"$2"-"$1}' `
xhr=`echo $LOG | cut -d"-" -f4 | cut -d"." -f1 | awk '{print substr($1,1,2)":"substr($1,3,2)":"substr($1,5,2) }'  `

xbkp=`echo $xdt $xhr`

#xbkp="2012-09-16 12:45:00"
dtbkp=`date --date="$xbkp" +%s`
bkp=("12:00:00" "22:00:00" "23:59:59")
hoje=$(date "+%Y-%m-%d")
ontem=$(date -d'-1 day' "+%Y-%m-%d")
atual=$(date "+%Y-%m-%d %H:%M:%S")
dtatual=`date --date="$atual" +%s`
ant=`echo  $ontem  ${bkp[   $(( ${#bkp[*]} - 2 ))  ]}`
dtant=`date --date="$ant" +%s`

#Para DEBUG:__________________________________
#echo "Hoje          "$hoje
#echo "Ontem         "$ontem
#echo "Data Bkp      "$xbkp $dtbkp
#echo "Data Atual    "$atual $dtatual
#echo "Data Anterior "$ant $dtant
#echo " "
#echo "Data Atual " $dtatual
#echo "Data Bkp   " $dtbkp
#echo " "
#echo "Horarios Backup"
#____________________________________________

#Data atual x horarios backup - identifica faixa [ limite inferior (linf) a limite superior (lsup) ]
for ((  i = 0 ;  i <  $(( ${#bkp[*]} )) ;  i++  ))
do
    dt2=`echo $hoje" " ${bkp[ $i ]}`
    t2=`date --date="$dt2" +%s`
    lsup=$t2

    if [ $i -eq 0 ];then

        linf=$dtant

    else

        j=${#bkp[*]}
        y=`echo "${bkp[ $(( $i - 1 )) ]}"`
        dt1=`echo $hoje" " $y`
        t1=`date --date="$dt1" +%s`
        linf=$t1
    fi

    if [ $dtatual -ge $linf  ];then

        if [  $dtatual -lt $lsup ];then
        #  echo $dt2 $linf $lsup
            break
        fi
    fi
done

# Data backup x faixa backup identificada (linf - lsup)
if [ $dtbkp -ge $linf  ];then

    if [  $dtbkp -lt $lsup ];then
        flog="S" # arquivo de LOG ENCONTRADO conforme data/hora atual e horario de backup
    fi
fi

#Para DEBUG:__________________________________
#echo Apurando saida
#echo "Data Bkp      "$xbkp $dtbkp
#echo "Faixa         "$linf $lsup
#echo " "
#____________________________________________

if [ $flog == "S" ];then

    #  echo "LOG ENCONTRADO"
    RESULTADO=`tail -n1 $LOG`
    STATUS=`echo $RESULTADO | egrep  -w "sucesso|successfully" | wc -l`

    if [ $STATUS -eq 0 ]; then
        #Critico
        retorno=2

        if [ $tipo -eq 1 ]; then

            echo "$retorno Oracle_Backup_Compress_${BASE} result=2;1;2;0;2 CRITICAL - Backup falhou - $LOG "-" $RESULTADO"

        else

            echo "$retorno Oracle_Backup_Compress_${BASE} result=2;1;2;0;2 CRITICAL - Compressao falhou - $LOG "-" $RESULTADO"
        fi
    else
        #OK
        retorno=0

        if [ $tipo -eq 1 ]; then

            echo "$retorno Oracle_Backup_Compress_${BASE} result=0;1;2;0;2 OK - Backup - $LOG "-" $RESULTADO"
        else

            echo "$retorno Oracle_Backup_Compress_${BASE} result=0;1;2;0;2 OK - Compressao - $LOG "-" $RESULTADO"
        fi
    fi

else

    #warning
    retorno=1
    echo "$retorno Oracle_Backup_Compress_${BASE} result=1;1;2;0;2 WARN - Log encontrado fora da faixa de backup: $LOG"

fi

exit $retorno
