data "template_file" "init_repo" {
  template = file("${path.module}/init_repo.sh")
  vars = {
    ssh_key_path              = var.ssh_key_path
    default_branch            = var.default_branch
    organization              = var.organization
    repo_name                 = var.name
    repo_kind                 = var.repo_kind
    project_name              = var.name
    project_short_description = var.description
    states_bucket             = var.states_bucket
    email                     = var.email
    github_username           = var.github_username
    trigger_cookiecutter      = var.trigger_cookiecutter
    setup_travis              = var.setup_travis
  }
}
