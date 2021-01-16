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

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < Makefile

.PHONY: init
init:
	terraform init -no-color

.PHONY: plan
plan: init ## Run terraform plan
	terraform get -update=true -no-color
	terraform plan -input=false -no-color -var-file=configuration.tfvars

.PHONY: apply
apply: init ## Run terraform apply
	terraform get -update=true -no-color
	terraform apply -var-file=configuration.tfvars -input=false -auto-approve
