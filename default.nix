{ mkDerivation, base, containers, gomp ? null, hspec, QuickCheck, stdenv
, transformers, z3
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
}
