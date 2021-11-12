install:
	@echo " ---- Atualizando dependências..."	
	ansible-galaxy install -r requirements.yml --force && \
	ansible-lint

up-cache-server:
	@echo " ---- Instalando o servidor de cache das isos ..."	
	ansible-playbook -i hosts vmserver.yml -t cache-server

up-vmserver:
	@echo " ---- Instalando o servidor de virtualização ..."	
	ansible-playbook -i hosts vmserver.yml -t esxi

up:	up-cache-server up-vmserver

reset-vmserver:	
	ansible-playbook -i hosts reset.yml

reset: reset-vmserver	
