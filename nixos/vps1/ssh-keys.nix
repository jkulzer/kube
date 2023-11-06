{ username }:

let
  url = "https://github.com/${username}.keys";
in

builtins.fetchurl {
  url = url;
  sha256 = "1lmf36c0ycm72zn2llb394yal276dij8x7v366akyfcpkpz8b9vd";
}

