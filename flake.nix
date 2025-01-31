{
  description = "st dependencies";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = {self, nixpkgs}:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      shell = pkgs.mkShell {
        nativeBuildInputs = pkgs.st.nativeBuildInputs;
        buildInputs = pkgs.st.buildInputs;
      };
    in {
      defaultPackage.x86_64-linux = shell;
      packages.x86_64-linux = {
        inherit
          shell;
      };
    };
}
