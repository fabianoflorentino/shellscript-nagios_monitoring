#!/bin/bash
BASE=

# VARIAVEIS
ORAENV_ASK=NO
OMD_USER=`cat /etc/passwd |grep OMD | cut -c1-3`

export NLS_LANG=american_america.AL32UTF8
export NLS_DATE_FORMAT=DD.MM.YYYY-HH24:MI:SS
export `cat /omd/sites/$OMD_USER/.profile |grep ORACLE_SID | sed 's/export //g'`
export `cat /omd/sites/$OMD_USER/.profile |grep ORACLE_HOME | sed 's/export //g'`

# CODIGO ORACLE

VERSION=`$ORACLE_HOME/bin/sqlplus -silent omd/omdspring@${BASE} <<EOF
select * from v\\$version;
EOF`

# CODIGO SO

TRAT_VERSION=`echo $VERSION | sed 's/-//g' | sed 's/BANNER//g'`

if [ 0 == 0 ]
    then
    echo "0 Check_Version result=0;1;2;0;2 INFO: `echo $TRAT_VERSION` "
    exit 0
fi

exit
