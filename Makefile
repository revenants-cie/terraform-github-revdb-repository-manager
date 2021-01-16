.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
    match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
    if match:
        target, help = match.groups()
        print("%-40s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help: install-hooks
	@python -c "$$PRINT_HELP_PYSCRIPT" < Makefile

.PHONY: install-hooks update-secrets
update-secrets:  ## Update secrets in .env.tar.enc
	tar cf .env.tar .env
	travis encrypt-file .env.tar --add
	rm .env.tar

.PHONY: install-hooks
install-hooks:  ## Install repo hooks
	@echo "Checking and installing hooks"
	@test -d .git/hooks || (echo "Looks like you are not in a Git repo" ; exit 1)
	@test -L .git/hooks/pre-commit || ln -fs ../../hooks/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit

.PHONY: test
test:  ## Run tests on the module
	pytest -xvvs tests/


.PHONY: bootstrap
bootstrap: ## bootstrap the development environment
	pip install -U "pip ~= 20.1"
	pip install -U "setuptools ~= 46.1"
	pip install -r requirements.txt

.PHONY: clean
clean: ## clean the repo from cruft
	rm -rf .pytest_cache
	find . -name '.terraform' -exec rm -fr {} +
	find . -name '__pycache__' -exec rm -fr {} +

.PHONY: format
format:  ## Use terraform fmt to format all files in the repo
	@echo "Formatting terraform files"
	@bash hooks/pre-commit
