[Voltar à raiz](../README.md)

# Instalação das ferramentas

Eu uso Ubuntu, então testei os passos a seguir tanto na distribuição quanto no WSL do Windows 11. 

Observe que estamos instalando na máquina local, sendo que os passos podem divergir um pouco se for configurar em uma ferramenta de CI.

## Ansible

Apenas segui os passos em: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

```shell
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```

Para checar se esta ok: 
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

## Terraform

Segui os passos em https://www.terraform.io/docs/cli/install/apt.html

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

Segui os passos em: https://learn.hashicorp.com/tutorials/packer/get-started-install-cli

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