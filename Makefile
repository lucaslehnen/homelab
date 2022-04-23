install:
	@echo " ---- Atualizando dependências do Ansible (Roles e Collections) ..."
	cd local && \
	ansible-galaxy install -r requirements.yml --force

up:
	cd local && \
	ansible-playbook -i hosts.yml site.yml --extra-vars "@../env.yml"

down:
	@echo " ---- Revertendo as alterações do playbook ..."
	cd local && \
	ansible-playbook -i hosts.yml reset.yml --extra-vars "@../env.yml"