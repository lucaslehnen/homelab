# Laboratório pessoal 

Este repositório reúne as aplicações e configurações aplicadas no meu laboratório pessoal. Utilizo o lab para testar tecnologias e instalar aplicações de uso diário. 

A ideia é configurar alguns hosts na nuvem e ter as minhas raspberry's locais rodando algumas aplicações. 

O código que pode ser reaproveitado ficará em repositórios específicos, sendo apenas mencionados aqui, assim como as configurações exclusivas do meu ambiente. Portanto, apesar deste repositório não ter o intuíto de ser replicável em outro local, as partes documentadas visam trazer um exemplar de aplicabilidade dos demais repositórios (Roles do ansible, Helm charts, módulos de Terraform, etc). 

Todo o CI/CD das aplicações e infraestrutura do ambiente ficará neste repositório, exceto as automações locais iniciais, como a playbook Ansible que provisiona os clusters Kubernetes nas raspberrys.

## Roadmap:

Utilizarei o projeto público abaixo para manter o roadmap e reviews testados no ambiente. 

https://github.com/users/lucaslehnen/projects/2

## Infraestrutura atual:

Aqui especificarei de maneira macro o que estou usando no ambiente: 
```
[X] 2 Raspberry 4 Model B - 2 GB RAM c/ MicroSD de 32 GB
[X] 1 Raspberry 4 Model B - 4 GB RAM c/ MicroSD de 128 GB
[X] 1 Switch 5 Portas
[X] 2 SSD's Evo 850 120GB (Ligado via USB)
[X] 1 HDD 1 TB Samsung (Ligado via USB)
```
## Preparação do ambiente:

Irei presumir que você usa um Linux, e ou o WSL do Windows em sua máquina. 
Abaixo segue algumas configurações que foram realizadas no ambiente que não são comtempladas na automação deste repositório:

- Ajustei a minha subnet para o segmento 192.168.99.0/24;
- Defini um servidor virtual em meu roteador para o ip 192.168.99.10. Todo o tráfego externo passa por ele na porta 80/443;
- Configurei um dns dinâmico No-IP e configurei no roteador;
- Apontei o dns `lab.tchecode.com.br` via CNAME na Cloudflare para este DNS dinâmico;
- Preparei o Ubuntu nos MicroSDs das raspberrys:
    - Baixei a imagem do Ubuntu Server 20.04.3 LTS arm64 em 
        https://ubuntu.com/download/raspberry-pi/thank-you?version=20.04.3&architecture=server-arm64+raspi
    - Utilizei o software `Imager` para gravar a imagem do Ubuntu pré-instalado. O Software pode ser baixado em
        https://www.raspberrypi.org/software/    
    - Setei os seguintes ip's das raspberrys, assim que gravei o MicroSD, editando o arquivo `network-config`, com a seguinte estrutura:

        ```yaml
        version: 2
        ethernets:
        eth0:
            dhcp4: false
            optional: true
            addresses: [192.168.99.11/24]
            gateway4: 192.168.99.1
            nameservers:
            addresses: [8.8.8.8,8.8.4.4]
        ```
    - Utilizei os seguintes IP's:
        - 192.168.99.11
        - 192.168.99.12
        - 192.168.99.13        
- Na raspberry de 4GB, coloquei o MicroSD de 128GB, onde setei o IP `192.168.99.11` e conectei o HDD de 1TB via USB;
- Nas demais raspberrys coloquei os MicroSDs de 32 GB e conectei os SSDs de 128GB via USB; 

- Uma vez ligadas as raspberrys, acessei as mesmas via SSH, nos ips acima, usando o usuário padrão `ubuntu`: 
```
ssh ubuntu@192.168.99.11
```
- Ao entrar pela primeira vez, o ubuntu solicita a troca de senha. Conectei nas três e setei uma senha;
- A seguir, criei uma chave SSH para acessa-las sem a necessidade de usar a senha:
    - Primeiro crio o par de chaves e adiciono a chave privada no ssh-agent:
        ```
        ssh-keygen -f ~/.ssh/raspberrys -N "" -C "Chave de acesso às Raspberrys"
        ssh-add ~/.ssh/raspberrys
        ```
        ** Pode ser necessário iniciar o agent em segundo plano, via `eval "$(ssh-agent -s)"`.
    - Depois registro a chave pública nas raspberrys:
        ```
        ssh-copy-id -i ~/.ssh/raspberrys.pub ubuntu@192.168.99.11
        ```
    - A partir deste momento, já deve ser possível conectar ao ambiente sem o uso de senha, e os próximos passos podem ser executados pela automação;

## Instalando o ambiente via IaC

O Terraform é utilizado para a infraestrutura de Cloud, o Packer para construir imagens customizadas e o Ansible como gerenciador de configuração e provisionador na infra local (raspberrys). 

Links das ferramentas:

- https://www.terraform.io/
- https://www.packer.io/
- https://docs.ansible.com/ansible/latest/installation_guide/index.html

É necessário ter o Ansible instalado na máquina. Para tal, conferir os passos de instalação aqui: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Montei um arquivo `Makefile` com os principais comandos do ambiente: 

 - `make install` <br>
    Faz a inicialização das ferramentas de IaC e downloads necessário na maquina local, como as collections e roles utilizadas no Ansible;

 - `make commom-local`<br>
    Roda tarefas de otimização dos hosts, como desabilitar recursos não utilizados, configurar módulos de kernel, setar hostnames, etc.

 - `make k3s`<br>
    Instala o k3s no cluster via Playbook Ansible

 - `make up` <br>
    Roda todos os comandos acima para subir o ambiente completamente

 - `make down` <br>
    Desfaz as instalações realizadas no up. 

