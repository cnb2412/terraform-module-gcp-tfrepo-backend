data "google_project" "project" {
}

locals {
  project_id = length(var.project_id) > 0 ? var.project_id : data.google_project.project.number
}

## Cloud source repo
resource "google_sourcerepo_repository" "my-repo" {
  project = local.project_id
  name    = "${var.reponame}-repo"
}

## storage bucket for tf states
resource "google_storage_bucket" "tf-state-bucket" {
  project                     = local.project_id
  name                        = "${var.reponame}-tfstate-storage"
  location                    = var.location
  uniform_bucket_level_access = true
  force_destroy               = true
  versioning {
    enabled = true
  }
}

resource "google_sourcerepo_repository_iam_member" "repo_editors" {
  for_each   = toset(var.repo_writers)
  project    = var.project_id
  repository = google_sourcerepo_repository.my-repo.name
  role       = "roles/source.writer"
  member     = each.value
}

resource "google_storage_bucket_iam_member" "tf-state-bucket-member" {
  for_each = toset(var.repo_writers)
  bucket   = google_storage_bucket.tf-state-bucket.name
  role     = "roles/storage.objectUser"
  member   = each.value
}
