# Artichoke GitHub Configuration

This is a [Terraform](https://www.terraform.io) configuration for the
[Artichoke](https://github.com/artichoke) open source project. It manages GitHub
ACLs and issue labels. To apply the the configuration to the project's
resources, grab a
[GitHub access token](https://github.com/settings/tokens/new?scopes=repo) and
then do the following:

```bash
$ echo 'github_token = "INSERT TOKEN HERE"' > terraform.tfvars
$ terraform init
$ terraform apply
```
