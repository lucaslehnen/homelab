[Voltar à raiz](../README.md)

## Configurações disponíveis

Recomendo a leitura de toda a documentação para entender todas as opções no ambiente, mas abaixo trago um sumário das configurações disponíveis para habilitar ou não recursos.

Todas as ferramentas buscam as variáveis a partir deste arquivo, sendo que a automação vai jogar no formato padrão de cada ferramenta.

Um arquivo de exemplo pode ser encontrado no repositório, em `env.sample.yml` 

***Configurações de rede***

```yaml
local_network:
  CIDR: "192.168.99.0/24"
```
Esta seção define as configurações de redes virtuais ou físicas envolvidas no ambiente. 
O CIDR é utilizado para algumas configurações internas de firewall.

***Configurações de virtualização do QEMU***
```yaml
qemu:
  host: "192.168.99.30"
  # Nome da rede para bridge que será criada (tchecode.libvirt)
  bridge_network: "br0"
```
Ao definir a chave qemu, será configurado o ambiente com o libvirt/qemu no host informado. `bridge_network` é o nome da rede virtual bridge a ser criada pelas tasks, a ser utilizada na virtualização.

***Configurações de virtualização do vmware_player***
```yaml
vmware_player:
  host: "192.168.99.30"
  bundle_urls: # Conferir utls no site para download
    player: "https://download3.vmware.com/software/player/file/VMware-Player-Full-16.2.1-18811642.x86_64.bundle"
    vix: "https://download3.vmware.com/software/player/file/VMware-VIX-1.17.0-6661328.x86_64.bundle"

esxi:
  host: "192.168.99.50"
  ssh_user: "root"
  ssh_pass: "TcheCode."
```

Segue a mesma lógica do QEMU, porém este ambiente ainda não está completo. Tarefa para o futuro.

***Configurações de clusters do Kubernetes***
```yaml
k8s:
  qemu:
    flavor: k3s
    server:
      - "192.168.99.31"
      - "192.168.99.32"
      - "192.168.99.33"  
    client:
      - "192.168.99.34"
      - "192.168.99.35"
      - "192.168.99.36"
      - "192.168.99.37"
  esxi:
    flavor: k3s
    server: 
      - "192.168.99.51"
      - "192.168.99.52"
      - "192.168.99.53"
    client:
      - "192.168.99.54"
      - "192.168.99.55"
      - "192.168.99.56"
      - "192.168.99.57"
  raspberrys:
    flavor: k3s
    server:
      - "192.168.99.11"
    client:
      - "192.168.99.12"
      - "192.168.99.13"
```

Aqui basta definir quais clusters serão gerenciados (qemu, esxi ou raspberrys). Pode ser um, ou todos. Nunca utilizar o mesmo ip para server e cliente, nem para mais de um cluster.

Pode ser especificado três sabores: 
 - k3s - Rancher
 - k0s - Mirantis
 - k8s - Vanilla / via Kubeadm

---

Próximo Tópico: [Overview da infraestrutura local](infra_local.md)

---
[Voltar à raiz](../README.md)