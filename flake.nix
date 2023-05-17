{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      build_input_pkgs = [ pkgs.libnet pkgs.libpcap ];
    in {

      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
        name = "net-speeder";
        buildInputs = build_input_pkgs;
        src = ./.;
        buildPhase = ''
          bash build.sh
        '';
        installPhase = ''
          mkdir -p $out
          mv net_speeder $out
        '';
      };

      devShell.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = build_input_pkgs;
        shellHook = "";
      };

    };
}
