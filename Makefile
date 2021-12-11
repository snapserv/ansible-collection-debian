ROLES := $(patsubst roles/%/,%,$(wildcard roles/*/))
ROLE_TESTS := $(addprefix test-,$(ROLES))

.PHONY: default
default: lint test

.PHONY: lint
lint:
	molecule -c molecule.yml lint -s lint

.PHONY: test
test: $(ROLE_TESTS)

.PHONY: $(ROLE_TESTS)
$(ROLE_TESTS):
	cd roles/$(patsubst test-%,%,$@) && molecule -c ../../molecule.yml test --all
