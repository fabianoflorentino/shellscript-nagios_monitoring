# Função [install_repos]

- Oracle/CentOS 6
    - Yum Public versão 6.
    - EPEL 6.

- Oracle/CentOS 7
    - Yum Public versão 7.
    - EPEL 7.
    - MariaDB. **(Somente para Oracle Linux)**.

#### Sistema Operacional

Verifica se a versão do sistema operacional é da família RedHat versão 6.

```bash
# Verifica se a versão do sistema operacional é da família RedHat versão 6.
if [ "${OS_VERSION}" == "6" ]; then
```

Verifica se a versão do sistema operacional é da família RedHat versão 7

```bash
# Verifica se a versão do sistema operacional é da família RedHat versão 7.
elif [ "${OS_VERSION}" == "7" ]; then
```


#### Public Yum

Instala o repositorio yum public.

```bash

# Verifica se o repositório "Yum Public" está instalado no sistema.
if [ -z "${YUMPUB_VERIFY}" ]; then
    
    {
        rpm --import "${YUM_GPG_KEY}"
        wget -v -O "${REPO_DIR}/public-yum-ol${OS_VERSION}.repo" \
        "${YUMPUB_URL}/public-yum-ol${OS_VERSION}.repo" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

    } &> /dev/null && echo -e "${GREEN}Repositorios public-yum-ol${OS_VERSION}.repo ......OK!${NC}\n"
```

#### EPEL

Instala o repositorio caso ele não esteja instalado no sistema operacional.

```bash
# Verifica se o repositório "EPEL" está instalado no sistema.
if [ -z "${EPEL_VERIFY}" ]; then
    
    {
        ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} \
        "${EPEL_URL}/epel-release-latest-${OS_VERSION}.noarch.rpm" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

    } &> /dev/null && echo -e "${GREEN}Repositorios epel.repo ................OK!${NC}\n"
```

#### MariaDB

Instala o repositório MariaDB caso o sistema operacional não seja o CentOS 7, o mesmo
ja está definido como padrão desse sistema.

```bash
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
```

#### Função completa da instalação dos repositórios.

```bash
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
```