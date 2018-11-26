#!/bin/bash

# VARIAVEIS
BASE=
ORAENV_ASK=NO
OMD_USER=`cat /etc/passwd |grep OMD | cut -c1-3`

export NLS_LANG=american_america.AL32UTF8
export NLS_DATE_FORMAT=DD.MM.YYYY-HH24:MI:SS
export `cat /omd/sites/$OMD_USER/.profile |grep ORACLE_SID | sed 's/export //g'`
export `cat /omd/sites/$OMD_USER/.profile |grep ORACLE_HOME | sed 's/export //g'`

# CODIGO ORACLE
LOG_PRIMARY=`$ORACLE_HOME/bin/sqlplus -silent omd/omdspring@${BASE} <<EOF
col STATUS format a9
col hrs format 999.99
select
SESSION_KEY, INPUT_TYPE, STATUS,
to_char(START_TIME,'dd/mm/yyyy hh24:mi') start_time,
to_char(END_TIME,'dd/mm/yyyy hh24:mi')   end_time,
elapsed_seconds/3600                   hrs
from V\\$RMAN_BACKUP_JOB_DETAILS
where input_type='DB FULL'
and start_time > sysdate-1
order by session_key;
EOF`

DATE_RMAN=`$ORACLE_HOME/bin/sqlplus -silent omd/omdspring@${BASE} <<EOF
select to_char(START_TIME,'dd/mm/yyyy') start_time
from V\\$RMAN_BACKUP_JOB_DETAILS
where input_type='DB FULL'
and start_time > sysdate-1
and session_recid = (select max(session_recid) from V\\$RMAN_BACKUP_JOB_DETAILS where input_type='DB FULL')
order by session_recid;
EOF`

SYSDATE=`$ORACLE_HOME/bin/sqlplus -silent omd/omdspring@${BASE} <<EOF
select to_char(SYSDATE,'dd/mm/yyyy') from dual;
EOF`

# CODIGO SO

TRAT_LOG_PRIMARY=`echo "$LOG_PRIMARY" | sed 's/-//g' | sed 's/START_TIME//g' | sed 's/SESSION_KEY//g' | sed 's/INPUT_TYPE//g' | sed 's/STATUS//g' | sed 's/END_TIME//g' | sed 's/HRS//g'`

TRAT_DATE_RMAN=`echo "$DATE_RMAN" | sed 's/-//g' | sed 's/START_TIME//g' | sed 's/no rows selected//g' | cut -d" " -f2`
TRAT_SYSDATE=`echo "$SYSDATE"  | sed 's/TO_CHAR(SYSDATE,//g' | sed 's/-//g' | sed 's/DD//g' | sed 's/MM//g' | sed 's/YYYY//g' | cut -d"'" -f4`

if [ -z $TRAT_DATE_RMAN ]
        then
        echo "2 Check_Rman_Full_${BASE} - BACKUP RMAN COM FALHAS OU INEXISTENTE"
        exit 2
	
	elif [ $TRAT_DATE_RMAN == $TRAT_SYSDATE ]
	then
        echo "0 Check_Rman_Full_${BASE} - `echo $TRAT_LOG_PRIMARY`"
        exit 0

	else
        echo "1 Check_Rman_Full_${BASE} - `echo $TRAT_LOG_PRIMARY` "
        exit 1	
	
fi

exit
