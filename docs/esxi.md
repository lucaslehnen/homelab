[Voltar à raiz](../README.md)

# Servidor de VMs com ESXI

Esta seção demonstra como foi realizada a configuração do servidor de máquinas virtuais com ESXI. 

Outras alternativas de virtualização podem ser vistas [aqui](./esxi-alternativas.md).

Hardware disponível:
  - Motherboard Z97X-SLI
  - 16GB de RAM DDR3
  - Processador i7 4790K
  - SSD de 120GB ( via usb para dedicar ao sistema operacional ).     

Como esse não é um hardware para servidor e as minhas tentativas de instalar o virtualizador da VMWare diretamente no SSD falharam. Assim como para rodar no Qemu e no Virtual box, em ambos tive problemas de compatibilidade do hardware virtual. A saída então foi colocar o VMWare Workstation Player dentro de uma instalação do Debian no SSD. 

Claro que não é um ambiente para produção e a performance deixa a desejar, mas é suficiente para os experimentos com Packer e Terraform no ESXi, meu principal objetivo. 

** Esse computador eu uso para jogos e trabalho também, tenho outros HDDS e SSDs que poderia utilizar, assim como uma GTX 1080 Ti, que em algum momento quero utilizar em cálculos.

## Preparando o Debian 

O Debian 11 foi uma escolha pessoal, ele vem com poucos serviços de largada, então achei interessante para economizar RAM para a máquina virtual, mas a princípio pode ser qualquer distro. Os passos aqui descritos serão os aplicados para o Debian.

Como a instalação dele na máquina é muito simples, eu não quis automatizar a mesma. Quando quis refazer, coloquei no pendrive e formatei.

Coloquei a interface LXDE nele, pois como resolvi fazer tudo manualmente, quero uma interface gráfica para configurar o Player. O LXDE é uma interface leve, então ficou ocupando uns 300MB de RAM apenas, sobrando mais para a virtualização. 

Algumas coisas que já fiz no processo de instalação do Debian ou no pós-instalação (manual):
 - Desmarquei todos os pacotes extras na instalação, deixei apenas o servidor ssh e o LXDE;
 - Defini o usuário `lucas` com a senha que queria;
 - Setei o IP para estático `192.168.99.30`;
 - Registrei a chave SSH que eu havia criado na minha máquina. Detalhes [aqui](./ssh.md).
 - Ajustei os privilégios de escalação para root, conforme especificado [aqui](./sudo.md). 

Com isso, já posso executar o Ansible futuramente. 

## Por que não automatizar a instalação do ESXi e do VMWare Player

Até tentei, com o objetivo de consolidar mais rapidamente o ambiente do zero, porém a VMWare não distribui os produtos de forma que facilite isso, então tive que fazer manualmente mesmo. 

**VMWare Player**

A instalação do Player eu fiz toda manual, desde o download até a instalação do mesmo. Assim como a criação da VM para o ESXi. 

**ESXi**

Já para o ESXi, eu montei um arquivo de kickstart que faz a instalação automatizada, selecionando os passos durante a instalação, bastando apenas colocar o caminho do arquivo no inicio da instalação. 

Acredito que o conhecimento utilizado para automatizar isso pouco me ajudaria no futuro, portanto resolvi não perder muito tempo e focar o IaC apenas em cima do ESXi, trazendo um cenário de uso próximo ao utilizado no Cloud.

## Instalando o VMWare Worsktation Player

O programa tem algumas dependências que devem ser instaladas:

```
sudo apt-get install build-essential linux-headers-`uname -r`
```

Agora vamos fazer o download do arquivo `.bundle` no site: https://www.vmware.com/products/workstation-player.html

![](imgs/player.png)

Então, aplicamos a permissão de execução e executamos o arquivo como root:

```
sudo chmod +x VMware-Player-Full-16.2.1-18811642.x86_64.bundle
sudo sh VMware-Player-Full-16.2.1-18811642.x86_64.bundle
```

Se precisar desinstalar:

``` 
sudo sh VMware-Player* --uninstall-product vmware-player
```

## Baixando o ESXi 

Fiz o download da iso do ESXI 7 update 3 no [site da VMWare](https://customerconnect.vmware.com/group/vmware/evalcenter?p=free-esxi7).

** É necessário uma conta.

![](imgs/download-esxi.png)

Montei um arquivo de kickstart para a instalação, junto com um template Packer para outras alternativas de virtualização do ESXi. 
Mais detalhes no repositório do [template Packer para o ESXi](https://github.com/lucaslehnen/packer-esxi).

## Criando a VM para o ESXi

## Sobre o IaC

Montei um playbook Ansible para a instalação do libvirt e qemu, preparando a VM para o ESXI. Ele faz as seguintes alterações: 
- Instala um Ngix para usar como servidor http para as isos de instalação
- Usando a collection do Ansible [tchecode.libvirt](https://github.com/lucaslehnen/tchecode.libvirt):
  - Instala os pacotes do libvirt;
  - Instala pacotes de utilitários para administração de vms no qemu;
  - Configura uma rede bridge para uso nas vms (assim consigo usar a minha rede LAN);
- <s>Usando o template Packer em https://github.com/lucaslehnen/packer-esxi-qemu:
   - Clona o repositório do template;
   - Builda uma imagem `qcow2` do ESXi;</s>
   - Não está funcionando. Em seu lugar, automatizei os passos que o Packer faria manualmente no Ansible com libvirt. O resultado ainda é o mesmo, porém, o libvirt cria a VM de uma maneira distinta, fazendo com que a mesma funcione, diferente do builder do Packer. Esse mesmo comando já roda a VM. No futuro, quando conseguir executar com o Packer, a VM pode ser provisionada com Terraform;  

Separei alguns comandos úteis para a administração da vm do libvirt [aqui](./4-libvirt-commands.md). 


### Customizando a ISO

A forma que achei para automatizar 100% a instalação, exige a modificação da ISO padrão, adicionando o arquivo de *kickstart* dentro da mesma. Isso também ficou dentro do Ansible. 

A única coisa que precisamos é ter a imagem original do esxi. Como tem a questão de licença e o download oficial precisa de conta, a iso eu coloquei em um ftp pessoal e a licença é atribuída após a instalação, manualmente, em `Manage/Licensing\Assign Licence`. Tem 60 dias pra usar de boas sem licença, mas lembrando que de qualquer forma é free.

A partir daí, é só configurar as variáveis do Ansible e rodar o make up-vmserver.

https://www.qemu.org/docs/master/system/invocation.html


Fonte:

https://www.grottedubarbu.fr/nested-virtualization-esxi-kvm/


---
[Voltar à raiz](../README.md)