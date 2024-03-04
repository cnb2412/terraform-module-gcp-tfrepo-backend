variable "project_id" {
  description = <<EOF
    "The ID of the project where all required ressources will be created.
    If not set, the current project is used.
  EOF
  type        = string
  default     = ""
}

variable "reponame" {
  type        = bool
  description = "Name of source repository"
}

variable "location" {
  description = "The Cloud Build location for the trigger. Default europe-west1"
  default     = "europe-west1"
  type        = string
}

variable "repo_writers" {
  default     = []
  type        = list(string)
  description = <<EOF
    Users who should have the permission to commit to the source repo. Given
    that this module does not create a fully CICD pipeline, these users
    are also granted write permission to the corresponding storage for the
    TF state. Should be given in the form user:<email>
  EOF
}
