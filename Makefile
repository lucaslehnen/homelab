install: 
	@echo " ---- Atualizando dependências do ansible...."
	cd ansible && \
	ansible-galaxy install -r requirements.yml --force && \
	ansible-lint
	
infra:		
	@echo " ---- Preparando a infraestrutura, sistemas base e pré-requisitos...."
	cd ansible && \
	ansible-playbook -i hosts site.yml -t infra

k3s:
	@echo " ---- Instalando um cluster k3s...."	
	cd ansible && \
	ansible-playbook -i hosts site.yml -t k3s

up:	infra k3s	

reset:
	cd ansible && \
	ansible-playbook -i hosts reset.yml
