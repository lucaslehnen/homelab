[Voltar à raiz](../README.md)

# Comandos úteis envolvendo o libvirt

** Domínio pode ser tratado como vm

## Mais relevantes de VM

- `virsh list --all` - Mostra todos os domínios;
- `virsh edit <name>` - Edita as configurações do domínio;
- `virsh start|shutdown|reboot <name>` - Inicia/desliga/reinicia uma vm;
- `virsh suspend/resume <name>` - Suspende/resume uma vm;
- `virsh destroy <name>` - Para a VM na hora
- `virsh console <name> [--force]` - Conectar console;

## Mais relevantes de armazenamento

- `virsh pool-list` - Lista os pools;
- `virsh vol-create-as <poolname> <volumename>.qcow2 2G` - Cria um volume virtual. Caminho default é em `/var/lib/libvirt/images`;
- `virsh vol-list --pool <poolname>` - Lista os volumes
- `virsh attach-disk --domain <domainname> --source /var/lib/libvirt/images/test_vol2.qcow2 --persistent --target vdb` - Liga o volume à máquina virtual;
- `virsh detach-disk --domain test --persistent --live --target vdb` - Desvincula o volume;
 - `virsh vol-delete test_vol2.qcow2 --pool default` - Deleta um volume;

## Outros comandos de vm

- `virsh nodeinfo` - Mostra as informações do nó de virtualização;
- `osinfo-query os` - Mostra as variantes possíveis de SO;
- `virsh domrename currentname newname` - Renomeia o domínio;
- `vish save/restore <name>` - Salva/rastaura um estado;
- `virsh autostart <name> [--disable]` - Inicia ou não a vm ao iniciar o servidor; 
- `virsh dominfo <name>` - Visualiza detalhes do dominio;
- `virt-clone --connect qemu:///system --original test --name test_clone --file /var/lib/libvirt/images/test_clone.qcow2` - Clonar a VM;
- `virsh setvcpus --domain test --maximum 2 --count 2 --config` - Ajustar a CPU
- `virsh setmaxmem test 2048 --config` - Ajustar a memória
- `virsh setmem test 2GB --config` - Ajustar a memória


## Outros comandos de volume

qemu-img create -f qcow2 /var/lib/libvirt/images/${VM}-disk2.qcow2 20g

`qemu-img resize /var/lib/libvirt/images/test.qcow2 +1G` - Redimencionar um disco;

- `virsh snapshot-create-as --domain test --name "test_vm_snapshot1" --description "test vm snapshot 1-working"` - Cria um snapshot;
- `virsh snapshot-list test` - Lista snapshots;
- `virsh snapshot-info --domain test --snapshotname test_vm_snapshot1` - Descreve um snapshot;
- `virsh snapshot-revert --domain test  --snapshotname test_vm_snapshot1  --running` - Reverte para um snapshot;
- `virsh snapshot-delete --domain test --snapshotname  test_vm_snapshot1` - Deleta um snapshot
- `virt-ls -l -d allot_netxplorer_01 /root` - Listar arquivos de um local dentro da vm
- `virt-cat -d sg-ve-01 /etc/redhat-release`  - Usa o cat em um arquivo dentro da vm
- `virt-edit -d sg-ve-01 /etc/hosts` - Edita um arquivo
- Ver partições e dispositivos de bloco:

        $ sudo virt-filesystems -l -d sg-ve-01
        Name Type VFS Label Size Parent
        /dev/sda1 filesystem xfs - 20971520000 -
        /dev/sda2 filesystem xfs - 28419555328 -

        $ sudo virt-filesystems -l -h -d sg-ve-01
        Name Type VFS Label Size Parent
        /dev/sda1 filesystem xfs - 20G -
        /dev/sda2 filesystem xfs - 26G -

        $ sudo virt-filesystems -l -h -d sg-ve-01 --partitions
        Name       Type    MBR Size Parent
        /dev/sda1 partition 83 20G /dev/sda
        /dev/sda2 partition 83 26G /dev/sda
        /dev/sda3 partition 82 4.0G /dev/sda

        $ sudo virt-filesystems -d sg-ve-01 --all --long --uuid -h
        Name Type VFS Label MBR Size Parent UUID
        /dev/sda1 filesystem xfs - - 20G - 97074514-612e-4d1c-8433-935dbb3ec775
        /dev/sda2 filesystem xfs - - 26G - 8cc9e0cd-282d-46a4-9a37-069dfb93c4f2
        /dev/sda3 filesystem swap - - 4.0G - ad7dcd49-fe1a-4938-8600-f7299a59c57a
        /dev/sda1 partition - - 83 20G /dev/sda -
        /dev/sda2 partition - - 83 26G /dev/sda -
        /dev/sda3 partition - - 82 4.0G /dev/sda -
        /dev/sda device - - - 100G - -

## Exemplos

### Criação de VM

```
sudo virt-install \
--name centos7 \
--description "Test VM with CentOS 7" \
--ram=1024 \
--vcpus=2 \
--os-type=Linux \
--os-variant=rhel7 \
--disk path=/var/lib/libvirt/images/centos7.qcow2,bus=virtio,size=10 \
--graphics none \
--location $HOME/iso/CentOS-7-x86_64-Everything-1611.iso \
--network bridge:virbr0 \
--console pty,target_type=serial -x 'console=ttyS0,115200n8 serial'
```

### Exclusão de vm

Para remover toda a VM:

    sudo virsh destroy test 2> /dev/null
    sudo virsh undefine  test
    sudo virsh pool-refresh default
    sudo virsh vol-delete --pool default test.qcow2


**Fonte:** https://computingforgeeks.com/virsh-commands-cheatsheet/

---
[Voltar à raiz](../README.md)