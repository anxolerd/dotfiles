.PHONY: help apps rebuild userspace

help:
	@echo "@anxolerd's dotfiles"
	@echo "Usage: "
	@echo "	help		Display this message"
	@echo "	.venv		Create python virtual environment and install required packages into it"
	@echo "	apps		Install apps"
	@echo "	rebuild		Rebuild @world (upgrade)"
	@echo "	userspace	Configure userspace (shell, editor, etc)"

.venv:
	python3 -m venv ./.venv
	. ./.venv/bin/activate
	pip install ansible
	deactivate

apps: .venv
	. ./.venv/bin/activate
	ansible-playbook -DvK install-apps.yml


rebuild: .venv
	. ./.venv/bin/activate
	ansible-playbook -DvK rebuild-world.yml


userspace: .venv
	. ./.venv/bin/activate
	ansible-playbook -Dv configure-userspace.yml
