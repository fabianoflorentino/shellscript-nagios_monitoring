#!/usr/bin/env bash

SIZE_MINIMUM_BACKUP='36046767'
BACKUP_OLD="/db/backup/backup_old"

cd $BACKUP_OLD
SIZE_BACKUP=`ls sistema*.tar.z -trl|tail -1|awk '{print $9}'`
DU_SIZE_BACKUP=`du --max-depth=1 $SIZE_BACKUP`
COMPARA_BACKUP=`echo $DU_SIZE_BACKUP |awk '{print $1}'`

if [ -z $COMPARA_BACKUP ]
then
    echo "2 Check_Size_Backup_Sistema - CHECK SIZE BACKUP: ARQUIVO VAZIO "
    exit 2

elif [ $COMPARA_BACKUP -gt $SIZE_MINIMUM_BACKUP ]
then
    echo "0 Check_Size_Backup_Sistema - CHECK SIZE BACKUP OK: `echo $DU_SIZE_BACKUP`"
    exit 0

else
    echo "2 Check_Size_Backup_Sistema - CHECK SIZE BACKUP FAIL: `echo $DU_SIZE_BACKUP` "
    exit 2
fi

exit