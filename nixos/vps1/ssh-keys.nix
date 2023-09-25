{ username }:

let
  url = "https://github.com/${username}.keys";
in

builtins.fetchurl {
  url = url;
  sha256 = "6da785fe9d97393f9531639f8e646ce608aa3c4963512aec17a7320f9819aed2"; # Generate this with `nix-prefetch-url`
}
