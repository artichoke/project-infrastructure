# Artichoke GitHub Configuration

This is a [Terraform] configuration for the [Artichoke] open source project. It
manages GitHub ACLs and repositories. To apply the the configuration to the
project's resources, grab a [GitHub access token] and then do the following:

```bash
$ echo 'github_token = "INSERT TOKEN HERE"' > secrets.auto.tfvars
$ echo 'discord_api_secret = "INSERT TOKEN HERE"' >> secrets.auto.tfvars
$ terraform init
$ terraform apply
```

[terraform]: https://www.terraform.io
[artichoke]: https://github.com/artichoke
[github access token]:
  https://github.com/settings/tokens/new?scopes=repo,admin:org,admin:org_hook,workflow
