# Função [config_main_mk]

Função para criação e configuração do arquivo main.mk do sistema de monitoramento.

OBS: Essa função encontra-se no path **./config/main/main_mk**.

### Main.mk

Verifica se o arquivo main.mk já está com a configuração padrão da 2com.

```bash
if [ "${MAIN_MK_VERIFY}" != "#\ Arquivo\ main.mk\ padrao\ 2com" ]; then
```

### Template

Template para configuração do arquivo main.mk padrão da 2com.

```bash
cat << EOF > "/omd/sites/${SITE}/etc/check_mk/main.mk"
#
# Arquivo main.mk padrao 2com
#
all_hosts = [
'${HOSTNAME_MAIN}',
 ]
ipaddresses = {
  "${HOSTNAME_MAIN}" : "${IP_LOCAL}",
}

extra_host_conf["alias"] = [
 ( "DB Oracle Prod - ${NOME_CLIENTE}", ["${HOSTNAME_MAIN}"] ),
]

ignored_services = [
  ( ALL_HOSTS, [ "OMD","OMD Status"] )
]
ignored_checktypes = [
'postfix_mailq','systemtime','logwatch','ntp.time','cups_queues',
]
extra_nagios_conf += r"""

# ORACLE COMMANDS
define command{
        command_name    check_listener
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_tcp -H \$HOSTADDRESS$ -p 1521
        }

define command{
        command_name    check_oracle_users
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode connected-users --warning 150 --critical 200
        }

define command{
        command_name    check_oracle_sessions
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode session-usage
        }

define command{
        command_name    check_oracle_tablespace_usage
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --warning 90 --critical 95 --mode tablespace-usage
        }

define command{
        command_name    check_oracle_deadlocks
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --warning 01 --critical 05 --mode sql --name 'SELECT COUNT(*) FROM (SELECT (SELECT terminal FROM gv\$session WHERE sid=a.sid) blocker, a.sid,(SELECT terminal FROM gv\$session  WHERE sid=b.sid) blockee,  b.sid FROM gv\$lock a, gv\$lock b WHERE a.block = 1 AND b.request > 0 AND a.id1 = b.id1 AND a.id2 = b.id2)' --name2 deadlock
        }

define command{
        command_name    check_oracle_flra
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode flash-recovery-area-free
        }

define command{
        command_name    check_asm
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode asm-diskgroup-usage
        }

# ORACLE SERVICES
define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Users
        check_command                   check_oracle_users
        notifications_enabled           0
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Listener
        check_command                   check_listener
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Sessions
        check_command                   check_oracle_sessions
        notifications_enabled           0
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Deadlock
        check_command                   check_oracle_deadlocks
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - TableSpace
        check_command                   check_oracle_tablespace_usage
        notifications_enabled           0
        }

#define service{
#        use                             check_mk_default         ; Name of service template to use
#        host_name                       ${HOSTNAME_MAIN}
#        service_description             Oracle - Asm
#        check_command                   check_asm
#        notifications_enabled           0
#        }

#define service{
#        use                             check_mk_default         ; Name of service template to use
#        host_name                       ${HOSTNAME_MAIN}
#        service_description             Oracle - Flash_Recovery_Area
#        check_command                   check_oracle_flra
#        notifications_enabled           0
#        }
"""
EOF
```

### Função completa de configuração do arquivo main.mk

```bash
config_main_mk ()
{

if [ "${MAIN_MK_VERIFY}" != "#\ Arquivo\ main.mk\ padrao\ 2com" ]; then

{
cat << EOF > "/omd/sites/${SITE}/etc/check_mk/main.mk"
#
# Arquivo main.mk padrao 2com
#
all_hosts = [
'${HOSTNAME_MAIN}',
 ]
ipaddresses = {
  "${HOSTNAME_MAIN}" : "${IP_LOCAL}",
}

extra_host_conf["alias"] = [
 ( "DB Oracle Prod - ${NOME_CLIENTE}", ["${HOSTNAME_MAIN}"] ),
]

ignored_services = [
  ( ALL_HOSTS, [ "OMD","OMD Status"] )
]
ignored_checktypes = [
'postfix_mailq','systemtime','logwatch','ntp.time','cups_queues',
]
extra_nagios_conf += r"""

# ORACLE COMMANDS
define command{
        command_name    check_listener
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_tcp -H \$HOSTADDRESS$ -p 1521
        }

define command{
        command_name    check_oracle_users
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode connected-users --warning 150 --critical 200
        }

define command{
        command_name    check_oracle_sessions
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode session-usage
        }

define command{
        command_name    check_oracle_tablespace_usage
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --warning 90 --critical 95 --mode tablespace-usage
        }

define command{
        command_name    check_oracle_deadlocks
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --warning 01 --critical 05 --mode sql --name 'SELECT COUNT(*) FROM (SELECT (SELECT terminal FROM gv\$session WHERE sid=a.sid) blocker, a.sid,(SELECT terminal FROM gv\$session  WHERE sid=b.sid) blockee,  b.sid FROM gv\$lock a, gv\$lock b WHERE a.block = 1 AND b.request > 0 AND a.id1 = b.id1 AND a.id2 = b.id2)' --name2 deadlock
        }

define command{
        command_name    check_oracle_flra
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode flash-recovery-area-free
        }

define command{
        command_name    check_asm
        command_line    /opt/omd/versions/1.30/lib/nagios/plugins/check_oracle_health --connect ${DATABASE_NAME} --username omd --password omdspring --mode asm-diskgroup-usage
        }

# ORACLE SERVICES
define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Users
        check_command                   check_oracle_users
        notifications_enabled           0
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Listener
        check_command                   check_listener
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Sessions
        check_command                   check_oracle_sessions
        notifications_enabled           0
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - Deadlock
        check_command                   check_oracle_deadlocks
        }

define service{
        use                             check_mk_default         ; Name of service template to use
        host_name                       ${HOSTNAME_MAIN}
        service_description             Oracle - TableSpace
        check_command                   check_oracle_tablespace_usage
        notifications_enabled           0
        }

#define service{
#        use                             check_mk_default         ; Name of service template to use
#        host_name                       ${HOSTNAME_MAIN}
#        service_description             Oracle - Asm
#        check_command                   check_asm
#        notifications_enabled           0
#        }

#define service{
#        use                             check_mk_default         ; Name of service template to use
#        host_name                       ${HOSTNAME_MAIN}
#        service_description             Oracle - Flash_Recovery_Area
#        check_command                   check_oracle_flra
#        notifications_enabled           0
#        }
"""
EOF

su - ${SITE} -c "cmk -IIv && cmk -Rv"

} &> /dev/null && echo -e "${GREEN}MAIN.MK ...............................OK!${NC}\n"

else
    echo -e "${GREEN}MAIN.MK ...............................OK!${NC}\n"
fi
}
```