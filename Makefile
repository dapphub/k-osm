
SOURCES = src/prelude.smt2.md src/lemmas.k.md src/storage.k.md src/osm.md

specs: dapp
	klab build

dapp:
	git submodule sync --recursive
	git submodule update --init --recursive
	cd osm && dapp --use solc:0.5.6 build

.PHONY: clean
clean:
	cd osm && dapp clean
	rm -rf out/
