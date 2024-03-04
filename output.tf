output "backend_config" {
  value = <<EOF
    Backend config for the TF repo:
    terraform {
      backend "gcs" {
        bucket  = "${var.reponame}-tfstate-storage"
        prefix  = "terraform/state"
      }
    }

    One of the following users need to be loged in:
    ${join(", ", var.repo_writers)}

  EOF
}
