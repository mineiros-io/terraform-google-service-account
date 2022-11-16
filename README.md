[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-service-account)

[![Build Status](https://github.com/mineiros-io/terraform-google-service-account/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-service-account/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-service-account.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-service-account/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-google-service-account

A [Terraform](https://www.terraform.io) module to create [Google Service Accounts](https://cloud.google.com/iam/docs/service-accounts) on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Module Configuration](#module-configuration)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Extended Resource Configuration](#extended-resource-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation:](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following terraform resources

- `google_service_account`

and supports additional features of the following modules:

- [mineiros-io/terraform-google-service-account-iam](https://github.com/mineiros-io/terraform-google-service-account-iam)

## Getting Started

Most basic usage just setting required arguments:

```hcl
module "terraform-google-service-account" {
  source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.0.12"

  account_id   = "service-account-id"
  display_name = "Service Account"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

### Main Resource Configuration

- [**`account_id`**](#var-account_id): *(**Required** `string`)*<a name="var-account_id"></a>

  The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])` to comply with RFC1035. Changing this forces a new service account to be created.

- [**`display_name`**](#var-display_name): *(Optional `string`)*<a name="var-display_name"></a>

  The display name for the service account. Can be updated without creating a new resource.

- [**`description`**](#var-description): *(Optional `string`)*<a name="var-description"></a>

  A text description of the service account. Must be less than or equal to 256 UTF-8 bytes.

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

- [**`projects_access`**](#var-projects_access): *(Optional `list(projects_access)`)*<a name="var-projects_access"></a>

  A set of projects with roles that are going to be granted to the service account.

  Default is `[]`.

  Example:

  ```hcl
  projects_access = [{
    project = "your-project-id"
    roles   = ["roles/editor"]
  }]
  ```

  Each `projects_access` object in the list accepts the following attributes:

  - [**`project`**](#attr-projects_access-project): *(**Required** `string`)*<a name="attr-projects_access-project"></a>

    The project ID.

  - [**`roles`**](#attr-projects_access-roles): *(**Required** `set(string)`)*<a name="attr-projects_access-roles"></a>

    A set of roles that should be applied.

- [**`folders_access`**](#var-folders_access): *(Optional `list(folders_access)`)*<a name="var-folders_access"></a>

  A set of folders with roles that are going to be granted to the service account.

  Default is `[]`.

  Example:

  ```hcl
  folders_access = [{
    folder = "folders/folder_id"
    roles  = ["roles/editor"]
  }]
  ```

  Each `folders_access` object in the list accepts the following attributes:

  - [**`folder`**](#attr-folders_access-folder): *(**Required** `string`)*<a name="attr-folders_access-folder"></a>

    The resource name of the folder the policy is attached to. Its format is `folders/{folder_id}`.

  - [**`roles`**](#attr-folders_access-roles): *(**Required** `set(string)`)*<a name="attr-folders_access-roles"></a>

    A set of roles that should be applied.

- [**`organization_access`**](#var-organization_access): *(Optional `object(organization_access)`)*<a name="var-organization_access"></a>

  An organization object setting the organization and the organization wide roles that are going to be granted to the service account.

  Default is `[]`.

  Example:

  ```hcl
  organization_access = {
    org_id = "your-organization-id"
    roles  = ["roles/editor"]
  }
  ```

  The `organization_access` object accepts the following attributes:

  - [**`org_id`**](#attr-organization_access-org_id): *(**Required** `string`)*<a name="attr-organization_access-org_id"></a>

    The organization ID.

  - [**`roles`**](#attr-organization_access-roles): *(**Required** `set(string)`)*<a name="attr-organization_access-roles"></a>

    A set of roles that should be applied.

### Extended Resource Configuration

- [**`iam`**](#var-iam): *(Optional `list(iam)`)*<a name="var-iam"></a>

  A list of IAM access.

  Example:

  ```hcl
  iam = [{
    role    = "roles/iam.serviceAccountUser"
    members = ["user:member@example.com"]
  }]
  ```

  Each `iam` object in the list accepts the following attributes:

  - [**`members`**](#attr-iam-members): *(Optional `set(string)`)*<a name="attr-iam-members"></a>

    Identities that will be granted the privilege in role. Each entry can have one of the following values:
    - `allUsers`: A special identifier that represents anyone who is on the internet; with or without a Google account.
    - `allAuthenticatedUsers`: A special identifier that represents anyone who is authenticated with a Google account or a service account.
    - `user:{emailid}`: An email address that represents a specific Google account. For example, alice@gmail.com or joe@example.com.
    - `serviceAccount:{emailid}`: An email address that represents a service account. For example, my-other-app@appspot.gserviceaccount.com.
    - `group:{emailid}`: An email address that represents a Google group. For example, admins@example.com.
    - `domain:{domain}`: A G Suite domain (primary, instead of alias) name that represents all the users of that domain. For example, google.com or example.com.

    Default is `[]`.

  - [**`role`**](#attr-iam-role): *(Optional `string`)*<a name="attr-iam-role"></a>

    The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`.

  - [**`authoritative`**](#attr-iam-authoritative): *(Optional `bool`)*<a name="attr-iam-authoritative"></a>

    Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.

    Default is `true`.

- [**`policy_bindings`**](#var-policy_bindings): *(Optional `list(policy_binding)`)*<a name="var-policy_bindings"></a>

  A list of IAM policy bindings.

  Example:

  ```hcl
  policy_bindings = [{
    role      = "roles/iam.serviceAccountUser"
    members   = ["user:member@example.com"]
    condition = {
      title       = "expires_after_2021_12_31"
      description = "Expiring at midnight of 2021-12-31"
      expression  = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
    }
  }]
  ```

  Each `policy_binding` object in the list accepts the following attributes:

  - [**`role`**](#attr-policy_bindings-role): *(**Required** `string`)*<a name="attr-policy_bindings-role"></a>

    The role that should be applied.

  - [**`members`**](#attr-policy_bindings-members): *(Optional `set(string)`)*<a name="attr-policy_bindings-members"></a>

    Identities that will be granted the privilege in `role`.

    Default is `var.members`.

  - [**`condition`**](#attr-policy_bindings-condition): *(Optional `object(condition)`)*<a name="attr-policy_bindings-condition"></a>

    An IAM Condition for a given binding.

    Example:

    ```hcl
    condition = {
      expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
      title      = "expires_after_2021_12_31"
    }
    ```

    The `condition` object accepts the following attributes:

    - [**`expression`**](#attr-policy_bindings-condition-expression): *(**Required** `string`)*<a name="attr-policy_bindings-condition-expression"></a>

      Textual representation of an expression in Common Expression Language syntax.

    - [**`title`**](#attr-policy_bindings-condition-title): *(**Required** `string`)*<a name="attr-policy_bindings-condition-title"></a>

      A title for the expression, i.e. a short string describing its purpose.

    - [**`description`**](#attr-policy_bindings-condition-description): *(Optional `string`)*<a name="attr-policy_bindings-condition-description"></a>

      An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

- [**`iam`**](#output-iam): *(`list(iam)`)*<a name="output-iam"></a>

  The `iam` resource objects that define the access to the resources.

- [**`service_account`**](#output-service_account): *(`object(service_account)`)*<a name="output-service_account"></a>

  All attributes of the created `google_service_account` resource.

- [**`project_iam_member`**](#output-project_iam_member): *(`object(project_iam_member)`)*<a name="output-project_iam_member"></a>

  All attributes of the created `google_project_iam_member` resource.

- [**`folder_iam_member`**](#output-folder_iam_member): *(`object(folder_iam_member)`)*<a name="output-folder_iam_member"></a>

  All attributes of the created `google_folder_iam_member` resource.

- [**`organization_iam_member`**](#output-organization_iam_member): *(`object(organization_iam_member)`)*<a name="output-organization_iam_member"></a>

  All attributes of the created `google_organization_iam_member` resource.

## External Documentation

### Google Documentation

- https://cloud.google.com/iam/docs/service-accounts

### Terraform Google Provider Documentation:

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-service-account
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-service-account/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-service-account.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-service-account/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-service-account/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-service-account/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-google-service-account/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-google-service-account/issues
[license]: https://github.com/mineiros-io/terraform-google-service-account/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-service-account/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-service-account/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-service-account/blob/main/CONTRIBUTING.md
