# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# EXAMPLE FULL USAGE OF THE TERRAFORM-KUBERNETES-CLUSTER-ROLE MODULE
#
# And some more meaningful information.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module "terraform-kubernetes-cluster-role" {
  source = "git@github.com:mineiros-io/terraform-google-service-account.git?ref=v0.1.2"
  # All required module arguments

  account_id = "service-account-id"


  # All optional module arguments set to the default values
  display_name = "Service Account"
  project      = "project id"

  service_account_keys_count = 1

  # All optional module configuration arguments set to the default values.
  # Those are maintained for terraform 0.12 but can still be used in terraform 0.13
  # Starting with terraform 0.13 you can additionally make use of module level
  # count, for_each and depends_on features.
  module_enabled    = true
  module_depends_on = []
}
#----------------------------------------------------------------------------------------------#------------------------
# SERVICE ACCOUNT KEY OUTPUT
# ----------------------------------------------------------------------------------------------------------------------
output "service_account_key" {
  description = "All attributes of the created `google_service_account_key` resource."
  value       = try(module.terraform-kubernetes-cluster-role.service_account_key, null)
  sensitive   = true
}
# ----------------------------------------------------------------------------------------------------------------------
# EXAMPLE PROVIDER CONFIGURATION
# ----------------------------------------------------------------------------------------------------------------------

provider "google" {
  version = "~> 4.0"
}

#----------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES:
# ----------------------------------------------------------------------------------------------------------------------
# You can provide your credentials via the
# https://cloud.google.com/docs/authentication/application-default-credentials#GAC
# ----------------------------------------------------------------------------------------------------------------------

