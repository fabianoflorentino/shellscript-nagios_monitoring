# Função [install_omd]

Está parte do programa faz a instalação e configuração do OMD, sistema principal da stack
de monitoramento 2com.

#### Pacote OMD para sistema operacional versão 6.

Verifica se o pacote do OMD está instalado no sistema.

```bash
# Verifica se o "OMD" está instalado no sistema.
if [ -z "${OMD_RHEL_VERIFY}" ]; then
```

Instala o pacote do OMD. 
Atualmente está homologado a instalação da versão 1.30.

```bash
{
    ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} ${OMD_RHEL} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

} &> /dev/null && echo -e "${GREEN}OMD ...................................OK!${NC}\n"
```

#### Pacote OMD para sistema operacional versão 7.

É feita a instalação do pacote Yum-utils e habilitado suas funcionalidades basicas, em seguida 
é feita a instalação do pacote do OMD.

É feita uma correção no arquivo **hashlib.py** para uma versão estável.

```bash
# Verifica se a versão do sistema operacional é da família RedHat versão 7.
elif [ "${OS_VERSION}" == "7" ]; then

    {
        ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} ${YUM_UTILS} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        ${YUM_CM} ${YUM_CM_OPT1} ${OL_OPT_LTST} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} ${OMD_RHEL} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        ${CP} ${CP_OPT1} ${OMD_PY_DIR}/hashlib.py ${OMD_PY_DIR}/hashlib.py.old
        
        ${CP} ${CP_OPT1} /usr/lib64/python2.7/hashlib.py ${OMD_PY_DIR}/hashlib.py

    } &> /dev/null && echo -e "${GREEN}OMD ...................................OK!${NC}\n"
```

#### Função completa da instalação do OMD.

```bash
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
```