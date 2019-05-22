
VERSION?=

release: require-version
	@bash ./scripts/release.sh

require-version:
ifndef VERSION
	@echo "WARN: Using the default VERSION in release.sh"
else
	@echo "configured for ${VERSION}"
endif

