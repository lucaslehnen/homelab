install-vmserver:
	@echo " ---- Atualizando dependências do ansible para a instalação do servidor de vms..."
	cd install-libvirt && \
	ansible-galaxy install -r requirements.yml --force && \
	ansible-lint

install: install-vmserver
		
vmserver:
	@echo " ---- Instalando o servidor de virtualização ..."	
	cd install-libvirt && \
	ansible-playbook -i hosts site.yml

up:	vmserver

reset-vmserver:
	cd install-libvirt && \
	ansible-playbook -i hosts reset.yml

reset: reset-vmserver	
