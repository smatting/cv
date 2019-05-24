{
  cudaSupport ? false
}:
let
  nixpkgSrc = import ./nixpkgs-source.nix {};

  config = rec {
    allowUnfree = true;

    packageOverrides = pkgs: {
      python37 = pkgs.python37.override {
        packageOverrides = pself: psuper: {
          flair = psuper.callPackage ./nix/flair {};
          segtok = psuper.callPackage ./nix/segtok {};
          mpld3 = psuper.callPackage ./nix/mpld3 {};
          sqlitedict = psuper.callPackage ./nix/sqlitedict {};
          pytorch-pretrained-bert = psuper.callPackage ./nix/pytorch-pretrained-bert {};
          deprecated = psuper.callPackage ./nix/deprecated {};
          hyperopt = psuper.callPackage ./nix/hyperopt {};
          sklearn = psuper.callPackage ./nix/sklearn {};
          regex = psuper.callPackage ./nix/regex {};
          bpemb = psuper.callPackage ./nix/bpemb {};
          sentencepiece = psuper.callPackage ./nix/sentencepiece { inherit (pkgs) pkgconfig; };

          pytorch = if cudaSupport
          then
            psuper.callPackage ./nix/pytorch {
              cudaSupport = true;
              cudatoolkit = pkgs.cudatoolkit_9;
              cudnn = pkgs.cudnn_cudatoolkit_9;
            }
          else
           psuper.pytorch;

          etaprogress = psuper.callPackage ./nix/etaprogress {};
          gspread = psuper.callPackage ./nix/gspread {};
          python-markdown-math = psuper.callPackage ./nix/python-markdown-math {};

          altair = psuper.callPackage ./nix/altair {};

          sumtype = psuper.callPackage ./nix/sumtype {};
          indented = psuper.callPackage ./nix/indented {};
        };

      };

      dhall-json = pkgs.fetchzip {
        stripRoot = false;
        url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.22.0/dhall-json-1.2.8-x86_64-linux.tar.bz2";
        sha256 = "172r1fpj5bb43ng2cfw2lxlg0bjb89b8g6cv8bw89vbmxr9c6aqk";
      };

      dhall = pkgs.fetchzip {
        stripRoot = false;
        url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.22.0/dhall-1.22.0-x86_64-linux.tar.bz2";
        sha256 = "04j1bc650s5yw49srhf2pwsvs2ms7gmnvl20ckvxby33kjm8hrj4";
      };

    };

  };

  pkgs = import nixpkgSrc { inherit config; };

in
  pkgs
