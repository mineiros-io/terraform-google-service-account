locals {
  iam_mapx = { for idx, iam in var.iam :
    try(iam._key, iam.role) => iam
  }

  iam_map = { for idx, iam in var.iam :
    try(iam._key, iam.role) => idx
  }

  iam = values(local.iam_mapx)
}

module "iam" {
  source = "github.com/mineiros-io/terraform-google-service-account-iam.git?ref=v0.1.0"

  for_each = var.policy_bindings == null ? local.iam_map : {}

  module_enabled    = var.module_enabled
  module_depends_on = var.module_depends_on

  service_account_id = try(google_service_account.service_account[0].name, null)

  role                 = local.iam[each.value].role
  members              = try(local.iam[each.value].members, [])
  computed_members_map = var.computed_members_map
  authoritative        = try(local.iam[each.value].authoritative, true)
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
