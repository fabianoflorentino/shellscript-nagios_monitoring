# Função [config_sensors]

### Sensores

Verifica se a pasta está vazia.

```bash
if [ ! "$(ls -A ${CHECK_MK_DIR_PLG})" ];then
```

Se a pasta estiver vazia são configurados os sensores.

- check_list_backup_local.sh
- check_list_backup_red_banco.sh
- check_rman_agent_archive.sh
- check_rman_agent_full.sh
- check_size_backup_banco.sh
- check_version_agent.sh
- check_backup_compress.sh
- check_backup_export.sh
- check_integrity_red_local.sh

### Sistema Winthor

Verifica a flag para implementação dos sensores do sistema winthor.

- True: Implementa os sensores para o sistema.

    - check_list_backup_red_sistema.sh
    - check_list_backup_sistema_local.sh
    - check_size_backup_sistema.sh

- False: Não implementa os sensores para o sistema.

```bash
if [ "${BKP_WINTHOR}" == "True" ]
```

### Backup em nuvem

Verifica a flag para implementação dos sensores de backup em nuvem.

- True: Implementa os sensores para o backup em nuvem.

    - check_list_backup_nuvem.sh
    - check_integrity_nuvem.sh

- False: Não implementa os sensores para o backup em nuvem.

```bash
if [ "${BKP_NUVEM}" == "True" ]
```

### Permissões

Altera as permissões dos sensores para o modo de execução.

```bash
chmod +x -v /usr/lib/check_mk_agent/plugins/*.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

### Xinetd

Reinicaliza o serviço do xinetd.

```bash
systemctl restart xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

### CMK

Faz o inventário dos sensores implementados.

```bash
su - ${SITE} -c "cmk -IIv && cmk -Rv" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```


### Função completa de configuração dos sensores

```bash
config_sensors()
{
    {
        # Verifica se a pasta de sensores "/usr/lib/check_mk_agent/plugins" está
        # vazia.
        if [ ! "$(ls -A ${CHECK_MK_DIR_PLG})" ];then

            for BASE in ${BASES[@]}; do

                # check_list_backup_local.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_list_backup_local.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_list_backup_local_${BASE}.sh"
                
                # check_list_backup_red_banco.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_list_backup_red_banco.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_list_backup_red_banco_${BASE}.sh"
                
                # check_rman_agent_archive.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_rman_agent_archive.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_rman_agent_archive_${BASE}.sh"
                
                # check_rman_agent_full.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_rman_agent_full.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_rman_agent_full_${BASE}.sh"
                
                # check_size_backup_banco.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_size_backup_banco.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_size_backup_banco_${BASE}.sh"
                
                # check_version_agent.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_version_agent.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_version_agent_${BASE}.sh"

            done
            
            # check_backup_compress.sh
            ${CP} ${CP_OPT1} ${DIR_TEMP}/check_backup_compress.sh \
            ${CHECK_MK_DIR_PLG}/check_backup_compress.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            # check_backup_export.sh
            ${CP} ${CP_OPT1} ${DIR_TEMP}/check_backup_export.sh \
            ${CHECK_MK_DIR_PLG}/check_backup_export.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            # check_integrity_red_local.sh
            ${CP} ${CP_OPT1} ${DIR_TEMP}/check_integrity_red_local.sh \
            ${CHECK_MK_DIR_PLG}/check_integrity_red_local.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            if [ "${BKP_WINTHOR}" == "True" ]
            then
                # check_list_backup_red_sistema.sh
                ${CP} ${CP_OPT1} ${DIR_TEMP}/check_list_backup_red_sistema.sh \
                ${CHECK_MK_DIR_PLG}/check_list_backup_red_sistema.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                # check_list_backup_sistema_local.sh
                ${CP} ${CP_OPT1} ${DIR_TEMP}/check_list_backup_sistema_local.sh \
                ${CHECK_MK_DIR_PLG}/check_list_backup_sistema_local.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                # check_size_backup_sistema.sh
                ${CP} ${CP_OPT1} ${DIR_TEMP}/check_size_backup_sistema.sh \
                ${CHECK_MK_DIR_PLG}/check_size_backup_sistema.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            fi

            if [ "${BKP_NUVEM}" == "True" ]
            then
                # check_list_backup_nuvem.sh
                echo "$(sed "s/BASE=/BASE=$BASE/g" "${DIR_TEMP}/check_list_backup_nuvem.sh")" \
                > "${CHECK_MK_DIR_PLG}/check_list_backup_nuvem_${BASE}.sh"

                # check_integrity_nuvem.sh
                ${CP} ${CP_OPT1} ${DIR_TEMP}/check_integrity_nuvem.sh \
                ${CHECK_MK_DIR_PLG}/check_integrity_nuvem.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            fi

            # Altera as permissões dos sensores para o modo de execução
            chmod +x -v /usr/lib/check_mk_agent/plugins/*.sh 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Habilita servicos da porta 6556 e 6557 apos as devidas configuracoes
            systemctl restart xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Inventaria sensores automaticos obtidos pelo agente de monitoramento
            su - ${SITE} -c "cmk -IIv && cmk -Rv" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
        fi

    } &> /dev/null && echo -e "${GREEN}Sensores Automaticos ..................OK!${NC}\n"
}
```