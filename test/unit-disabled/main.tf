# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# EMPTY FEATURES (DISABLED) UNIT TEST
# This module tests an empty set of features.
# The purpose is to verify no resources are created when the module is disabled.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module "test" {
  source = "../.."

  module_enabled = false

  # add all required arguments
  account_id = "unit-disabled"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/iam.serviceAccountUser"
      members = ["group:terraform-tests@mineiros.io"]
    }
  ]
  policy_bindings = [
    {
      role    = "roles/iam.serviceAccountUser"
      members = ["group:terraform-tests@mineiros.io"]
      condition = {
        title       = "expires_after_2030_12_31"
        description = "Expiring at midnight of 2030-12-31"
        expression  = "request.time < timestamp(\"2030-01-01T00:00:00Z\")"
      }
    }
  ]
  projects_access = [
    {
      project = "terraform-service-catalog"
      roles   = ["roles/viewer"]
    }
  ]
  folders_access = [
    {
      folder = "692674674684"
      roles  = ["roles/viewer"]
    }
  ]
  organization_access = [
    {
      org_id = "52211381732"
      roles  = ["roles/viewer"]
    }
  ]

  # add only required arguments and no optional arguments
}
