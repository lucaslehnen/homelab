[Voltar à raiz](../README.md)

# Configuração do Sudo

Eu uso Ubuntu, Debian e Windows. Então o material deve funcionar tanto nas distribuições quanto no WSL do Windows 11. 

Observe que estamos instalando nas máquinas, sendo que os passos podem divergir um pouco se for configurar em uma ferramenta de CI.

## Como escalar para root

O sudo permite que um usuário se passe por um administrador e possa executar tarefas administrativas. Desta maneira, meu usuário `lucas` poderá executar comandos que antes apenas o `root` conseguia. 

Primeiramente, vamos garantir a instalação do sudo, em algumas distros ele não vem pré-instalado:

```
apt install sudo
```

Basicamente, precisamos criar um arquivo em `/etc/sudoers.d/` com o seguinte conteúdo:
```text
lucas    ALL=(ALL:ALL) NOPASSWD:ALL    
```
Deve ter uma linha em branco no final.

Definir as permissões necessárias:
```
chmod 440 /etc/sudoers.d/lucas
```
Após reiniciar a máquina, você já deve conseguir rodar o comando `sudo su` para escalar os privilégios do seu usuário sem a necessidade de senha.

---
[Voltar à raiz](../README.md)