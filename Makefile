install:
	@echo " ---- Atualizando dependências do Ansible (Roles e Collections) ..."
	cd local && \
	ansible-galaxy install -r requirements.yml --force

up-vms:				
	@echo " ---- Rodando o playbook ..."
	cd local && \
	ansible-playbook -i hosts.yml site.yml --extra-vars "@../env.yml"

up:	up-vms up-rasps	

reset:
	@echo " ---- Revertendo as alterações do playbook ..."
	cd local && \
	ansible-playbook -i hosts.yml reset.yml --extra-vars "@../env.yml"