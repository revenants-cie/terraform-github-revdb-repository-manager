variable "name" {}

variable "description" {
  default = "Project"
}

variable "default_branch" {
  default = "master"
}

variable "private" {
  default = true
}

variable "has_branch_protection" {
  default = true
}

variable "has_issues" {
  default = true
}

variable "has_downloads" {
  default = false
}

variable "homepage_url" {
  default = "https://revdb.io"
}

variable "allow_rebase_merge" {
  default = true
}

variable "allow_squash_merge" {
  default = true
}

variable "organization" {
  description = "GitHub organization"
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

