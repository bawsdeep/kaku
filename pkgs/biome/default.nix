{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libgit2_1_6,
  rust-jemalloc-sys,
  zlib,
  stdenv,
  darwin,
  git,
}:
rustPlatform.buildRustPackage rec {
  pname = "biome";
  version = "1.5.3";

  src = fetchFromGitHub {
    owner = "biomejs";
    repo = "biome";
    rev = "cli/v${version}";
    hash = "sha256-lzY1Eh1jZixsKi+ObQlhzV4KSV7ZSGPBJtaO9ZiJjEk=";
  };

  cargoHash = "sha256-Ubfoxhn06YkJcfosgUG+w8W3VHSDythlY47UnXYiC3w=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs =
    [
      libgit2_1_6
      rust-jemalloc-sys
      zlib
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
    ];

  nativeCheckInputs = [
    git
  ];

  cargoBuildFlags = ["-p=biome_cli"];
  cargoTestFlags = cargoBuildFlags;

  env = {
    BIOME_VERSION = version;
  };

  preCheck = ''
    # tests assume git repository
    git init

    # tests assume $BIOME_VERSION is unset
    unset BIOME_VERSION
  '';

  meta = with lib; {
    description = "Toolchain of the web";
    homepage = "https://biomejs.dev/";
    changelog = "https://github.com/biomejs/biome/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [figsoda];
    mainProgram = "biome";
  };
}
