#!/usr/bin/env bash

# Contém informações de variáveis e configurações essenciais para o bom funcionamento do
# programa.
source ./params/2com_monitor_params
source ./drivers/oracle/install
source ./config/omd_profile
source ./config/main/main_mk
source ./config/sensors/config_sensors
source ./config/livestatus
source ./config/omd_user_oracle
source ./config/tnsnames_ora


# Pacotes essenciais
remove_packages()
{
    # Verifica se a versão do sistema operacional é da família RedHat versão 7.    
    if [ "${OS_VERSION}" == "7" ]; then
    
        {
            # Remove os programas que estão na lista no arquivo "./packages/list7_pkg_rm".
            for PKGS in "${PKG_RM_LIST7}"; do

                ${YUM_PRG} ${YUM_OPT3} ${PKGS} ${YUM_OPT_FLAG1} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            done
        
        } &> /dev/null && echo -e "\n${GREEN}Programas que conflitam removidos .....OK!${NC}\n"
    else

        echo -e "\n${GREEN}Programas que conflitam removidos .....OK!${NC}\n"
    fi
}

install_packages() 
{
    # Verifica se a versão do sistema operacional é da família RedHat versão 6.
    if [ "${OS_VERSION}" == "6" ]; then

        # TODO: Colocar esse trecho e um laço, lendo uma lista de programas para ser 
        # instalado.
        # FIXME: Buscar uma alternativa ao uso do while read para os sistemas operacionais 
        # CentOS/Oracle Linux 6.
        
        # As chaves entre os comandos esconte a saída do shell direcionando para /dev/null
        # e imprimi tudo no log "${LOG}" do programa.
        {
            ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} libdbi 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} gcc 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} gcc-c++ 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
        
        } &> /dev/null && echo -e "${GREEN}Programas essenciais ..................OK!${NC}\n"

    # Verifica se a versão do sistema operacional é da família RedHat versão 7.
    elif [ "${OS_VERSION}" == "7" ]; then

        {
            # Instala os programas que estão na lista no arquivo "./packages/list7".
            while read -r PKGS
            do
                ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} ${PKGS} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            done < "${PKG_LIST7}"

        } &> /dev/null && echo -e "${GREEN}Programas essenciais ..................OK!${NC}\n"

    else

        echo -e "\n${RED}Sistema Operacional Fora do Padrao.${NC}\n"
    fi
}

# Repositórios Essenciais.
install_repos() 
{
    # Verifica se a versão do sistema operacional é da família RedHat versão 6.
    if [ "${OS_VERSION}" == "6" ]; then

        # Verifica se o repositório "Yum Public" está instalado no sistema.
        if [ -z "${YUMPUB_VERIFY}" ]; then
            
            {
                rpm --import "${YUM_GPG_KEY}"
                wget -v -O "${REPO_DIR}/public-yum-ol${OS_VERSION}.repo" \
                "${YUMPUB_URL}/public-yum-ol${OS_VERSION}.repo" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            } &> /dev/null && echo -e "${GREEN}Repositorios public-yum-ol${OS_VERSION}.repo ......OK!${NC}\n"
        else

            echo -e "${GREEN}Repositorios public-yum-ol${OS_VERSION}.repo ......OK!${NC}\n"
        fi

        # Verifica se o repositório "EPEL" está instalado no sistema.
        if [ -z "${EPEL_VERIFY}" ]; then
            
            {
                ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} \
                "${EPEL_URL}/epel-release-latest-${OS_VERSION}.noarch.rpm" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            } &> /dev/null && echo -e "${GREEN}Repositorios epel.repo ................OK!${NC}\n"
        else

            echo -e "${GREEN}Repositorios epel.repo ................OK!${NC}\n"
        fi

    # Verifica se a versão do sistema operacional é da família RedHat versão 7.
    elif [ "${OS_VERSION}" == "7" ]; then

        # Verifica se o repositório "Yum Public" está instalado no sistema.
        if [ -z "${YUMPUB_VERIFY}" ]; then
            
            {
                rpm --import "${YUM_GPG_KEY}"
                wget -v -O "${REPO_DIR}/public-yum-ol${OS_VERSION}.repo" \
                "${YUMPUB_URL}/public-yum-ol${OS_VERSION}.repo" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            } &> /dev/null && echo -e "${GREEN}Repositorios public-yum-ol${OS_VERSION}.repo ......OK!${NC}\n"
        else

            echo -e "${GREEN}Repositorios public-yum-ol${OS_VERSION}.repo ......OK!${NC}\n"
        fi

        # Verifica se o repositório "EPEL" está instalado no sistema.
        if [ -z "${EPEL_VERIFY}" ]; then
            
            {
                ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} \
                "${EPEL_URL}/epel-release-latest-${OS_VERSION}.noarch.rpm" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            } &> /dev/null && echo -e "${GREEN}Repositorios epel.repo ................OK!${NC}\n"
        else

            echo -e "${GREEN}Repositorios epel.repo ................OK!${NC}\n"
        fi

        # Verifica se o repositório "MariaDB" está instalado no sistema.
        if [ -z "${MARIADB_VERIFY}" ]; then
            
            # Verifica se o sistema operacional é CentOS,
            # se for o repositório "MariaDB" não será instalado, o mesmo
            # já faz parte do sistema.
            if [ "${IF_CENTOS}" != "CentOS" ]; then
            
                {
                    rpm --import "${MARIADB_GPG_KEY}" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
                    ${CP} ${CP_OPT1} ${MARIADB_INSTALL} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                } &> /dev/null && echo -e "${GREEN}Repositorios mariadb.repo .............OK!${NC}\n"
            else
            
                echo -e "${GREEN}Repositorios mariadb.repo .............OK!${NC}\n"
            fi
        else

            echo -e "${GREEN}Repositorios mariadb.repo .............OK!${NC}\n"
        fi

    else

        echo -e "\n${RED}Sistema Operacional Fora do Padrao.${NC}\n"
    fi
}

