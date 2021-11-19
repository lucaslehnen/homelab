# Laboratório pessoal 

![Ansible](https://img.shields.io/badge/Ansible->%3D2.11.5-red?logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform->%3D1.0.7-6a01eb?logo=terraform&logoColor=white)
![Packer](https://img.shields.io/badge/Packer->%3D1.7.5-blue?logo=packer&logoColor=white)
[![wakatime](https://wakatime.com/badge/github/lucaslehnen/homelab.svg)](https://wakatime.com/badge/github/lucaslehnen/homelab)

Este repositório reúne as aplicações e configurações aplicadas no meu laboratório pessoal. 
Utilizo o lab para testar tecnologias e instalar aplicações de uso diário. 

A ideia é configurar alguns hosts na nuvem e ter as minhas raspberry's locais rodando algumas aplicações. 

Apesar deste repositório não ter o intuíto de ser replicável, as partes documentadas visam trazer um exemplar de aplicabilidade de diversos recursos que poderão ser registrados em outros repositórios (Roles do ansible, Helm charts, módulos de Terraform, etc). 

## Infraestrutura atual:

Aqui especificarei de maneira macro o que estou usando no ambiente: 

![](docs/imgs/overview.png)

```
- 2 Raspberry 4 Model B - 2 GB RAM c/ MicroSD de 32 GB
- 1 Raspberry 4 Model B - 4 GB RAM c/ MicroSD de 128 GB
- 1 Switch 5 Portas
- 1 Roteador com USB para driver externo de armazenamento
- 2 SSD's Evo 850 120GB
- 120 GB HDD
- 1 PC i7 4790K / 16GB RAM 
```
### Documentação do ambiente

1. Motivadores e objetivos [[Ler...]](docs/objetivos.md)
2. Cluster K8s no ESXi:
    - Instalação e configuração do host com ESXi [[Ler...]](docs/esxi.md)
    - Geração das imagens com Packer
    - Instalação do K8s com Ansible (Provisioner)
    - Provisionamento das VMs com Terraform
    - Alternativas de virtualização
3. Cluster k8s nas Raspberrys
    - Distribuições escolhidas e pré-requisitos para conexão do Ansible
    - Configuração das distribuições Linux
    - Playbook do Ansible para instalação e configuração do Cluster K8s
4. Ambiente na cloud
    - OCI        
        - Configuração da conta
        - Recursos utilizados
        - Cluster Nomad
    - AWS
        - Configuração da conta
        - Recursos utilizados
    - Azure
        - Configuração da conta
        - Recursos utilizados    
    - GCP
        - Configuração da conta
        - Recursos utilizados
    
5. Documentação complementar
    - Ansible
    - Terraform
    - Packer
    - Linux
        - SSH
        - Sudo

## Como iniciar

Montei um arquivo `Makefile` com os comandos prontos para a gestão do ambiente. A partir dele as demais ferramentas como o Terraform, Packer, Ansible e scripts são acionadas. É necessário apenas que o `make` esteja disponível para que o restante das ferramentas sejam instalas na máquina. `install`, `up` e `down` são os comandos principais, sendo que os demais já estão embutidos neles.

 - `make install` <br>
    Faz a instalação e inicialização das ferramentas de IaC, downloads necessários na maquina local, como as collections e roles utilizadas no Ansible.;

- `make configure` <br>
    Roda o script de configuração das variáveis do ambiente    

- `make up` <br>
    Roda todos os comandos na ordem adequada para subir o ambiente COMPLETAMENTE.

 - `make down` <br>
    Desfaz as instalações realizadas no up. 

Alguns prefixos após os comandos up e down podem acionar apenas parte da automação, como por exemplo o `make up-esxi`, que irá instalar apenas as máquinas virtuais do ESXi.

A automação foi escrita para que `up` e `down` sejam idempotentes, ou seja, não tem problema fazer a chamada mais de uma vez.
## Roadmap:

Utilizarei o projeto público abaixo para organizar o roadmap de estudos e manter os reviews de recursos que foram testados ou estão no ambiente. 

https://github.com/users/lucaslehnen/projects/3/views/1

*** Se você quiser replicar o ambiente em máquinas virtuais, deve funcionar também, pois estarei testando nas arquiteturas arm64 e amd64.
## Contribuindo

Apesar deste repositório ser voltado para o meu cenário e ambiente, muitas configurações podem ser reaproveitadas e adaptadas aos mais diversos cenários. Portanto, contribuições são muito bem vindas, basta fazer um fork e abrir um PR. 
