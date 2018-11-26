# Função [install_check_mk]

Função que realiza a instalação do programa xinetd e check_mk agent.

Verifica se o programa check_mk esta instalado.

```bash
# Verifica se o programa "Check-MK e Xinetd" estão instalado no sistema.
if [ -z "${CHECK_MK_VERIFY}" ]; then
```

### Xinetd

Faz a instalação do programa xinetd que é necessário para o programa check_mk
agent.

```bash
${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

### Check_mk

Faz a instalação do programa check_mk agent na versão **1.2.6p12-1**.

```bash
${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} "${CHECK_MK_DIR_AG}/${CHECK_MK_AG}" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"
```

Habilita e inicia o serviço do xinetd.

```bash
systemctl enable xinetd
systemctl start xinetd
```

#### Função Completa da instalação do Xinetd e Check_mk
```bash
install_check_mk()
{
    # Verifica se o programa "Check-MK e Xinetd" estão instalado no sistema.
    if [ -z "${CHECK_MK_VERIFY}" ]; then

        {
            ${YUM_PRG} ${YUM_OPT1}  ${YUM_OPT_FLAG1} xinetd 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            ${YUM_PRG} ${YUM_OPT2}  ${YUM_OPT_FLAG1} "${CHECK_MK_DIR_AG}/${CHECK_MK_AG}" 1>> "${LOG_OUT}" 2>> "${LOG_ERROR}"

            systemctl enable xinetd
            systemctl start xinetd

        } &> /dev/null && echo -e "${GREEN}CHECK-MK ..............................OK!${NC}\n"
        
    else
        echo -e "${GREEN}CHECK-MK ..............................OK!${NC}\n"
    fi
}
```