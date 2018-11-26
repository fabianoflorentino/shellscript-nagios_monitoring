# Parametros e configurações

Parametros e configurações para as funções do sistema.

São realizados testes condicionais, configuração de parametros, configuração de 
paths de arquivos do sistema e configuração dos programas e suas opções.

#### Informações do cliente
```bash
SITE=""
NOME_CLIENTE=""
IP_LOCAL=""
BKP_WINTHOR=""
BKP_NUVEM=""
DB_BKP_DIR="\/db\/backup" #### Escapar as barras e o underline.
DB_VERSION=""
DB_INSTANCE=""
DB_HOME_SOFT=""
DATABASE_NAME=""
HOSTNAME_MAIN="${SITE}-dbprimario"
```

#### Lista para permissão de execução do programa
```bash
CONFIGS="\${SITE}
\${NOME_CLIENTE}
\${IP_LOCAL}
\${BKP_WINTHOR}
\${BKP_NUVEM}
\${DB_BKP_DIR}
\${DB_VERSION}
\${DB_INSTANCE}
\${DB_HOME_SOFT}
\${DATABASE_NAME}
\${HOSTNAME_MAIN}"
```

#### Path
```bash
export PATH="/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
```

#### Variáveis de ambiente Oracle
```bash
export ORACLE_HOME=/u01/app/oracle/product/${DB_VERSION}/${DB_HOME_SOFT}
export ORACLE_SID=${DATABASE_NAME}
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
```

#### Log do sistema
```bash
LOG_OUT="./logs/2com_monitor.out"
LOG_ERROR="./logs/2com_monitor.err"
COMPILE_LOG="./logs/driver_compile.out"
```

#### Lista de pacotes para remoção
```bash
PKG_RM_LIST7=$(cat ./packages/list7_pkg_rm)
```

#### Lista de pacotes para instalação
```bash
PKG_LIST6="./packages/list6"
PKG_LIST7="./packages/list7"
```

#### Variáveis para o sistema
```bash
REGEX="[^0-9]*\(\([0-9]\.\)\{0,4\}[0-9][^.]\).*"
RELEASE_DIR="/etc/redhat-release"
REPO_DIR="/etc/yum.repos.d"
IF_CENTOS=$(cat "${RELEASE_DIR}" |awk '{ print $1 }')
OS_VERSION=$(sed -ne "s/${REGEX}/\1/p" "${RELEASE_DIR}" |cut -d"." -f1) 
```

#### Repositório Yum Public
```bash
YUMPUB_URL="http://yum.oracle.com"
YUMPUB_VERIFY=$(grep -r -l "ol${OS_VERSION}_latest" "${REPO_DIR}" |cut -d"/" -f4)
YUM_GPG_KEY="http://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol${OS_VERSION}"
YUM_UTILS="yum-utils"
```

#### Yum
```bash
YUM_PRG="yum"
YUM_OPT1="install"
YUM_OPT2="localinstall"
YUM_OPT3="remove"
YUM_OPT_FLAG1="-y"
YUM_OPT_FLAG2="-v"
```

#### Yum Config Manager
```bash
YUM_CM="yum-config-manager"
YUM_CM_OPT1="--enable"
OL_OPT_LTST="ol${OS_VERSION}_optional_latest"
```

#### Copy
```bash
CP=$(which cp |tail -n 1 |xargs)
CP_OPT1="-rfv"
```

#### Repositório EPEL
```bash
EPEL_URL="https://dl.fedoraproject.org/pub/epel"
EPEL_VERIFY=$(grep -r -l "repo=epel-${OS_VERSION}" ${REPO_DIR} |cut -d"/" -f4)
```

#### Repositório MariaDB
```bash
MARIADB_INSTALL="./repos/mariadb.repo ${REPO_DIR}/"
MARIADB_VERIFY=$(grep -r -l "mariadb" ${REPO_DIR} |cut -d"/" -f4)
```

#### Pacote de instalação do OMD
```bash
OMD_RHEL="./packages/omd-1.30.rhel${OS_VERSION}.x86_64.rpm"
OMD_RHEL_VERIFY=$(rpm -aq |grep omd-1.30-el${OS_VERSION}-35.x86_64)
SITE_VERIFY=$(cat /etc/passwd |egrep "^${SITE}" |cut -d":" -f1)
OMD_PY_DIR="/omd/versions/1.30/lib/python"
```

#### Pacote de instalação do Check_MK
```bash
CHECK_MK_DIR_AG="/opt/omd/versions/1.30/share/check_mk/agents"
CHECK_MK_AG="check-mk-agent-1.2.6p12-1.noarch.rpm"
CHECK_MK_VERIFY=$(rpm -aq |grep check-mk-agent-1.2.6p12-1.noarch)
```

#### Pacote Perl ExtUtils Make Maker
```bash
PERL_EXTUTILS_MAKE_VERIFY=$(rpm -aq |grep "perl-ExtUtils-MakeMaker")
```

#### Driver Oracle
```bash
OCL_DRIVE_FILE="/usr/local/lib64/perl5/auto/DBD/Oracle/Oracle.so"
```

#### Template 2COM
```bash
URL_OMD_HTDOCS="/opt/omd/versions/1.30/share/check_mk/web/htdocs"
URL_OMD_DASH="/opt/omd/versions/1.30/share/check_mk/web/plugins/dashboard"
URL_OMD_IMG="/opt/omd/versions/1.30/share/check_mk/web/htdocs/images"
```
#### Configuração do Nagios
```bash
NAGIOS_CONFIG_FILE="/opt/omd/sites/${SITE}/etc/mk-livestatus"
```

#### Configuração do main.mk
```bash
MAIN_MK_DIR="/omd/sites/${SITE}/etc/check_mk"
MAIN_MK_OPT="#\ Arquivo\ main.mk\ padrao\ 2com"
MAIN_MK_VERIFY=$(grep -r -i "${MAIN_MK_OPT}" ${MAIN_MK_DIR}/main.mk 2> /dev/null)
```

#### Configuração dos sensores
```bash
CHECK_MK_DIR_PLG="/usr/lib/check_mk_agent/plugins"
CREATE_BASE_LIST=$(echo "${DATABASE_NAME}" > ./config/base_list)
BASES=$(cat ./config/base_list)
DIR_TEMP="./config/sensors"
```

#### Configuração do livestatus
```bash
LIVESTATUS_FILE="/etc/xinetd.d/livestatus"
```

#### Customização
```bash
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"
YELLOW="\033[1;33m"
```