ansible-run:
	cd ansible && \
	ansible-galaxy install -r requirements.yml --roles-path roles/ --force && \
	ansible-playbook -i hosts main.yml
