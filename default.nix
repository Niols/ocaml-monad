{ pkgs ? (import <nixpkgs> {}).pkgs
}:

let
  myemacs =
    with pkgs.emacsPackages; with pkgs.emacsPackagesNg; pkgs.emacsWithPackages
    [ ace-jump-mode company helm-projectile magit
      (merlin.overrideAttrs (attrs: {
         meta = attrs.meta // { broken = false; };
       }))
      merlin-company paredit tuareg undo-tree
    ];
in with pkgs; stdenv.mkDerivation {
  name = "monadlib";
  buildInputs = [ dune_2
                  ocaml
                  ocamlPackages.batteries
                  ocamlPackages.findlib
                  ocamlPackages.merlin
                  ocamlPackages.ocaml_oasis
                  ocamlPackages.ocaml

                  myemacs
                ];
  merlinbin = ocamlPackages.merlin;
  ocamlformat = pkgs.ocamlformat;
  utop = ocamlPackages.utop;
}
