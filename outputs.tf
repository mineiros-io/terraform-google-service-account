# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# remap iam to reduce one level of access (iam[]. instead of iam[].iam.)
output "iam" {
  description = "The iam resource objects that define the access to the resources."
  value       = { for key, iam in module.iam : key => iam.iam }
}

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "service_account" {
  description = "All attributes of the created `google_service_account` resource."
  value       = try(google_service_account.service_account[0], null)
}

output "project_iam_member" {
  description = "All attributes of the created `google_project_iam_member` resource."
  value       = try(google_project_iam_member.project, null)
}

output "folder_iam_member" {
  description = "All attributes of the created `google_folder_iam_member` resource."
  value       = try(google_folder_iam_member.folder, null)
}

output "organization_iam_member" {
  description = "All attributes of the created `google_organization_iam_member` resource."
  value       = try(google_organization_iam_member.organization, null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled."
  value       = var.module_enabled
}
