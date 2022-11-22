locals {
  iam_map = var.policy_bindings == null ? { for iam in var.iam : iam.role => iam } : {}

  policy_bindings = var.policy_bindings != null ? {
    iam_policy = {
      policy_bindings = var.policy_bindings
    }
  } : {}

  iam_output = [local.policy_bindings, local.iam_map]

  iam_output_index = var.policy_bindings != null ? 0 : 1
}

module "iam" {
  source = "github.com/mineiros-io/terraform-google-service-account-iam.git?ref=v0.0.4"

  for_each = local.iam_output[local.iam_output_index]

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  service_account_id = try(google_service_account.service_account[0].name, null)
  role               = try(each.value.role, null)
  members            = try(each.value.members, [])
  authoritative      = try(each.value.authoritative, true)
  policy_bindings    = try(each.value.policy_bindings, null)
}