# OMD
install_omd()
{
    # Verifica se o "OMD" está instalado no sistema.
    if [ -z "${OMD_RHEL_VERIFY}" ]; then

        # Verifica se a versão do sistema operacional é da família RedHat versão 6.
        if [ "${OS_VERSION}" == "6" ]; then

            {
                ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} ${OMD_RHEL} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            } &> /dev/null && echo -e "${GREEN}OMD ...................................OK!${NC}\n"

        # Verifica se a versão do sistema operacional é da família RedHat versão 7.
        elif [ "${OS_VERSION}" == "7" ]; then

            {
                ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} ${YUM_UTILS} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                ${YUM_CM} ${YUM_CM_OPT1} ${OL_OPT_LTST} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} ${OMD_RHEL} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

                ${CP} ${CP_OPT1} ${OMD_PY_DIR}/hashlib.py ${OMD_PY_DIR}/hashlib.py.old
                
                ${CP} ${CP_OPT1} /usr/lib64/python2.7/hashlib.py ${OMD_PY_DIR}/hashlib.py

            } &> /dev/null && echo -e "${GREEN}OMD ...................................OK!${NC}\n"

        else
            echo -e "\n${RED}Sistema Operacional Fora do Padrao.${NC}\n"
        fi

    else

        echo -e "${GREEN}OMD ...................................OK!${NC}\n"
    fi
}

# CHECK_MK
install_check_mk()
{
    # Verifica se o programa "Check-MK e Xinetd" estão instalado no sistema.
    if [ -z "${CHECK_MK_VERIFY}" ]; then

        {
            ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} "${CHECK_MK_DIR_AG}/${CHECK_MK_AG}" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            systemctl enable xinetd
            systemctl start xinetd

        } &> /dev/null && echo -e "${GREEN}CHECK-MK ..............................OK!${NC}\n"
        
    else
        echo -e "${GREEN}CHECK-MK ..............................OK!${NC}\n"
    fi
}

create_site_omd()
{
    {        
        if [ -z ${SITE_VERIFY} ] && [ -z ${SITE_VERIFY_2} ];then
        
            # Cria o site de monitoramento.
            omd create ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Faz uma busca pela linha que contém o número de threads e altera de 20 para 100.
            echo "$(sed "s/num_client_threads=20/num_client_threads=100/g" "${NAGIOS_CONFIG_FILE}/nagios.cfg")" \
            > "${NAGIOS_CONFIG_FILE}/nagios.cfg"
            
            usermod -G oinstall,dba,omd ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            usermod -G oinstall,dba,asmadmin,asmdba,asmoper,osasm,omd ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Incia o site de monitoramento.
            omd start ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        else
            
            echo -e "${GREEN}Site OMD ..............................OK!${NC}\n"
        fi

    } &> /dev/null && echo -e "${GREEN}Site OMD ..............................OK!${NC}\n"
}


{
    for CONF in "${SITE}" "${NOME_CLIENTE}" "${IP_LOCAL}" "${DB_VERSION}" \
    "${BKP_WINTHOR}" "${DB_BKP_DIR}" "${BKP_NUVEM}" "${DB_INSTANCE}" \
    "${DB_HOME_SOFT}" "${DATABASE_NAME}" "${HOSTNAME_MAIN}"; do

    if [ -z "${CONF}" ]; then

        echo -e "\n${RED}Por favor verifique as configurações em ./params/2com_monitor_params${NC}\n"
        exit
    fi

    done
    
    # Funções para execução de todo o processo de instalação
    # e configuração do serviço de moitoramento.
    remove_packages
    install_packages
    install_repos
    install_omd
    install_check_mk
    install_oracle_driver
    config_user_omd_oracle
    config_tnsnames_ora
    create_site_omd
    config_profile_omd
    config_main_mk
    config_sensors
    config_xinetd_livestatus
}
