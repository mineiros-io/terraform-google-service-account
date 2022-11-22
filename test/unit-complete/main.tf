# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# COMPLETE FEATURES UNIT TEST
# This module tests a complete set of most/all non-exclusive features
# The purpose is to activate everything the module offers, but trying to keep execution time and costs minimal.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

module "test-sa" {
  source = "../.."

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
      role    = "roles/browser"
      members = ["domain:example-domain"]
    },
    {
      role          = "roles/viewer"
      members       = ["domain:example-domain", "principalSet:example"]
      authoritative = false
    },
    {
      role    = "roles/test"
      members = ["serviceAccount:${module.test-sa.service_account.email}"]
    },
    {
      role          = "roles/editor"
      members       = ["computed:myserviceaccount"]
      authoritative = false
    }
  ]
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
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

module "testPolicy" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  account_id = "unit-complete"

  # add all optional arguments that create additional resources
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
}

module "testPolicyIAM" {
  source = "../.."

  module_enabled = true

  # add all required arguments
  account_id = "unit-complete"

  # add all optional arguments that create additional resources
  iam = [
    {
      role    = "roles/storage.objectViewer"
      members = ["projectOwner:example-project"]
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
}
