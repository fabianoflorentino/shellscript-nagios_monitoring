#!/bin/bash

LIST_LOG=`ls /db/backup/checklist/check_integrity_backup_red_* -trl|tail -1 |awk '{print $9}'`
CHECK_LOG=`cat $LIST_LOG`
TRAT_CHECK_LOG=$(echo $CHECK_LOG | awk '{print $2}')

if [ -z $TRAT_CHECK_LOG ]
        then
        echo "2 Check_Integrity_Redundancia - CHECAGEM DE INTEGRIDADE: ARQUIVO VAZIO "
        exit 2

        elif [ $TRAT_CHECK_LOG == 'OK' ]
        then
        echo "0 Check_Integrity_Redundancia - CHECAGEM DE INTEGRIDADE: `echo $CHECK_LOG`"
        exit 0

        else
        echo "2 Check_Integrity_Redundancia - CHECAGEM DE INTEGRIDADE: `echo $CHECK_LOG` "
        exit 2
fi

exit