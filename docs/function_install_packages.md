# Função [install_packages]

#### Pacotes Essenciais

- Oracle/CentOS 6
    - libdbi
    - gcc
    - gcc-c++

- Oracle/CentOS 7
    - wget
    - libaio
    - bc
    - flex
    - gcc
    - gcc-c++
    - unzip
    - bzip2

#### Instalação do pacotes essenciais.

Na condição a baixo, a função testa se o sistema operacional é da versão 6, percorre uma lista
e instala os programas essenciais para o sistema de monitoramento.

```bash
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
```

Na condição a baixo, a função testa se o sistema operacional é da versão 6, percorre uma lista
e instala os programas essenciais para o sistema de monitoramento.

```bash
# Verifica se a versão do sistema operacional é da família RedHat versão 7.
    elif [ "${OS_VERSION}" == "7" ]; then

        {
            # Instala os programas que estão na lista no arquivo "./packages/list7".
            while read -r PKGS
            do
                ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} ${PKGS} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            done < "${PKG_LIST7}"

        } &> /dev/null && echo -e "${GREEN}Programas essenciais ..................OK!${NC}\n"
```

#### Função Completa de instalação dos programas essenciais.
```bash
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
```