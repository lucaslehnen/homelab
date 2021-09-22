install: 
	@echo " ---- Atualizando dependências do ansible...."
	cd ansible && \
	ansible-galaxy install -r requirements.yml --force
	
infra:		
	@echo " ---- Preparando a infraestrutura, sistemas base e pré-requisitos...."
	cd ansible && \
	ansible-playbook -i hosts infra.yml

k3s:
	@echo " ---- Instalando um cluster k3s...."	
	cd ansible && \
	ansible-playbook -i hosts k3s.yml

up:	infra k3s	

reset:
	cd ansible && \
	ansible-playbook -i hosts reset.yml
