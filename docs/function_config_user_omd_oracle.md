# Função [config_user_omd_oracle]

Função para criação e configuração de permissões do usuário omd as bases de
dados do banco de dados Oracle.

OBS: essa função está no path **./config/omd_user_oracle**.

### Função [test_user_omd_oracle]

A função faz uma conexão ao banco de dados e verifica se o usuário omd
existe.

A verificação **if [ $? != 0 ]** da função verifica se a saida do comando de
conexão foi executada com sucesso e incrementa a variavel **RESULT_TEST**.

```bash
test_user_omd_oracle()
{

su - oracle -c "$ORACLE_HOME/bin/sqlplus -s << EOF
connect / as sysdba
select username from dba_users;
exit;
EOF" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

if [ $? != 0 ]
then
    echo -e "${RED}Verifique as variaveis de ambiente do usuario Oracle!!${NC}\n"
    RESULT_TESTE=1
else
    RESULT_TESTE=$(egrep "^OMD" "${LOG_OUT}" |head -n 1)
fi

}
```

### Configuração do usuário omd

A Função recebe o resultado da função **test_user_omd_oracle** e verifica se
as configurações do sistema estão corretas ou se o usuário já existe.

 Recebe o resultado e verifica se o sistema esta configurado corretamente.
```bash
if [ "${RESULT_TESTE}" == 1 ]
```

Recebe o resultado da verificação se o usuário omd existe no banco.
```bash
elif [ "${RESULT_TESTE}" == "OMD" ]
```

Caso as duas condições não sejam satisfatória o sistema tenta criar o usuario
omd e configura as permissões de acesso.

```bash
else

su - oracle -c "$ORACLE_HOME/bin/sqlplus -s << EOF
connect / as sysdba
create user omd identified by \"omdspring\";
grant dba to omd;
exit;
EOF" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

echo -e "${GREEN}Usuario OMD no banco ..................OK!${NC}\n"

fi

}
```

### Função completa da criação e configuração do usuario omd
```bash
test_user_omd_oracle()
{

su - oracle -c "$ORACLE_HOME/bin/sqlplus -s << EOF
connect / as sysdba
select username from dba_users;
exit;
EOF" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

if [ $? != 0 ]
then
    echo -e "${RED}Verifique as variaveis de ambiente do usuario Oracle!!${NC}\n"
    RESULT_TESTE=1
else
    RESULT_TESTE=$(egrep "^OMD" "${LOG_OUT}" |head -n 1)
fi

}

config_user_omd_oracle()
{

if [ "${RESULT_TESTE}" == 1 ]
then
    echo -e "${RED}Usuario OMD nao configurado no banco!!${NC}\n"

elif [ "${RESULT_TESTE}" == "OMD" ]
then
    echo -e "${GREEN}Usuario OMD no banco ..................OK!${NC}\n"

else

su - oracle -c "$ORACLE_HOME/bin/sqlplus -s << EOF
connect / as sysdba
create user omd identified by \"omdspring\";
grant dba to omd;
exit;
EOF" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

echo -e "${GREEN}Usuario OMD no banco ..................OK!${NC}\n"

fi

}
```