{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = {self, nixpkgs}:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      st = pkgs.stdenv.mkDerivation {
        name = "st";
        src = ./.;
        outputs = ["out" "terminfo"];
        nativeBuildInputs = pkgs.st.nativeBuildInputs;
        buildInputs = pkgs.st.buildInputs;
        installPhase = ''
          export TERMINFO=$terminfo/share/terminfo
          mkdir -p $TERMINFO $out/nix-support
          echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
          make install PREFIX=$out 
        '';
      };
    in {
      packages.x86_64-linux = {
        inherit st;
        default = st;
      };
    };
}
