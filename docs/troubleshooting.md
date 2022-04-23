[Voltar à raiz](../README.md)

# Resolução de problemas

---
## Erro ao instalar as depências do Ansible no comando `make install`

```bash
lucas@lucas-ubuntu:~/Projects/homelab$ sudo make install
 ---- Atualizando dependências do Ansible (Roles e Collections) ...
cd local && \
ansible-galaxy install -r requirements.yml --force
Starting galaxy collection install process
Process install dependency map
ERROR! Unexpected Exception, this is probably a bug: CollectionDependencyProvider.find_matches() got an unexpected keyword argument 'identifier'
to see the full traceback, use -vvv
make: *** [Makefile:3: install] Erro 250
```

Um problema em um pacote mais atualizado do python ainda sem correção: 
https://groups.google.com/g/linux.debian.bugs.dist/c/QryPBWZfjPQ

Alternativa: Fazer o downgrade do pacote resolvelib==0.8.1 para a versão 0.5.4

Baixei o pip:
```bash
sudo apt install python3-pip
```

Fiz o downgrade do pacote para uma versão que funciona:
 ```bash
 pip install -Iv resolvelib==0.5.4
 ```

---
[Voltar à raiz](../README.md)