
VERSION?=

release: require-version
	@bash ./scripts/release.sh


wallet:
	docker exec -it -u lnd lnd lncli -c litecoin unlock


require-version:
ifndef VERSION
	@echo "WARN: Using the default VERSION in release.sh"
else
	@echo "configured for ${VERSION}"
endif

