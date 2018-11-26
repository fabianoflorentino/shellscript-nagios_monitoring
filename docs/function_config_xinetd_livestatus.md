# Função [config_xinetd_livestatus]

Função de configuração do livestatus.

### Livestatus

Verifica se o arquivo de configuração do livestatus existe.

```bash
if [ ! -f "${LIVESTATUS_FILE}" ]; then
```

### Xinetd

Reinicializa o serviço do xinetd para aplicar a nova configuração do livestatus.

```bash
systemctl restart xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

### Template

Template de configuração do arquivo livestatus.

```bash
cat << EOF > "${LIVESTATUS_FILE}"
service livestatus
{
        type            = UNLISTED
        port            = 6557
        socket_type     = stream
        protocol        = tcp
        wait            = no
# limit to 100 connections per second. Disable 3 secs if above.
        cps             = 100 3
# set the number of maximum allowed cicallel instances of unixcat.
# Please make sure that this values is at least as high as
# the number of threads defined with num_client_threads in
# etc/mk-livestatus/nagios.cfg
        instances       = 500
# limit the maximum number of simultaneous connections from
# one source IP address
        per_source      = 250
# Disable TCP delay, makes connection more responsive
        flags           = NODELAY
        user            = ${SITE}
        server          = /opt/omd/versions/1.30/bin/unixcat
        server_args     = /omd/sites/${SITE}/tmp/run/live
# configure the IP address(es) of your Nagios server here:
#       only_from       = 127.0.0.1 10.0.20.1 10.0.20.2
        disable         = no
}
EOF
```

### Função completa da configuração do xinetd e livestatus
```bash
config_xinetd_livestatus()
{

if [ ! -f "${LIVESTATUS_FILE}" ]; then

{

cat << EOF > "${LIVESTATUS_FILE}"
service livestatus
{
        type            = UNLISTED
        port            = 6557
        socket_type     = stream
        protocol        = tcp
        wait            = no
# limit to 100 connections per second. Disable 3 secs if above.
        cps             = 100 3
# set the number of maximum allowed cicallel instances of unixcat.
# Please make sure that this values is at least as high as
# the number of threads defined with num_client_threads in
# etc/mk-livestatus/nagios.cfg
        instances       = 500
# limit the maximum number of simultaneous connections from
# one source IP address
        per_source      = 250
# Disable TCP delay, makes connection more responsive
        flags           = NODELAY
        user            = ${SITE}
        server          = /opt/omd/versions/1.30/bin/unixcat
        server_args     = /omd/sites/${SITE}/tmp/run/live
# configure the IP address(es) of your Nagios server here:
#       only_from       = 127.0.0.1 10.0.20.1 10.0.20.2
        disable         = no
}
EOF

systemctl restart xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

} &> /dev/null && echo -e "${GREEN}Livestatus ............................OK!${NC}\n"

else
    echo -e "${GREEN}Livestatus ............................OK!${NC}\n"
fi

}
```