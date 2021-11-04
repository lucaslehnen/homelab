[Voltar à raiz](../README.md)

# Servidor de VMs com libvirt

Esta seção demonstra como foi realizada a configuração do servidor de máquinas virtuais com libvirt. 

Possuo um desktop de 16GB de RAM e processador i7 4790K. Pluguei um SSD de 120GB via usb e instalei nele o Debian 11, sem afetar os outros sistemas operacionais que tenho. Além disso, coloquei o libvirt e ajustei algumas configurações para otimizar o seu uso para as máquinas virtuais.

O ambiente foi automatizado utilizando Ansible, Packer e Terraform. O que não pode ser automatizado, está descrito logo abaixo no tópico de Pré-requisitos. 

## Pré-requisitos para o Ansible

O Debian 11 foi uma escolha pessoal, ele vem com poucos serviços de largada, então achei interessante para economizar RAM para as máquinas virtuais, mas a princípio pode ser qualquer distro. Os passos aqui descritos serão os aplicados para o Debian.

Algumas coisas que já fiz no processo de instalação dele ou no pós-instalação:
 - Defini o usuário `lucas` com a senha que queria;
 - Setei o IP para estático `192.168.99.30`;
 - Criei previamente um par de chaves RSA em `~/.ssh/homelab`. Os passos para registrar a chave e permitir o acesso sem senha estão [aqui](./2-ssh.md).
 - Ajustei os privilégios de escalação para root, conforme especificado [aqui](./1-install.md#como-escalar-para-root).

## O que o playbook faz

São dois playbooks, um que monta a estrutura (`site.yml`) e um que desmonta (`reset.yml`): 

- Instala os pacotes do libvirt;
- Instala pacotes de utilitários para administração das vms;
- Configura uma rede bridge para uso nas vms;

## Comandos úteis para o libvirt

Separei alguns comandos úteis para a administração com o libvirt [aqui](./4-libvirt-commands.md)

---
[Voltar à raiz](../README.md)