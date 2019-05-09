with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "k-osm";
  buildInputs = [
    flex
    getopt
    utillinux
    git
    gnumake
    jq
    nodejs
    openjdk8
    parallel
    zip
    z3
  ];
  shellHook = ''
    export PATH=$KLAB_PATH/node_modules/.bin/:$KLAB_PATH/bin:$PATH
    export KLAB_EVMS_PATH=$KLAB_PATH/evm-semantics
  '';
}
