infra:
	git pull
	terraform init
	terraform apply -auto-approve

ansible:
	git pull
	ansible-playbook -i $(tool_name)-int.ashishlavale5.online, -e ansible_user=azuser -e ansible_password=SwapnaAshish@25 tool_setup.yml -e tool_name=$(tool_name)


