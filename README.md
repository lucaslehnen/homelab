# Laboratório pessoal 

Este repositório reúne as aplicações e configurações aplicadas no meu laboratório pessoal.Utilizo o lab para testar tecnologias e instalar aplicações de uso diário. 

A ideia é configurar alguns hosts na nuvem e ter as minhas raspberry's locais rodando permanentemente. Recursos temporários para testes ficarão comentados. 

O código que pode ser reaproveitado ficará em repositórios específicos, sendo apenas mencionados aqui, assim como as configurações exclusivas do meu ambiente. Portanto, apesar deste repositório não ter o intuíto de ser replicável em outro local, as partes documentadas visam trazer um exemplar de aplicabilidade dos demais repositórios. 

Todo o CD do ambiente fica neste repositório.

## Roadmap:

Utilizarei o projeto público abaixo para manter o roadmap e reviews testados no ambiente. 

https://github.com/users/lucaslehnen/projects/2

## Infraestrutura atual:

Aqui especificarei de maneira macro o que estou usando no ambiente: 
```
[X] 2 Raspberry 4 Model B - 2 GB RAM
[X] 1 Raspberry 4 Model B - 4 GB RAM
[X] 1 Switch 5 Portas
[X] 2 SSD's Evo 850 120GB (Ligado via USB)
[X] 1 HDD 1 TB Samsung (Ligado via USB)
[~] 6 VM's 2 vCPU 2 GB RAM
```

Nuvem:

```
[~] 2 VM OCI 1/8 oCPU 1 GB RAM
```

## Preparação do ambiente:

Algumas predefinições que fiz ao meu ambiente que não estão no IaC ou que só se aplicam à este ambiente:

- De rede:
    - Ajustei a minha subnet para o segmento 192.168.99.0/24;
    - Defini um servidor virtual em meu roteador para o ip 192.168.99.10. Todo o tráfego externo passa por ele na porta 80;
    - Configurei um dns dinâmico no no-ip e configurei no roteador;
    - Apontei o dns `lab.tchecode.com.br` via CNAME na Cloudflare para este DNS dinâmico;
- Nas raspberry's:
    - Os hostnames ficaram rp-k3s-01, rp-k3s-02 e rp-k3s-03;
    - A Raspberry de 4 GB de RAM é a rp-k3s-01, nela também ficou o MicroSD de 128GB;
    - O HDD de 1 TB ficou na rp-k3s-01, montado em /backup;
    - Os SSD's foram ligados via USB nas rp-k3s-02 e rp-k3s-03. 
    - Todas tem uma pasta /dados de 80GB, que fora criada para uso dos volumes de containers. A ;

## Sources

- https://cloudinit.readthedocs.io/en/latest/topics/boot.html#generator
- https://www.blackmoreops.com/2019/04/19/remove-cloud-init-from-ubuntu/