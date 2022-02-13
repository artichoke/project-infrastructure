# crates.io Reservation Repository

This folder contains a Terraform module to manage private repositories that
contain empty Rust crates used for reserving crate names on [crates.io].

[crates.io]: https://crates.io/

## Usage

```terraform
module "reserve_artichoke" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "artichoke"
  repository = "artichoke-reserve"
}
```

## Parameters

- `crate`: The name of the crate to be reserved on crates.io.
- `repository`: The name of the repository to store the empty crate,
  conventionally `${crate}-reserve`.

## Outputs

This module has no outputs.
