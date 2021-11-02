[Voltar à raiz](../README.md)

# Configurando chave SSH

Ao criar um par de chaves SSH e registrar a pública nos servidores, podemos conectar a partir da nossa máquina (ou de onde for necessário) sem solicitar senhas.

Para que o playbook Ansible consiga conectar nos alvos, é necessário que eles tenham esta chave pública registrada. Os passos para configurá-la estão abaixo:

## Criando as chaves

Para gerar um novo par de chaves:

```shell
ssh-keygen -C "homelab" -f ~/.ssh/homelab -t rsa -b 4096 -q -N ""
```

Neste exemplo, as chaves ficarão em `~/.ssh/homelab`.

Para facilitar, podemos fazer essa chave ser carregada pelo ssh-agent, assim não precisando citar a mesma nas conexões. 

Primeiro, confirme que o agent está rodando:

```shell
# eval "$(ssh-agent -s)"
Agent pid 6707
``` 

Então adicionamos à chave:
```
ssh-add ~/.ssh/homelab
```

## Registrando as chaves para acesso SSH remoto

Com o par de chaves criado, podemos registrar a chave pública no servidor alvo remoto. Isso permitirá que acessemos nossos servidores sem a necessidade de inserir suas senhas. 

Se o acesso já pode ser feito normalmente com senha, podemos executar o seguinte comando para registrar a chave pública no servidor remoto:

```shell
ssh-copy-id -i ~/.ssh/homelab.pub lucas@192.168.99.30
```

Você será solicitado a colocar a sua senha para acessar o servidor. O retorno deve ser algo semelhante à isto:

```
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/ubuntu/.ssh/homelab.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
lucas@192.168.99.30's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'lucas@192.168.99.30'"
and check to make sure that only the key(s) you wanted were added.
```

Como descrito, a partir de agora, o servidor pode ser acessado sem senha, apenas validando a chave RSA. O mesmo ainda pode ser acessado via senha, mas a configuração para desabilitar este comportamento podemos deixar para a automação com Ansible.

---
[Voltar à raiz](../README.md)