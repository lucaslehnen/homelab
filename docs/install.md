[Voltar à raiz](../README.md)

# Instalação das ferramentas

Eu uso Ubuntu, Debian e Windows. Então o material deve funcionar tanto nas distribuições quanto no WSL do Windows 11. 

Observe que estamos instalando nas máquinas, sendo que os passos podem divergir um pouco se for configurar em uma ferramenta de CI.

## Ansible

O Ansible é um gerenciador de configuração, uma ferramenta utilizada para automatizar processos e garantir que os alvos tenham os comandos executados. Ele não armazena estado, porém conseguimos construir validações para simular isto.

*Porque utilizar?*

Tem muitos módulos, tanto *built-in* quanto da comunidade e o fato de exigir apenas uma conexão SSH, sem agente instalado, facilita demais o gerenciamento.

Utilizaremos o Ansible em dois cenários:

- Para lidar com a infra mutável, gerenciando o "estado" de servidores físicos onde não consigo automatizar a criação de uma imagem, e portanto não posso garantir a integridade do que foi descrito no manifesto;

- Para lidar com infra imutável em conjunto com o Packer e Terraform. Neste caso, ele irá atuar como provisionador, executando as tarefas dentro das máquinas temporárias ("golden images");

Para instalar, apenas segui os passos em: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

```shell
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```
No Debian 11, tive que seguir estes passos:

```
sudo apt-get install gnupg2 curl wget -y
sudo /bin/bash -c "echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu focal main' > /etc/apt/sources.list.d/ansible.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible -y
``` 

Para verificar se está ok: 
```shell
# ansible --version
ansible [core 2.11.6] 
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/ubuntu/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/ubuntu/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Sep 28 2021, 16:10:42) [GCC 9.3.0]
  jinja version = 2.10.1
  libyaml = True
```

Eu ainda aplico algumas configurações globais que acho úteis. O conteúdo a seguir pode ser colocado em `~/.ansible.cfg`: 

```ini
[defaults]
# saida yaml
stdout_callback = yaml
# Usa o stdout_callback nos comandos ad-hoc
bin_ansible_callbacks = True
# Para ignorar a checagem de identidade de hosts ssh
host_key_checking = False
``` 

### Configurações necessárias nos alvos do Ansible

Apesar do Ansible ser uma ferramenta *agent-less*, as máquinas alvo (*managed nodes*) deverão ter alguns pré-requisitos para que a máquina onde vamos rodar os playbooks (*control node*) contidos neste repositório consiga conectar nela:

- Ser acessível via SSH através de chave RSA previamente registrada. Isso [já esta documentado aqui](./2-ssh.md).;
- Deve ter um usuário com privilégios para escalar para root sem a necessidade de informar senha. Essa configuração é descrita abaixo.

O Python será instalado como pre-task nas tarefas. 
#### Como escalar para root

Primeiramente, vamos garantir a instalação do sudo:

```
apt install sudo
```

Basicamente, precisamos criar um arquivo em `/etc/sudoers.d/` com o seguinte conteúdo:
```text
lucas    ALL=(ALL:ALL) NOPASSWD:ALL    
```
Deve ter uma linha em branco no final.

Definir as permissões necessárias:
```
chmod 440 /etc/sudoers.d/lucas
```
Após reiniciar a máquina, você já deve conseguir rodar o comando `sudo su` para escalar os privilégios do seu usuário sem a necessidade de senha.

## Terraform

O Terraform é a ferramenta mais utilizada de Iac em tratando-se de cloud. Conseguimos definir de forma declarativa o que teremos de infraestrutura. Ele permite que se atue com infra imutável, onde podemos recriar todo o ambiente em segundos e garantimos que o mesmo está de acordo com os manifestos. 

Usaremos ele tanto nos provedores de cloud quanto no ambiente local de virtualização.

Para instalar, segui os passos em https://www.terraform.io/docs/cli/install/apt.html

Configuração do repositório:

```shell
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Instalação:

```shell
sudo apt install terraform
```

Validando:

```shell
# terraform --version
 Terraform v1.0.10
 on linux_amd64
```

## Packer

O Packer é uma ferramenta destinada à criação de imagens para as máquinas virtuais, seja on-premise ou no cloud. 
Muito utilizado no cloud, através de um manifesto, ele cria uma máquina temporária, faz as alterações necessárias, gera uma imagem/artefato e então remove os recursos temporários. Essa imagem gerada, depois pode ser utilizada no Terraform ao invés das imagens padrões dos provedores de nuvem. 

Em nosso ambiente, usamos ele tanto para a construção de imagens no sistema de virtualização local, quanto para os provedores de cloud.

Para instalar, segui os passos em: https://learn.hashicorp.com/tutorials/packer/get-started-install-cli

Configuração do repositório: 

```shell
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Atualizar e instalar 

```shell
$ sudo apt-get update && sudo apt-get install packer
```

Validando:

```shell
#packer --version
1.7.8
```

---
[Voltar à raiz](../README.md)