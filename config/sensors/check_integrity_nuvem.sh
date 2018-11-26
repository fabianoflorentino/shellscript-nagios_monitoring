#!/bin/bash

DIR_BKP="/db/backup"
HOST_NUVEM="192.95.17.180"
USR_NUVEM=
PASSW_NUVEM=
HOME_NUVEM=/home/$USR_NUVEM
HORA_BKP_NUVEM=2200
LOCK=$(ps aux | grep  rsync | grep $HOST_NUVEM | head -1 | awk '{print $1}')
DIR_LOG="/db/backup/checklist"
DIR_SCRIPT="/db/backup/scripts"
FILE_EXT="z"

N1="OK - Backup mais recente encontra-se íntegro na nuvem."
N2="Falhas encontradas durante a transmissao do backup para nuvem"
N3="Arquivo de backup mais recente não encontrado no disco local"
N5="Arquivo de log nao encontrado.Realize uma transmissao!"
N6="Erro Desconhecido."

Status_Msg (){
        FILE=$(ls -lhtr $DIR_BKP | grep $HORA_BKP_NUVEM | grep backup_db | tail -1 | awk '{print $9}')
        FILE_SIZE_LOCAL=`du -hs $DIR_BKP/$FILE| awk '{print$1}'`
        FILE_SIZE_NUVEM=`sshpass -p $PASSW_NUVEM ssh -p2226 $HOST_NUVEM -l $USR_NUVEM du -hs $HOME_NUVEM/$FILE| awk '{print$1}'`
        N4=$(echo -e Ainda Enviando, ja enviado $FILE_SIZE_NUVEM do arquivo $FILE que possui $FILE_SIZE_LOCAL)
        MSG=$N4

}

Lock_Copy_Backup_Nuvem () {
if [ -z $LOCK ]; then
        RETORNO=0
else
        Status_Msg
        RETORNO=1
fi

}
Lock_Copy_Backup_Nuvem

Test_Return_Transmition () {

        /bin/bash $DIR_SCRIPT/copy_backup_nuvem.sh
        Lock_Copy_Backup_Nuvem
}

Test_Find_File () {

FIND_FILE_BACKUP=$(find $DIR_BKP -maxdepth 1 -type f -name "b*$HORA_BKP_NUVEM*.$FILE_EXT" -mtime -1 -print)
if [ -z $FIND_FILE_BACKUP ]
        then
        RETORNO=0
        else
        MSG=$N3
        RETORNO=2
fi

FIND_LOG_RSYNC=$(find $DIR_LOG/rsync.log -mtime -1)
if [ -z $FIND_LOG_RSYNC ]
        then
        MSG=$N5
        RETORNO=2
        Test_Return_Transmition

        else
        RETORNO=0
fi
}

Test_Find_File

Test_Error_File () {
STATUS=$(cat $FIND_LOG_RSYNC | grep -i "speedup" | wc -l)

if [ $STATUS -eq 0 ]
        then
        MSG=$N2
        RETORNO=2
        Test_Return_Transmition > /dev/null

        else
        RETORNO=0   
fi
}
Test_Error_File

case $RETORNO in
        0) echo -e "0 Check_Integrity_Backup_Nuvem result=0;1;2;0;2 $N1" && exit "$RETORNO";;
        1) echo -e "1 Check_Integrity_Backup_Nuvem result=1;1;2;0;2 $MSG" && exit "$RETORNO";;
        2) echo -e "2 Check_Integrity_Backup_Nuvem result=2;1;2;0;2 $MSG" && exit "$RETORNO";;
        *) echo -e "3 Check_Integrity_Backup_Nuvem result=3;1;2;0;2 $N6" && exit "$RETORNO";;
esac