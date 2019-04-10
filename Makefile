
SOURCES := $(wildcard src/*.k.md)

specs: $(SOURCES)
	klab build

dapp: osm/src/osm.sol
	cd osm && dapp build

.PHONY: clean
clean:
	cd osm && dapp clean
	rm -rf out/
