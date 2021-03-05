# Contributing to Artichoke – Project Infrastructure

👋 Hi and welcome to [Artichoke]. Thanks for taking the time to contribute!
💪💎🙌

Artichoke aspires to be a Ruby 2.6.3-compatible implementation of the Ruby
programming language. [There is lots to do].

project-infrastructure is infrastructure as code configuration for Artichoke on
GitHub, AWS, and other platforms.

If Artichoke does not run Ruby source code in the same way that MRI does, it is
a bug and we would appreciate if you [filed an issue so we can fix it]. [File
bugs specific to project-infrastructure in this repository].

If you would like to contribute code to project-infrastructure 👩‍💻👨‍💻, find an
issue that looks interesting and leave a comment that you're beginning to
investigate. If there is no issue, please file one before beginning to work on a
PR. [Good first issues are labeled `E-easy`].

## Discussion

If you'd like to engage in a discussion outside of GitHub, you can [join
Artichoke's public Discord server].

## Setup

project-infrastructure includes Ruby, Terraform, and Text sources. Developing on
project-infrastructure requires configuring several dependencies.

### Terraform

The Artichoke project infrastructure depends on [Terraform] 0.14.

On macOS, you can install Terraform with [Homebrew]:

```console
$ brew install terraform@0.14
```

### Ruby

project-infrastructure requires a recent Ruby 2.x and [bundler] 2.x. The
[`.ruby-version`](.ruby-version) file in this repository specifies Ruby 2.6.6.

project-infrastructure uses [`rake`](Rakefile) as a task runner. You can see the
available tasks by running:

```console
$ bundle exec rake --tasks
rake fmt                          # Format sources
rake fmt:terraform                # Format Terraform sources with terraform fmt
rake fmt:text                     # Format text, YAML, and Markdown sources with prettier
rake format                       # Format sources
rake format:terraform             # Format Terraform sources with terraform fmt
rake format:text                  # Format text, YAML, and Markdown sources with prettier
rake lint                         # Lint sources
rake lint:rubocop                 # Run RuboCop
rake lint:rubocop:auto_correct    # Auto-correct RuboCop offenses
rake lint:terraform               # Lint Terraform sources
rake release:markdown_link_check  # Check for broken links in markdown files
```

To lint Ruby sources, project-infrastructure uses [RuboCop]. RuboCop runs as
part of the `lint` task. To run RuboCop by itself, invoke the `lint:rubocop`
task.

```console
$ bundle exec rake lint
$ bundle exec rake lint:rubocop
```

### Node.js

Node.js is an optional dependency that is used for formatting text sources with
[prettier].

Node.js is only required for formatting if modifying the following filetypes:

- `md`
- `yaml`
- `yml`

You will need to install [Node.js].

On macOS, you can install Node.js with [Homebrew]:

```sh
brew install node
```

## Updating Dependencies

Regular dependency bumps are handled by [@dependabot].

[artichoke]: https://github.com/artichoke
[there is lots to do]: https://github.com/artichoke/artichoke/issues
[filed an issue so we can fix it]:
  https://github.com/artichoke/artichoke/issues/new
[file bugs specific to project-infrastructure in this repository]:
  https://github.com/artichoke/project-infrastructure/issues/new
[good first issues are labeled `e-easy`]:
  https://github.com/artichoke/project-infrastructure/labels/E-easy
[join artichoke's public discord server]: https://discord.gg/QCe2tp2
[terraform]: https://www.terraform.io/downloads.html
[homebrew]: https://docs.brew.sh/Installation
[bundler]: https://bundler.io/
[rubocop]: https://github.com/rubocop-hq/rubocop
[prettier]: https://prettier.io/
[node.js]: https://nodejs.org/en/download/package-manager/
[@dependabot]: https://dependabot.com/
