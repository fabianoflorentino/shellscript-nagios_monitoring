#!/usr/bin/env bash

DIR=
QUANTIDADE_BACKUP=$(ls   $DIR/sistema* | wc -l)
LISTAR=$(ls -tr $DIR/  | grep sistema| tail -n 10 | xargs -d"\n"  )

BACKUP_RED=$(find $DIR -name "s*.tar.z" -mtime -2 | wc -l)

if [ $BACKUP_RED  -ge  2 ]
then
    echo "0 Sistema_Backup_Disco = $QUANTIDADE_BACKUP --- ARQUIVOS  $LISTAR  "
    exit 0

elif [  $QUANTIDADE_BACKUP -eq  1 ]
then
    echo "1 Sistema_Backup_Disco = $QUANTIDADE_BACKUP --- ARQUIVOS  $LISTAR "
    exit 1

elif [ $QUANTIDADE_BACKUP -lt 1 ]
then

    echo "2 Sistema_Backup_Disco = $QUANTIDADE_BACKUP --- ARQUIVOS  $LISTAR"
    exit 2

else
    echo "3 Sistema_Backup_Disco - Erro ao tentar Encontrar backup"
    exit 3
fi

exit