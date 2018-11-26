# Função [config_profile_omd]

Função para configuração do arquivo .profile do usuário do site do sistema
de monitoramento.


### Template

Template do arquivo .profile.

```bash
cat << EOF > /omd/sites/${SITE}/.profile

export OMD_SITE=${SITE}
export OMD_ROOT=/omd/sites/${SITE}

PATH=\${OMD_ROOT}/local/bin:\${OMD_ROOT}/bin:\${OMD_ROOT}/local/lib/perl5/bin:\${PATH}
export LD_LIBRARY_PATH=\${OMD_ROOT}/local/lib:\${OMD_ROOT}/lib:/u01/app/oracle/product/${DB_VERSION}/${DB_HOME_SOFT}/lib:/lib:/usr/lib
export ORACLE_HOME=/u01/app/oracle/product/${DB_VERSION}/${DB_HOME_SOFT}
export ORACLE_SID=${DB_INSTANCE}

# enable local perl env
export PERL5LIB="\${OMD_ROOT}/local/lib/perl5/lib/perl5:\${OMD_ROOT}/lib/perl5/lib/perl5:\${PERL5LIB}"
export PATH="\${OMD_ROOT}/lib/perl5/bin:\${PATH}"
export MODULEBUILDRC="\${OMD_ROOT}/.modulebuildrc"
export PERL_MM_OPT=INSTALL_BASE="\${OMD_ROOT}/local/lib/perl5/"
export MANPATH="\${OMD_ROOT}/share/man:\${MANPATH}"
export PYTHONPATH="\${OMD_ROOT}/lib/python:\${OMD_ROOT}/local/lib/python"
export MAILRC="${OMD_ROOT}/etc/mail.rc"


if [ -f \${OMD_ROOT}/etc/environment ]
then
    eval \$(egrep -v '^[[:space:]]*(#|$)' < \${OMD_ROOT}/etc/environment | sed 's/^/export /')
fi

# Only load bashrc when in a bash shell and not loaded yet.
# The load once is ensured by the variable \${BASHRC}.
if [ "\${BASH}" -a -s \${OMD_ROOT}/.bashrc -a -z "\${BASHRC}" ]; then
    . \${OMD_ROOT}/.bashrc
fi

EOF
```

### Função completa de configuração do profile

```bash
config_profile_omd()
{
cat << EOF > /omd/sites/${SITE}/.profile

export OMD_SITE=${SITE}
export OMD_ROOT=/omd/sites/${SITE}

PATH=\${OMD_ROOT}/local/bin:\${OMD_ROOT}/bin:\${OMD_ROOT}/local/lib/perl5/bin:\${PATH}
export LD_LIBRARY_PATH=\${OMD_ROOT}/local/lib:\${OMD_ROOT}/lib:/u01/app/oracle/product/${DB_VERSION}/${DB_HOME_SOFT}/lib:/lib:/usr/lib
export ORACLE_HOME=/u01/app/oracle/product/${DB_VERSION}/${DB_HOME_SOFT}
export ORACLE_SID=${DB_INSTANCE}

# enable local perl env
export PERL5LIB="\${OMD_ROOT}/local/lib/perl5/lib/perl5:\${OMD_ROOT}/lib/perl5/lib/perl5:\${PERL5LIB}"
export PATH="\${OMD_ROOT}/lib/perl5/bin:\${PATH}"
export MODULEBUILDRC="\${OMD_ROOT}/.modulebuildrc"
export PERL_MM_OPT=INSTALL_BASE="\${OMD_ROOT}/local/lib/perl5/"
export MANPATH="\${OMD_ROOT}/share/man:\${MANPATH}"
export PYTHONPATH="\${OMD_ROOT}/lib/python:\${OMD_ROOT}/local/lib/python"
export MAILRC="${OMD_ROOT}/etc/mail.rc"


if [ -f \${OMD_ROOT}/etc/environment ]
then
    eval \$(egrep -v '^[[:space:]]*(#|$)' < \${OMD_ROOT}/etc/environment | sed 's/^/export /')
fi

# Only load bashrc when in a bash shell and not loaded yet.
# The load once is ensured by the variable \${BASHRC}.
if [ "\${BASH}" -a -s \${OMD_ROOT}/.bashrc -a -z "\${BASHRC}" ]; then
    . \${OMD_ROOT}/.bashrc
fi

EOF

echo -e "${GREEN}Profile OMD ...........................OK!${NC}\n"
}
```