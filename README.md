# Laboratório pessoal 

<img src="https://img.shields.io/badge/Ansible->%3D2.11.5-red?style=for-the-badge&logo=ansible&logoColor=white" alt="Ansible">
<img src="https://img.shields.io/badge/Terraform->%3D1.0.7-6a01eb?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
<img src="https://img.shields.io/badge/Packer->%3D1.7.5-blue?style=for-the-badge&logo=packer&logoColor=white" alt="Packer">

Este repositório reúne as aplicações e configurações aplicadas no meu laboratório pessoal. 
Utilizo o lab para testar tecnologias e instalar aplicações de uso diário. 

A ideia é configurar alguns hosts na nuvem e ter as minhas raspberry's locais rodando algumas aplicações. 

Apesar deste repositório não ter o intuíto de ser replicável, as partes documentadas visam trazer um exemplar de aplicabilidade de diversos recursos que poderão ser registrados em outros repositórios (Roles do ansible, Helm charts, módulos de Terraform, etc). 

## Roadmap:

Utilizarei o projeto público abaixo para organizar o roadmap de estudos e manter os reviews de recursos que foram testados ou estão no ambiente. 

https://github.com/users/lucaslehnen/projects/3/views/1

*** Se você quiser replicar o ambiente em máquinas virtuais, deve funcionar também, pois estarei testando nas arquiteturas arm64 e amd64.

## Infraestrutura atual:

Aqui especificarei de maneira macro o que estou usando no ambiente: 
```
[X] 2 Raspberry 4 Model B - 2 GB RAM c/ MicroSD de 32 GB
[X] 1 Raspberry 4 Model B - 4 GB RAM c/ MicroSD de 128 GB
[X] 1 Switch 5 Portas
[X] 1 Roteador com USB para driver externo de armazenamento
[X] 1 SSD's Evo 850 120GB
[X] 1 PC i7 4790K / 16GB RAM / 120 SSD (expansível)
```
### Desenho do ambiente

![](docs/overview.png)

No meu desktop, eu instalei o Debian, e configurei máquinas virtuais nele. Como as vezes uso este computador para trabalhar ou jogar, o cluster de máquinas virtuais não ficará sempre online (Normalmente estou do meu notebook).

## Contribuindo

Apesar deste repositório ser voltado para o meu cenário e ambiente, muitas configurações podem ser reaproveitadas e adaptadas aos mais diversos cenários. Portanto, contribuições são muito bem vindas, basta fazer um fork e abrir um PR. 
