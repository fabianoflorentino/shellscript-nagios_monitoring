#!/usr/bin/env bash

# Habilita quais sensores serão criados.
BKP_BANCO_LOCAL="True"
CHECK_RMAN="True"

# Insira o nome das bases em forma de lista.
BASES="" 

# Diretório onde estão o sensores para serem copiados.
DIR_SENSORES="../config/sensors"

# Diretório destino onde os sensores serão criados.
CHECK_MK_DIR_PLG="/tmp" 


for BASE in ${BASES[@]}; do

    if [ "${BKP_BANCO_LOCAL}" == "True" ]
    then
        # check_backup_compress.sh
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_backup_compress.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_backup_compress_${BASE}.sh"

        # check_backup_export.sh
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_backup_export.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_backup_export_${BASE}.sh"

        # check_list_backup_local
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_list_backup_local.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_list_backup_local_${BASE}.sh"

        # check_list_backup_red_banco
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_list_backup_red_banco.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_list_backup_red_banco_${BASE}.sh"

        # check_size_backup_banco
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_size_backup_banco.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_size_backup_banco_${BASE}.sh"

        # check_integrity_red_local
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_integrity_red_local.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_integrity_red_local_${BASE}.sh"
    fi

    if [ "${CHECK_RMAN}" == "True" ]
    then
        # check_rman_agent_archive
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_rman_agent_archive.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_rman_agent_archive_${BASE}.sh"

        # check_rman_agent_full
        echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_SENSORES}/check_rman_agent_full.sh")" \
        > "${CHECK_MK_DIR_PLG}/check_rman_agent_full_${BASE}.sh"
    fi
done

# Altera as permissões dos sensores para o modo de execução.
chmod +x -v ${CHECK_MK_DIR_PLG}