{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, containers, gomp ? null, hspec, QuickCheck
      , stdenv, transformers, z3
      }:
      mkDerivation {
        pname = "z3";
        version = "4.3";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [ base containers transformers ];
        librarySystemDepends = [ gomp z3 ];
        testHaskellDepends = [ base hspec QuickCheck ];
        homepage = "https://github.com/IagoAbal/haskell-z3";
        description = "Bindings for the Z3 Theorem Prover";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {inherit (pkgs) z3;});

in

if pkgs.lib.inNixShell
then (drv.env.overrideAttrs (drv: { buildInputs = drv.buildInputs ++ [ pkgs.z3 ]; }))
else drv
