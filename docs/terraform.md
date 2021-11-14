# terraform

The configuration in this repository is managed and applied by `terraform`.

This repository uses terraform 1.x.

## Setup

```shell
brew install terraform
brew install --cask aws-vault
```

## AWS Credentials

The `artichokeruby` AWS Organization is set up using Control Tower and its
account vending machine, which sets up an AWS SSO integration.

No long-lived AWS credentials are required for operators.

[`aws-vault`] has an [integration with AWS SSO][aws-vault-aws-sso] which uses
SSO and authorized roles to generate temporary access tokens with assume role.

[`aws-vault`]: https://github.com/99designs/aws-vault
[aws-vault-aws-sso]:
  https://github.com/99designs/aws-vault/blob/master/USAGE.md#aws-single-sign-on-aws-sso

To set up this integration, add the following config to `$HOME/.aws/config`:

```ini
[profile artichokeruby-forge-admin]
sso_start_url=https://d-92670c932c.awsapps.com/start
sso_region=us-west-2
sso_account_id=447522982029
sso_role_name=AWSAdministratorAccess
```

## Using `terraform` and `aws-vault`

To use the `aws-vault`-generated temporary credentials, invoke terraform like
this:

```shell
aws-vault exec artichokeruby-forge-admin -- terraform plan
aws-vault exec artichokeruby-forge-admin -- terraform apply
```

This may open a browser window to facilitate an SSO login. It may prompt for a
macOS keychain password. `aws-vault` stores temporary credentials in a keychain
that it manages.
