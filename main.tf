# fail-fast: ensure the project exists at plan time and that we have access
data "google_project" "project" {
  project_id = var.project
}

locals {
  project           = data.google_project.project.project_id
  precomputed_email = "${var.account_id}@${local.project}.iam.gserviceaccount.com"
}

resource "google_service_account" "service_account" {
  count = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  account_id   = var.account_id
  display_name = var.display_name != null ? var.display_name : var.account_id
  description  = var.description != null ? var.description : "Programmatic access for ${var.display_name != null ? var.display_name : var.account_id}"
  project      = local.project
}

locals {
  projects_access_list = flatten([
    for project in var.projects_access : [
      for role in toset(project.roles) : {
        project = project.project
        role    = role
      }
    ]
  ])

  projects_access = { for b in local.projects_access_list : "${b.project}/${b.role}" => b }

  folders_access_list = flatten([
    for folder in var.folders_access : [
      for role in toset(folder.roles) : {
        folder = folder.folder
        role   = role
      }
    ]
  ])

  folders_access = { for b in local.folders_access_list : "${b.folder}/${b.role}" => b }
}

resource "google_project_iam_member" "project" {
  for_each = var.module_enabled ? local.projects_access : {}

  project = each.value.project
  role    = each.value.role

  member = "serviceAccount:${google_service_account.service_account[0].email}"
}

resource "google_folder_iam_member" "folder" {
  for_each = var.module_enabled ? local.folders_access : {}

  folder = each.value.folder
  role   = each.value.role

  member = "serviceAccount:${google_service_account.service_account[0].email}"
}

resource "google_organization_iam_member" "organization" {
  for_each = var.module_enabled && var.organization_access != {} ? toset(try(var.organization_access.roles, [])) : []

  org_id = try(var.organization_access.org_id, null)
  role   = each.value

  member = "serviceAccount:${google_service_account.service_account[0].email}"
}
