install:
	@echo " ---- Atualizando dependências..."	
	ansible-galaxy install -r requirements.yml --force && \
	ansible-lint

up-cacheserver:
	@echo " ---- Instalando o servidor de cache das isos ..."	
	ansible-playbook -i hosts vmserver.yml -t cache-server

up-libvirt:
	@echo " ---- Instalando o libvirt ..."	
	ansible-playbook -i hosts vmserver.yml -t libvirt

up-esxi:
	@echo " ---- Instalando o esxi ..."	
	ansible-playbook -i hosts vmserver.yml -t esxi

up-vmserver: 
	@echo " ---- Instalando o servidor de virtualização ..."		
	ansible-playbook -i hosts vmserver.yml -t vmserver

up:	
	@echo " ---- Subindo tudo ..."	
	ansible-playbook -i hosts vmserver.yml 

reset:
	ansible-playbook -i hosts reset.yml