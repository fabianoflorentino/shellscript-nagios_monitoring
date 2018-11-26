

Licença: GPL (https://pt.wikipedia.org/wiki/GNU_General_Public_License)<br/>

Programa desenvolvido pra realizar a instalação do programa OMD ([Open Monitoring Distribution](http://omdistro.org/)) em sistemas<br/>
operacionais baseados na distribuição RedHat. (Oracle Linux 6/7 e ou CentOS 6/7).<br/>

### Sumário

1. [Função [remove_packages]](/docs/function_remove_packages.md#função-remove_packages)<br/>
  1.1. [Remoção dos programas conflitantes com a instalação do OMD.](/docs/function_remove_packages.md#remoção-dos-programas-conflitantes-com-a-instalação-do-omd)

2. [Função[install_packages]](/docs/function_install_packages.md#função-install_packages)<br/>
  2.1. [Pacotes essenciais](/docs/function_install_packages.md#pacotes-essenciais)<br/>
  2.2. [Instalação dos pacotes essenciais](/docs/function_install_packages.md#instalação-do-pacotes-essenciais)<br/>
  2.3. [Função completa de instalação dos pacotes essenciais](/docs/function_install_packages.md#função-completa-de-instalação-dos-programas-essenciais)

3. [Função [install_repos]](/docs/function_install_repos.md#função-install_repos)<br/>
  3.1. [Sistema Operacional](/docs/function_install_repos.md#sistema-operacional)<br/>
  3.2. [Publi Yum](/docs/function_install_repos.md#public-yum)<br/>
  3.3. [EPEL](/docs/function_install_repos.md#epel)<br/>
  3.4. [MariaDB](/docs/function_install_repos.md#mariadb)<br/>
  3.5. [Função completa da instalação dos repositórios](/docs/function_install_repos.md#função-completa-da-instalação-dos-repositórios)<br/>

4. [Função [install_omd]](/docs/function_install_omd.md#função-install_omd)<br/>
  4.1 [Pacote OMD para sistema operacional versão 6](/docs/function_install_omd.md#pacote-omd-para-sistema-operacional-versão-6)<br/>
  4.2 [Pacote OMD para sistema operacional versão 7](/docs/function_install_omd.md#pacote-omd-para-sistema-operacional-versão-7)<br/>
  4.3 [Função completa da instalação do OMD.](/docs/function_install_omd.md#função-completa-da-instalação-do-omd)<br/>

5. [Função [install_check_mk]](/docs/function_install_check_mk.md#função-install_check_mk)<br/>
  5.1 [Xinetd](/docs/function_install_check_mk.md#xinetd)<br/>
  5.2 [Check_mk](/docs/function_install_check_mk.md#check_mk)<br/>
  5.3 [Função completa da instalação do Check_mk](/docs/function_install_check_mk.md#função-completa-da-instalação-do-xinetd-e-check_mk)<br/>

6. [Função [install_oracle_drive]](/docs/function_install_oracle_drive.md#função-install_oracle_drive)<br/>
  6.1 [Perl ExtUtils MakeMaker](/docs/function_install_oracle_drive.md#perl-extutils-makemaker)<br/>
  6.2 [DBD Oracle Drive](/docs/function_install_oracle_drive.md#dbd-oracle-drive)<br/>
  6.3 [Função completa de instalação e compilação do driver DBD Oracle drive](/docs/function_install_oracle_drive.md#função-completa-de-instalação-e-compilação-do-driver-dbd-oracle-drive)<br/>

7. [Função [config_user_omd_oracle]](/docs/function_config_user_omd_oracle.md#função-config_user_omd_oracle)<br/>
  7.1 [Função [test_user_omd_oracle]](/docs/function_config_user_omd_oracle.md#função-test_user_omd_oracle)<br/>
  7.2 [Configuração do usuário omd](/docs/function_config_user_omd_oracle.md#configuração-do-usuário-omd)<br/>
  7.3 [Função completa da criação e configuração do usuario omd](/docs/function_config_user_omd_oracle.md#função-completa-da-criação-e-configuração-do-usuario-omd)<br/>

8. [Função [config_tnsnames_ora]](/docs/function_config_tnsnames_ora.md#função-config_tnsnames_ora)<br/>
  8.1 [Tnsnames](/docs/function_config_tnsnames_ora.md#tnsnames)<br/>
  8.2 [Permissões](/docs/function_config_tnsnames_ora.md#permissões)<br/>
  8.3 [Função completa da configuração do tnsnames](/docs/function_config_tnsnames_ora.md#função-completa-da-configuração-do-tnsnames)<br/>

9. [Função [create_site_omd]](/docs/function_create_site_omd.md#função-create_site_omd)<br/>
  9.1 [Criação do site de monitoramento](/docs/function_create_site_omd.md#criação-do-site-de-monitoramento)<br/>
  9.2 [Função Completa de criação do site de monitoramento](/docs/function_create_site_omd.md#função-completa-de-criação-do-site-de-monitoramento)

10. [Função [config_profile_omd]](/docs/function_config_profile_omd.md#função-config_profile_omd)<br/>
  10.1 [Template](/docs/function_config_profile_omd.md#template)<br/>
  10.2 [Função completa de configuração do profile](/docs/function_config_profile_omd.md#função-completa-de-configuração-do-profile)<br/>

11. [Função [config_main_mk]](/docs/function_config_main_mk.md#função-config_main_mk)<br/>
  11.1 [Main.mk](/docs/function_config_main_mk.md#mainmk)<br/>
  11.2 [Template](/docs/function_config_main_mk.md#template)<br/>

12. [Função [config_sensors]](/docs/function_config_sensors.md#função-config_sensors)<br/>
  12.1 [Sensores](/docs/function_config_sensors.md#sensores)<br/>
  12.2 [Sistema Winthor](/docs/function_config_sensors.md#sistema-winthor)<br/>
  12.3 [Backup em nuvem](/docs/function_config_sensors.md#backup-em-nuvem)<br/>
  12.4 [Permissões](/docs/function_config_sensors.md#permissões)<br/>
  12.5 [Xinetd](/docs/function_config_sensors.md#xinetd)<br/>
  12.6 [CMK](/docs/function_config_sensors.md#cmk)<br/>
  12.7 [Função completa de configuração dos sensores](/docs/function_config_sensors.md#função-completa-de-configuração-dos-sensores)<br/>

13. [Função [config_xinetd_livestatus]](/docs/function_config_xinetd_livestatus.md#função-config_xinetd_livestatus)<br/>
  13.1 [Livestatus](/docs/function_config_xinetd_livestatus.md#livestatus)<br/>
  13.2 [Xinetd](/docs/function_config_xinetd_livestatus.md#xinetd)<br/>
  13.3 [Template](/docs/function_config_xinetd_livestatus.md#template)<br/>
  13.4 [Função completa da configuração do xinetd e livestatus](/docs/function_config_xinetd_livestatus.md#função-completa-da-configuração-do-xinetd-e-livestatus)<br/>

14. [Parametros e configurações](/docs/2com_monitor_params.md#parametros-e-configurações)<br/>
  14.1 [Informações do cliente](/docs/2com_monitor_params.md#informações-do-cliente)<br/>
  14.2 [Lista para permissão de execução do programa](/docs/2com_monitor_params.md#lista-para-permissão-de-execução-do-programa)<br/>
  14.3 [Path](/docs/2com_monitor_params.md#path)<br/>
  14.4 [Variáveis de ambiente Oracle](/docs/2com_monitor_params.md#variáveis-de-ambiente-oracle)<br/>
  14.5 [Log do sistema](/docs/2com_monitor_params.md#log-do-sistema)<br/>
  14.6 [Lista de pacotes para remoção](/docs/2com_monitor_params.md#lista-de-pacotes-para-remoção)<br/>
  14.7 [Lista de pacotes para instalação](/docs/2com_monitor_params.md#lista-de-pacotes-para-instalação)<br/>
  14.8 [Variáveis para o sistema](/docs/2com_monitor_params.md#variáveis-para-o-sistema)<br/>
  14.9 [Repositório Yum Public](/docs/2com_monitor_params.md#repositório-yum-public)<br/>
  14.10 [Yum](/docs/2com_monitor_params.md#yum)<br/>
  14.11 [Yum Config Manager](/docs/2com_monitor_params.md#yum-config-manager)<br/>
  14.12 [Copy](/docs/2com_monitor_params.md#copy)<br/>
  14.13 [Repositório EPEL](/docs/2com_monitor_params.md#repositório-epel)<br/>
  14.14 [Repositório MariaDB](/docs/2com_monitor_params.md#repositório-mariadb)<br/>
  14.15 [Pacote de instalação OMD](/docs/2com_monitor_params.md#pacote-de-instalação-do-omd)<br/>
  14.16 [Pacote de instalação Check_MK](/docs/2com_monitor_params.md#pacote-de-instalação-do-check_mk)<br/>
  14.17 [pacote Perl ExtUtils Make Maker](/docs/2com_monitor_params.md#pacote-perl-extutils-make-maker)<br/>
  14.18 [Driver Oracle](/docs/2com_monitor_params.md#driver-oracle)<br/>
  14.19 [Template 2com](/docs/2com_monitor_params.md#template-2com)<br/>
  14.20 [Configuração do Nagios](/docs/2com_monitor_params.md#configuração-do-nagios)<br/>
  14.21 [Configuração do main.mk](/docs/2com_monitor_params.md#configuração-do-mainmk)<br/>
  14.22 [Configuração dos sensores](/docs/2com_monitor_params.md#configuração-dos-sensores)<br/>
  14.23 [Configuração do livestatus](/docs/2com_monitor_params.md#configuração-do-livestatus)<br/>
  14.24 [Customização](/docs/2com_monitor_params.md#customização)<br/>

### Modo de Usar

Para executar esse programa é preciso de algumas informações do servidor e dos serviços que
vão ser monitorados.

No arquivo de parametros em **"./params/2com_monitor_params"** é preciso preencher as 
informações:

 - SITE=""
 - NOME_CLIENTE=""
 - IP_LOCAL=""
 - BKP_WINTHOR=""
 - DB_BKP_DIR=""
 - BKP_NUVEM=""
 - DB_VERSION=""
 - DB_INSTANCE=""
 - DB_HOME_SOFT=""
 - DATABASE_NAME=""
 - HOSTNAME_MAIN=""

para que seja realizada a instalação e configuração de forma correta do sistema de
monitoramento.

Exemplo:<br/><br/>
**SITE**="ol7"<br/>
**NOME_CLIENTE**="Teste Oracle Linux 7"<br/>
**IP_LOCAL**="192.168.62.200"<br/>
**BKP_WINTHOR**="True"<br/>
**DB_BKP_DIR**="\/db\/backup"<br/>
**BKP_NUVEM**="False"<br/>
**DB_VERSION**="11.2.0"<br/>
**DB_INSTANCE**="XE"<br/>
**DB_HOME_SOFT**="dbhome_1"<br/>
**DATABASE_NAME**="WINT"<br/>
**HOSTNAME_MAIN**="ol7-dbprimario"<br/>

Em seguida, dentro do diretório do programa **2com_monitor**, como **root** execute o instalador
**2com_monitor_install.bash** e aguarde.

```shell
2com_monitor]# bash 2com_monitor_install.bash
```
