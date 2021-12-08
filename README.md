# Laboratório pessoal 

![Ansible](https://img.shields.io/badge/Ansible->%3D2.11.5-red?logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform->%3D1.0.7-6a01eb?logo=terraform&logoColor=white)
![Packer](https://img.shields.io/badge/Packer->%3D1.7.5-blue?logo=packer&logoColor=white)
[![wakatime](https://wakatime.com/badge/github/lucaslehnen/homelab.svg)](https://wakatime.com/badge/github/lucaslehnen/homelab)

Este repositório reúne as aplicações e configurações aplicadas no meu laboratório pessoal. 
Utilizo o lab para testar tecnologias e instalar aplicações de uso diário. 

A ideia é configurar alguns hosts na nuvem e ter as minhas raspberry's locais rodando algumas aplicações. 

Apesar deste repositório não ter o intuíto de ser replicável, as partes documentadas visam trazer um exemplar de aplicabilidade de diversos recursos que poderão ser registrados em outros repositórios (Roles do ansible, Helm charts, módulos de Terraform, etc). 

### Documentação do ambiente

- Motivadores e objetivos [...Ler...](docs/objetivos.md)
- Configurações [...Ler...](docs/config.md)
- Ambiente local:
    - Overview da infra local [...Ler...](docs/infra_local.md)    
    - Instalação e configuração do Desktop [...Ler...](docs/desktop.md)
    - Instalação e configuração das Raspberrys
- Ambiente na cloud:
    - Overview das Clouds
    - Instalação e configuração da OCI (Oracle Cloud Infrastructure)
    - Instalação e configuração da AWS (Amazon Web Services)
    - Instalação e configuração da Azure (Microsoft)
    - Instalação e configuração da GCP (Google Cloud Platform)
- Documentação complementar
    - Configuração de sudo  [...Ler...](docs/sudo.md)    
    - Configuração do SSH  [...Ler...](docs/ssh.md)
    - Instalação das ferramentas [...Ler...](docs/install.md)

## Como subir o ambiente

Um playbook Ansible controla o lançamento de todo o ambiente descrito na documentação. Ou seja, os ambientes de virtualização nas máquinas locais, a instalação dos clusters e a preparação da nuvem para receber as aplicações. 

As aplicações em si, ficam em repositórios específicos de lançamento no Github.
No CI/CD destes repositórios de apps é que será configurado o deploy para lançamento das mesmas. 

Antes de executar o playbook, são necessários alguns passos:

```
$ apt install build-essential
```

As máquinas alvo já devem estar com o acesso SSH configurado, conforme [esta documentação](docs/ssh.md)

O Ansible, Terraform e Packer também são requeridos. Informações de como instalá-los estão [aqui](doc/install.md).

As configurações estão centralizadas no arquivo `env.yml`. Disponibilizei um arquivo sample junto no repositório para auxiliar. 

Mais detalhes sobre as opções a serem configuradas podem ser vistas [aqui](docs/config.md).

A partir do arquivo `Makefile`, as demais ferramentas como o Terraform, Packer, Ansible e scripts são acionadas. `install`, `up` e `down` são os comandos principais, sendo que comandos parciais podem ser embutidos neles.

 - `make install` <br>
    É a primeira coisa a se fazer, provavelmente você só vai fazê-lo uma vez.    
    Faz a instalação e inicialização das ferramentas de IaC, downloads necessários na maquina local, como as collections e roles utilizadas no Ansible.;

- `make up` <br>
    Roda todos os comandos na ordem adequada para subir o ambiente COMPLETAMENTE.

 - `make down` <br>
    Desfaz as instalações realizadas no up. 

Alguns prefixos após os comandos up e down podem acionar apenas parte da automação, como por exemplo o `make up-desktop`, que irá executar apenas as plays referentes ao desktop.

A automação foi escrita para que os comandos sejam idempotentes, ou seja, não tem problema fazer a chamada mais de uma vez, é inclusive, recomendado para confirmar que a configuração está conforme esperado.
## Contribuindo

Apesar deste repositório ser voltado para o meu cenário e ambiente, muitas configurações podem ser reaproveitadas e adaptadas aos mais diversos cenários. Portanto, contribuições são muito bem vindas, basta fazer um fork e abrir um PR. 
