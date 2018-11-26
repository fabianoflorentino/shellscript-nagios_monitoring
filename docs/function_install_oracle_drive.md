# Função [install_oracle_drive]

Essa função faz a instalação dos programas essenciais para a compilação e
instalação do **DBD Oracle drive 1.64**.

OBS: Esse função encontra-se no path **./drivers/oracle/install**

### Perl ExtUtils MakeMaker

Caso o pacote **perl-ExtUtils-MakeMaker** não esteja instalado o trecho do 
código abaixo faz a verificação e instalação do pacote.

```bash
# Verifica se o pacote perl-ExtUtils-MakeMaker está instalado no sistema.
if [ -z "${PERL_EXTUTILS_MAKE_VERIFY}" ]; then

    {
        ${YUM_PRG} ${YUM_OPT1} ${YUM_OPT_FLAG1} \
        perl-ExtUtils-MakeMaker 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

    } &> /dev/null && echo -e "${GREEN}perl-ExtUtils-MakeMaker ...............OK!${NC}\n"
else
    echo -e "${GREEN}perl-ExtUtils-MakeMaker ...............OK!${NC}\n"
fi
```

### DBD Oracle Drive

O sistema faz a cópia dos arquivos do driver para o diretório **/usr/local**
do sistema operacional, o sistema acessa esse local através do link simbólico
**./drivers/local** e faz preparação, compilação e instalação do driver. Para
cada passo é feita uma verificação dos requisitos necessários para a instalação
seja feita de forma correta, a condição **if [ $? == 2 ]; then** deve ser
satisfatória para que o sistema prossiga.

```bash
{
if [ ! -f ${OCL_DRIVE_FILE} ]; then

    # Copia os arquivos de instalação e compilação para o diretório
    # "/usr/local" o programa acessa esse diretorio pelo link simbolico
    # "./drivers/local".
    ${CP} ${CP_OPT1} ./drivers/oracle ./drivers/local/ 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

    ### compile the oracle drive
    cd ./drivers/local/oracle
    
    perl Makefile.PL >> ${COMPILE_LOG}
    if [ $? == 2 ]; then    
        
        echo -e "${RED}Por favor verifique as variaveis de ambiente!${NC}\n" >> ${COMPILE_LOG}
        exit 2
    fi
        
    make >> ${COMPILE_LOG}
    if [ $? == 2 ]; then    
        
        echo -e "${RED}Erro ao configurar o arquivo MAKE, verifique os requisitos do sistema.${NC}\n" >> ${COMPILE_LOG}
        exit 2
    fi
    
    make install >> ${COMPILE_LOG}
    if [ $? == 2 ]; then    
        
        echo -e "${RED}Erro ao instalar o drive, verifique os requisitos do sistema.${NC}\n" >> ${COMPILE_LOG}
        exit 2
    fi
    
    ### Return to directory base.
    cd -
else

    echo -e "${GREEN}DBD Driver Oracle .....................OK!${NC}\n"
fi

} &> /dev/null && echo -e "${GREEN}DBD Driver Oracle .....................OK!${NC}\n"
```

### Função completa de instalação e compilação do driver DBD Oracle drive
```bash
install_oracle_driver()

{
    ### Checks if the perl-ExtUtils-MakeMaker program is installed on the system.
    if [ -z "${PERL_EXTUTILS_MAKE_VERIFY}" ]; then

        {
            ${YUM_PRG} ${YUM_OPT1} ${YUM_OPT_FLAG1} \
            perl-ExtUtils-MakeMaker 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        } &> /dev/null && echo -e "${GREEN}perl-ExtUtils-MakeMaker ...............OK!${NC}\n"
    else
        echo -e "${GREEN}perl-ExtUtils-MakeMaker ...............OK!${NC}\n"
    fi

    {
        if [ ! -f ${OCL_DRIVE_FILE} ]; then

            # Copia os arquivos de instalação e compilação para o diretório
            # "/usr/local" o programa acessa esse diretorio pelo link simbolico
            # "./drivers/local".
            ${CP} ${CP_OPT1} ./drivers/oracle ./drivers/local/ 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            ### compile the oracle drive
            cd ./drivers/local/oracle
            
            perl Makefile.PL >> ${COMPILE_LOG}
            if [ $? == 2 ]; then    
                
                echo -e "${RED}Por favor verifique as variaveis de ambiente!${NC}\n" >> ${COMPILE_LOG}
                exit 2
            fi
                
            make >> ${COMPILE_LOG}
            if [ $? == 2 ]; then    
                
                echo -e "${RED}Erro ao configurar o arquivo MAKE, verifique os requisitos do sistema.${NC}\n" >> ${COMPILE_LOG}
                exit 2
            fi
            
            make install >> ${COMPILE_LOG}
            if [ $? == 2 ]; then    
                
                echo -e "${RED}Erro ao instalar o drive, verifique os requisitos do sistema.${NC}\n" >> ${COMPILE_LOG}
                exit 2
            fi
            
            ### Return to directory base.
            cd -
        else
    
            echo -e "${GREEN}DBD Driver Oracle .....................OK!${NC}\n"
        fi

    } &> /dev/null && echo -e "${GREEN}DBD Driver Oracle .....................OK!${NC}\n"
}
```