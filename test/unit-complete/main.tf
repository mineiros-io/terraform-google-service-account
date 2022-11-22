# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
module "test-sa" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.12"

  account_id = "service-account-id-${local.random_suffix}"
}

module "test" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  account_id = "unit-complete"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/iam.serviceAccountUser"
      members = ["serviceAccount:${module.test-sa.service_account.email}"]
    }
  ]

  # add most/all other optional arguments
  display_name = "Unit Complete Test Service Account"
  description  = "A service account created by a unit-tests in https://github.com/mineiros-io/terraform-google-service-account."
  project      = var.gcp_project

  # module_timeouts = {
  #   google_monitoring_notification_channel = {
  #     create = "10m"
  #     update = "10m"
  #     delete = "10m"
  #   }
  # }

  module_depends_on = ["nothing"]
}
