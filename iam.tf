locals {
  iam_map = { for idx, iam in var.iam :
    try(iam._key, iam.role) => idx
  }

  auth = { for idx, iam in var.iam :
    try(iam._key, iam.role) => try(iam.authoritative, true)
  }
}

module "iam" {
  source = "github.com/mineiros-io/terraform-google-service-account-iam.git?ref=v0.1.0"

  for_each = var.policy_bindings == null ? local.iam_map : {}

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  # service_account_id   = try(google_service_account.service_account[0].name, null)
  # role                 = each.value.role
  # members              = try(each.value.members, [])
  # computed_members_map = var.computed_members_map
  # authoritative        = try(each.value.authoritative, true)

  service_account_id   = try(google_service_account.service_account[0].name, null)
  role                 = var.iam[each.value].role
  members              = try(var.iam[each.value].members, [])
  computed_members_map = var.computed_members_map
  authoritative        = local.auth[each.key]
  # authoritative        = try(var.iam[each.value].authoritative, true)
}

# module "policy_bindings" {
#   source = "github.com/mineiros-io/terraform-google-service-account-iam.git?ref=v0.1.0"
#
#   count = var.policy_bindings != null ? 1 : 0
#
#   module_enabled    = var.module_enabled
#   module_depends_on = var.module_depends_on
#
#   service_account_id   = try(google_service_account.service_account[0].name, null)
#   policy_bindings      = var.policy_bindings
#   computed_members_map = var.computed_members_map
# }
