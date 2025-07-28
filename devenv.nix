{ pkgs, ... }:
let
  rmkit = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "rmkit";
    version = "0.0.16";

    src = pkgs.fetchCrate {
      inherit (finalAttrs) pname version;
      hash = "sha256-FY5Z1k6tpfvlGWccDu8a3F7VATxORwHC5mIhHCSysIc=";
    };

    cargoHash = "sha256-hb6tZlJX1uCOc2C0yj/FKYzNzKRfefk6S3vIPWP0370=";
    cargoDepsName = finalAttrs.pname;
  });
in
{
  dotenv.enable = true;
  languages.rust = {
    enable = true;
    channel = "stable";
    components = [
      "rustc"
      "cargo"
      "clippy"
      "rustfmt"
      "rust-analyzer"
      "llvm-tools"
    ];
    targets = [ "thumbv7em-none-eabihf" ];
  };

  packages = [
    pkgs.git
    pkgs.cargo-make
    pkgs.flip-link
    pkgs.cargo-expand
    pkgs.cargo-binutils
    rmkit
  ];
}
