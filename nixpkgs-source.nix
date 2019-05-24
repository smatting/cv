{ nixpkgs ? import <nixpkgs> {} }:
let
  bootstrap = import <nixpkgs> { };
  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    # 2019-03-19
    rev = "0cbe2fa18cd5c3d788b7045a76984241227f20d0";
    sha256 = "03mhqj0kb07mn3y40r8n1x37xmd6r5q06g20a6ishrarkdh6qppd";
  };
in src
