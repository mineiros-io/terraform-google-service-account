# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.59, < 5.0"
    }
  }
}
