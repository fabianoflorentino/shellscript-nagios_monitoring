# Função [remove_packages]

### Remoção dos programas conflitantes com a instalação do OMD.

A função abaixo faz a leitura de uma lista de programas, verificando se estão instalados,
se o programa constar no sistema a função faz a remoção.

```bash
remove_packages()
{
    # Verifica se a versão do sistema operacional é da família RedHat versão 7.    
    if [ "${OS_VERSION}" == "7" ]; then
    
        {
            # Remove os programas que estão na lista no arquivo "./packages/list7_pkg_rm".
            while read -r PKGS
            do
                ${YUM_PRG} ${YUM_OPT3} ${PKGS} ${YUM_OPT_FLAG1} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            done < "${PKG_RM_LIST7}"
        
        } &> /dev/null && echo -e "\n${GREEN}Programas que conflitam removidos .....OK!${NC}\n"
    else

        echo -e "\n${GREEN}Programas que conflitam removidos .....OK!${NC}\n"
    fi
}
```