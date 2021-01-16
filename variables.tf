variable "name" {
    description = "This is the name of the repository."
}

variable "description" {
  description = "The Github description of the project."
    default = "Project"
}

variable "default_branch" {
  default = "master"
}

variable "private" {
    description = "Whether the repositoriy is open for the public."
  default = true
}

variable "has_branch_protection" {
    description = "Whether to have branch protection or not, includes required reviewers and passing tests."
  default = true
}

variable "has_issues" {
    description = "To support issues reported against the repository."
  default = true
}

variable "has_downloads" {
    description = "To support downloads."
  default = false
}

variable "homepage_url" {
    description = "Project homepage."
  default = "https://revdb.io"
}

variable "allow_rebase_merge" {
    description = "When set to true, you can rebase + merge."
  default = true
}

variable "allow_squash_merge" {
    description = "When set to true, you can squash + merge."
  default = true
}

variable "organization" {
  description = "GitHub organization's name, where the repository will be located."
}

variable "ssh_key_path" {
  description = "Path to SSH key to access GitHub"
  default     = ".env/id_rsa"
}

variable "owner_team_id" {
  description = "Team id that has a push priviledge on the repo"
}

variable "admin_team_id" {
  description = "Team id that has an admin priviledge on the repo"
}

variable "repo_kind" {
  description = "What kind of cookiecutter use for the project. Supported values: terraform, python, empty"
  default     = "empty"
}

variable "states_bucket" {
  description = "S3 bucket where terraform state will be stored (if it's a terraform repo)"
  default     = "revenants-cie-terraform-states"
}

variable "email" {
  description = "Email that it used for python projects"
  default     = "dev@revdb.io"
}

variable "github_username" {
  description = "Author's handle on GitHub"
  default     = "revenants-cie"
}

variable "setup_travis" {
  description = "When specified, all travis related configuration will be setup"
  default     = false
}

variable "trigger_cookiecutter" {
  description = "When specified, cookie cutter will run for the repo type."
  default     = true
}

