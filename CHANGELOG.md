# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Remove project data source

## [0.0.11]

### Changed

- Remove Terraform `tomap` function use from `iam` module locals.
- Remove redundant variable declaration from tests

## [0.0.10]

### Changed

- BREAKING: Remove support for Terraform `<= 1.0`. Exclude broken Terraform versions `1.1.0` and `1.1.1`.
- BREAKING: Update minimum required version of the google provider to `v3.59` to match the minimum requirements of the `terraform-google-service-account-iam` submodule

### Fixed

- Fix attributes in nested `terraform-google-service-account-iam` module to not fail when `module_enabled = false`
- Wrap `google_service_account` resource in `try` statement in `iam` definition to fix `module_enabled = false`
- Fix documentation for `projects_access`, `folders_access` and `organization_access`
- Only use `google_project` data source when `module_enabled = true`

### Added

- Add unit tests

## [0.0.9]

### Fixed

- Fix `module_enabled = false`

## [0.0.8]

### Changed

- Add `principalSet:` to validation in IAM members

## [0.0.7]

### Added

- Support for provider 4.x

## [0.0.6]

### Fixed

- Do not fail unset provider project if project argument is provided
- Add missing `toset` to `project.roles` and `folder.roles`

## [0.0.5]

### Fixed

- Set default value of `members` in iam to `[]`.

## [0.0.4]

### Fixed

- Fix type of `module_depends_on`

## [0.0.3]

### Added

- Add IAM support to the module
## [0.0.2]

### Added

- Add `precomputed_email` output to be used in `for_each`

## [0.0.1]

### Added

- Initial Implementation

[unreleased]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.11...HEAD
[0.0.11]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.10...v0.0.11
[0.0.10]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.9...v0.0.10
[0.0.9]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.8...v0.0.9
[0.0.8]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.7...v0.0.8
[0.0.7]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/mineiros-io/terraform-google-service-account/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/mineiros-io/terraform-google-service-account/releases/tag/v0.0.1
