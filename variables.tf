# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "account_id" {
  description = "(Required) The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035."
  type        = string
  validation {
    condition     = length(var.account_id) >= 6 && length(var.account_id) <= 30 && can(regex("[a-z]([-a-z0-9]*[a-z0-9])", var.account_id))
    error_message = "It must be unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "display_name" {
  description = "(Optional) The display name for the service account. Can be updated without creating a new resource."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
  type        = string
  default     = null
}

variable "project" {
  description = "(Optional) The project ID. If not specified, terraform uses the ID of the project configured with the provider."
  type        = string
  default     = null
}

variable "projects_access" {
  description = "(Optional) A set of projects with roles that are going to be granted to the service account."
  type        = any
  default     = []
}

variable "folders_access" {
  description = "(Optional) A set of folders with roles that are going to be granted to the service account."
  type        = any
  default     = []
}

variable "organization_access" {
  description = "(Optional) An organization object setting the organization and the organization wide roles that are going to be granted to the service account."
  type        = any
  default     = {}
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = list(any)
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
