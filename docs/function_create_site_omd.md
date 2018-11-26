# Função [create_site_omd]

### Criação do site de monitoramento

É feito uma verificação antes de criar o site de monitoramento, para
garantir que a criação será única e exclusiva.

Caso não exista nenhum site previamente configurado, o site é criado
através do comando:

```bash
### Create the site.
omd create ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

Na mesma função é feita uma configuração no arquivo **nagios.cfg** aumentando o número de threads de execução do processo do nagios.

```bash
### It searches the standard text string and switches it to the standard 2com string.
echo "$(sed "s/num_client_threads=20/num_client_threads=100/g" "${NAGIOS_CONFIG_FILE}/nagios.cfg")" \
> "${NAGIOS_CONFIG_FILE}/nagios.cfg"
```

No comando abaixo é feita a personalização do site de monitoramento com o nome do cliente.

```bash
echo "$(sed "s/Server 01/${NOME_CLIENTE}/g" "./template/builtin.py")" \
> "./template/builtin.py"
```

Nos comandos abaixo é feita a personalização do site com as informações da 2com Consulting.

```bash
echo "$(sed "s/mathias-kettner.de/www.2comconsulting.com.br/g" "${URL_OMD_HTDOCS}/sidebar.py")" \
> "${URL_OMD_HTDOCS}/sidebar.py"

echo "$(sed "s/Mathias Kettner/2Com Consulting/g" "${URL_OMD_HTDOCS}/sidebar.py")" \
> "${URL_OMD_HTDOCS}/sidebar.py"

echo "$(sed "s/dashlet_padding  = 23/dashlet_padding  = 80/g" "${URL_OMD_HTDOCS}/dashboard.py")" \
> "${URL_OMD_HTDOCS}/dashboard.py"
```

Nos comandos abaixo é feita a personalização do template da 2com no site do monitoramento.

```bash
### Make 2com template copy
${CP} ${CP_OPT1} ./template/dashboard.css "${URL_OMD_HTDOCS}/dashboard.css" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/sidebar.css "${URL_OMD_HTDOCS}/sidebar.css" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/builtin.py "${URL_OMD_DASH}/builtin.py" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/sidebar_top.png "${URL_OMD_IMG}/sidebar_top.png" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/favicon.ico "${URL_OMD_IMG}/favicon.ico" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/mk_logo_small.gif "${URL_OMD_IMG}/mk_logo_small.gif" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/sidebar_background.jpg "${URL_OMD_IMG}/sidebar_background.jpg" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
${CP} ${CP_OPT1} ./template/contentframe_background.jpg "${URL_OMD_IMG}/contentframe_background.jpg" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

Finalizado a criação e personalização do site de monitoramento com as informações do cliene e da 2com o comando abaixo
inicia o site de monitoramento.

```bash
omd start ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

#### Função Completa de criação do site de monitoramento
```bash
create_site_omd()
{
    {        
        if [ -z ${SITE_VERIFY} ];then
        
            # Cria o site de monitoramento.
            omd create ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Faz uma busca pela linha que contém o número de threads e altera de 20 para 100.
            echo "$(sed "s/num_client_threads=20/num_client_threads=100/g" "${NAGIOS_CONFIG_FILE}/nagios.cfg")" \
            > "${NAGIOS_CONFIG_FILE}/nagios.cfg"
            
            # Os próximos 3 comandos faz a personalização do template 2com 
            # para a página web de serviço de monitoramento.
            echo "$(sed "s/Server 01/${NOME_CLIENTE}/g" "./template/builtin.py")" \
            > "./template/builtin.py"
            
            echo "$(sed "s/mathias-kettner.de/www.2comconsulting.com.br/g" "${URL_OMD_HTDOCS}/sidebar.py")" \
            > "${URL_OMD_HTDOCS}/sidebar.py"
            
            echo "$(sed "s/Mathias Kettner/2Com Consulting/g" "${URL_OMD_HTDOCS}/sidebar.py")" \
            > "${URL_OMD_HTDOCS}/sidebar.py"
            
            # Faz uma busca pela linha que contém o número de dashlet_padding e altera de 23 para 80.
            echo "$(sed "s/dashlet_padding  = 23/dashlet_padding  = 80/g" "${URL_OMD_HTDOCS}/dashboard.py")" \
            > "${URL_OMD_HTDOCS}/dashboard.py"

            # Faz a cópia das imagens do template 2com para a página web do serviço de monitoramento.
            ${CP} ${CP_OPT1} ./template/dashboard.css "${URL_OMD_HTDOCS}/dashboard.css" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/sidebar.css "${URL_OMD_HTDOCS}/sidebar.css" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/builtin.py "${URL_OMD_DASH}/builtin.py" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/sidebar_top.png "${URL_OMD_IMG}/sidebar_top.png" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/favicon.ico "${URL_OMD_IMG}/favicon.ico" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/mk_logo_small.gif "${URL_OMD_IMG}/mk_logo_small.gif" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/sidebar_background.jpg "${URL_OMD_IMG}/sidebar_background.jpg" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            
            ${CP} ${CP_OPT1} ./template/contentframe_background.jpg "${URL_OMD_IMG}/contentframe_background.jpg" \
            1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            usermod -G oinstall,dba,omd ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
            usermod -G oinstall,dba,asmadmin,asmdba,asmoper,osasm,omd ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            # Incia o site de monitoramento.
            omd start ${SITE} 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

        else
            
            echo -e "${GREEN}Site OMD ..............................OK!${NC}\n"
        fi

    } &> /dev/null && echo -e "${GREEN}Site OMD ..............................OK!${NC}\n"
}
```