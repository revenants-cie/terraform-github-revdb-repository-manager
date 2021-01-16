RevDB GitHub Module
================

[![Build Status](https://travis-ci.com/revenants-cie/terraform-aws-revdb-github.svg?branch=master)](https://travis-ci.com/revenants-cie/terraform-aws-revdb-github)

Description
=============

This module manages github repositories, creates new ones using cookiecutters, issues first commits, sets up travis etc.

Since the github terraform module is pretty decent on its own, this isn't a single resource module at all.

The main feature of the module is the included cookiecutter for Python/Terraform/Empty repo types.
For each one of these types, it will configure the basic structure, adds the basic files, includes admins and maintainers etc.

All the repos are created with specified branch protection, admin lists and all necessary configuration.

Cookiecutters
=============

Python
------

[![Build Status](https://travis-ci.org/audreyfeldroy/cookiecutter-pypackage.svg?branch=master)](https://travis-ci.org/github/audreyfeldroy/cookiecutter-pypackage)

The python cookiecutter is based on [audreyr](https://github.com/audreyr/cookiecutter-pypackage.git)'s python basic.
In his own words, Featues include

* Testing setup with ``unittest`` and ``python setup.py test`` or ``pytest``
* Travis-CI_: Ready for Travis Continuous Integration testing
* Tox_ testing: Setup to easily test for Python 3.5, 3.6, 3.7, 3.8
* Sphinx_ docs: Documentation ready for generation with, for example, `Read the Docs`_
* bump2version_: Pre-configured version bumping with a single command
* Auto-release to PyPI_ when you push a new tag to master (optional)
* Command line interface using Click (optional)

Terraform
---------

[![Build Status](https://travis-ci.com/revenants-cie/cookiecutter-terraform.svg?branch=master)](https://travis-ci.com/revenants-cie/cookiecutter-terraform)

The terraform cookiecutter is based on [our own](https://github.com/revenants-cie/cookiecutter-terraform).

For details, please take a look at the cookiecutter's readme. The absolute key feature is handling and managint the `.env/` folder to share and use secrets with travis and [terraform-ci](https://github.com/revenants-cie/terraform-ci).

Empty
-----
[![Build Status](https://travis-ci.com/revenants-cie/cookiecutter-empty.svg?branch=master)](https://travis-ci.com/revenants-cie/cookiecutter-empty)

The empty cookiecutter is also based on [our own](https://github.com/revenants-cie/cookiecutter-empty).

This creates a simple basic structure with README, travis.yml, makefile and such and pushes the first commit.

Examples
========
```hcl
module "python-playground" {
  source = "../../revdb/terraform-aws-revdb-github"
  name                  = "python-demo-playground"
  description           = "Testing various things in github / travis / python"
  private               = true
  organization          = "revdb-test"
  owner_team_id         = github_team.committers.id
  ssh_key_path          = abspath("/Users/admin_user/.ssh/id_rsa")
  admin_team_id         = github_team.admins.id
  repo_kind             = "python"
  has_branch_protection = true
  trigger_cookiecutter  = true
  setup_travis          = false
}
```
