module "reserve_artichoke" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "artichoke"
  repository = "artichoke-reserve"
}

module "reserve_artichokeruby" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "artichokeruby"
  repository = "artichokeruby-reserve"
}

module "reserve_artichoke_ruby" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "artichoke-ruby"
  repository = "artichoke-ruby-reserve"
}

module "reserve_boba" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "boba"
  repository = "boba-reserve"
}

module "reserve_invokedynamic" {
  source = "../modules/crates.io-reservation-repository"

  crate      = "invokedynamic"
  repository = "invokedynamic-reserve"
}
