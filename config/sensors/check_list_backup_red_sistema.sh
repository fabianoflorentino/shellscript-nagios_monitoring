#!/bin/sh

DIR_BACKUP_RED="/mnt/backup_check"

QUANTIDADE_BACKUP=$(ls ${DIR_BACKUP_RED} | wc -l)
LISTAR=$(ls -tr ${DIR_BACKUP_RED} | grep sistema | tail -n 10 | xargs -d'\n')
BACKUP=$(find ${DIR_BACKUP_RED} -maxdepth 1 -name "s*.tar.z" -mtime -3 | wc -l)

if [ $BACKUP -ge 2 ]
then
    echo "0 List_Backup_Red_Sistema result=0;1;2;0;2 OK - Encontrados = $BACKUP --- ARQUIVOS  $LISTAR  "
    exit 0

elif [  $BACKUP -eq 1 ]
then
    echo "1 List_Backup_Red_Sistema result=1;1;2;0;2 WARN - Qde Backup Insuficiente = $BACKUP --- ARQUIVOS  $LISTAR "
    exit 1


elif [ $BACKUP -lt 1 ]
then
    echo "2 List_Backup_Red_Sistema result=2;1;2;0;2 CRITICAL - Nenhum Backup Encontrado."
    exit 2

else
    echo "3 List_Backup_Red_Sistema result=3;1;2;0;2 UNKNOWN - Erro ao tentar Encontrar backup"
    exit 3
fi