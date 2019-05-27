{ buildEnv, stdenv, texlive, rubber }:
stdenv.mkDerivation rec {
  name = "env";
  src = ./.;

  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    rubber
    (texlive.combine {
      inherit (texlive) collection-latexrecommended collection-latexextra xetex collection-fontsrecommended;

    })
  ];

  postShellHook = ''
    set -eu
    export PATH=${env}/bin:$PATH
    set +eu
  '';

  installPhase = ''
    mkdir -p $out
    cp stefan-matting-cv.pdf $out
  '';

}
