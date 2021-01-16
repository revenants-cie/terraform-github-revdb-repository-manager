terraform {
  backend "s3" {
    region = "us-east-1"
    key    = "terraform_github_revdb_repository_manager/prod/foo_service/terraform.tfstate"
    bucket = "revenants-cie-terraform-states"
  }
}
