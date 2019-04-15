
SOURCES = src/prelude.smt2.md src/lemmas.k.md src/storage.k.md src/osm.md

specs: dapp
	klab build

dapp: osm/out/osm.sol.json

osm/out/osm.sol.json: osm/src/osm.sol
	cd osm && dapp build

.PHONY: clean
clean:
	cd osm && dapp clean
	rm -rf out/
