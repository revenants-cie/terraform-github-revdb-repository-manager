resource "github_repository" "repo" {
  name               = var.name
  description        = var.description
  homepage_url       = var.homepage_url
  has_downloads      = var.has_downloads
  has_issues         = var.has_issues
  private            = var.private
  allow_rebase_merge = var.allow_rebase_merge
  allow_squash_merge = var.allow_squash_merge
  provisioner "local-exec" {
    command = data.template_file.init_repo.rendered
  }
}

resource "github_branch_protection" "default_branch" {
  count          = var.has_branch_protection ? 1 : 0
  repository     = github_repository.repo.name
  branch         = var.default_branch
  enforce_admins = true

  required_status_checks {
    strict = true
    contexts = [
      "Travis CI - Branch",
      "Travis CI - Pull Request"
    ]
  }
  required_pull_request_reviews {
    dismiss_stale_reviews = true
  }
}

resource "github_team_repository" "repo_owner" {
  team_id    = var.owner_team_id
  repository = github_repository.repo.name
  permission = "push"
}

resource "github_team_repository" "repo_admin" {
  team_id    = var.admin_team_id
  repository = github_repository.repo.name
  permission = "admin"
}
