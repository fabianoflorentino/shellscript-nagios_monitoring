#!/bin/bash
BASE=
SIZE_MINIMUM_BACKUP='2642723'
BACKUP_OLD=
cd $BACKUP_OLD
SIZE_BACKUP=`ls b*.tar.z -trl|tail -1|awk '{print $9}'`
DU_SIZE_BACKUP=`du $SIZE_BACKUP`
COMPARA_BACKUP=`echo $DU_SIZE_BACKUP |awk '{print $1}'`

if [ -z $COMPARA_BACKUP ]
        then
        echo "2 Check_Size_Backup_"$BASE" result=2;1;2;0;2 CRITICAL - CHECK SIZE BACKUP: ARQUIVO VAZIO."
        exit 2

        elif [ $COMPARA_BACKUP -gt $SIZE_MINIMUM_BACKUP ]
        then
        echo "0 Check_Size_Backup_"$BASE" result=0;1;2;0;2 CHECK SIZE BACKUP OK: `echo $DU_SIZE_BACKUP` "
        exit 0

        else
        echo "2 Check_Size_Backup_"$BASE" result=2;1;2;0;2 CRITICAL - CHECK SIZE BACKUP FAIL: `echo $DU_SIZE_BACKUP`"
        exit 2
fi

exit