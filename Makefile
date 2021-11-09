install-vmserver:
	@echo " ---- Atualizando dependências do ansible para a instalação do servidor de vms..."
	cd install-libvirt && \
	ansible-galaxy install -r requirements.yml --force && \
	ansible-lint

install: install-vmserver

up-vmserver:
	@echo " ---- Instalando o servidor de virtualização ..."
	cd vmserver && \
	ansible-playbook -i hosts site.yml

up:	up-vmserver

reset-vmserver:
	cd install-esxi && \
	ansible-playbook -i hosts reset.yml

reset: reset-vmserver	
