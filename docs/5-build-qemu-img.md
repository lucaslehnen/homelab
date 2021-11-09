[Voltar à raiz](../README.md)

# Construindo a imagem base para as máquinas virtuais

Com o servidor de máquinas virtuais ok, precisamos construir uma imagem base para rodar as vms. 
Foram construídas três imagens: uma do Debian, uma do Ubuntu e um da CentOS. 

Antes de iniciar, é necessário que o [Packer já esteja instalado](./1-install.md#packer).

## Escolhendo as imagens base

Nos provedores de cloud, normalmente temos as imagens já preparadas para utilizar como base, "pré-instaladas". Mas e no on-premise?

Procurando sobre, cheguei nos repositórios de imagens de cloud das distribuições. As imagens ali, são preparadas para uma instalação não assistida, e portanto, indicadas para este fim. 

**Repositório do Debian:**

- https://cloud.debian.org/images/cloud/

**Repositório do CentOS**

- https://cloud.centos.org/centos/8/x86_64/images/


**Repositório do Ubuntu**

- https://cloud-images.ubuntu.com/



Fontes:

- https://github.com/tylert/packer-build

---
[Voltar à raiz](../README.md)