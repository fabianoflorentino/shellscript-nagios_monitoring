#!/usr/bin/env bash

BASE=
USR_NUVEM=
PASSW_NUVEM=
IP_BKP_NUVEM="192.95.17.180"
SSH_OPT="-o GSSAPIAuthentication=no -o StrictHostKeyChecking=no"


QUANTIDADE_BACKUP=$(sshpass -p "${PASSW_NUVEM}" ssh ${SSH_OPT} -p 2226 ${IP_BKP_NUVEM} \
-l ${USR_NUVEM} "ls /home/${USR_NUVEM} |grep \"^backup_db*\"| wc -l")

LISTAR=$(sshpass -p "${PASSW_NUVEM}" ssh ${SSH_OPT} -p 2226 ${IP_BKP_NUVEM} \
-l ${USR_NUVEM} "ls -tr /home/${USR_NUVEM} |grep \"^backup_db*\" |tail -n 10 |xargs -d\"\n\"")

BACKUP=$(sshpass -p "${PASSW_NUVEM}" ssh ${SSH_OPT} -p 2226 ${IP_BKP_NUVEM} \
-l ${USR_NUVEM} "find /home/${USR_NUVEM} -iname 'backup_db*' -mtime -3 | wc -l")


if [ ${BACKUP} -ge 2 ]
then
    echo "0 List_Backup_Nuvem_"${BASE}" result=0;1;2;0;2 OK - Encontrados = ${BACKUP} --- ARQUIVOS  ${LISTAR}  "
    exit 0

elif [  ${BACKUP} -eq 1 ]
then
    echo "1 List_Backup_Nuvem_"${BASE}" result=1;1;2;0;2 WARN - Qde Backup Insuficiente =${BACKUP} --- ARQUIVOS  ${LISTAR} "
    exit 1

elif [ ${BACKUP} -lt 1 ]
then
    echo "2 List_Backup_Nuvem_"${BASE}" result=2;1;2;0;2 CRITICAL - Nenhum Backup Encontrado."
    exit 2

else
    echo "3 List_Backup_Nuvem_"${BASE}" result=3;1;2;0;2 UNKNOWN - Erro ao tentar Encontrar backup"
    exit 3
fi