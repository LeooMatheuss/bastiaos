SHELL := /bin/bash

BUILDER_IMAGE := bastia-builder:dev
BUILDER_DOCKERFILE := ci/Dockerfile.builder
VENV := .venv-docs

.PHONY: help validate-env builder lint docs test clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

validate-env: ## Check host tooling required by the build
	tools/validate-env.sh

builder: validate-env ## Build the pinned builder image (bastia-builder:dev)
	docker build -f $(BUILDER_DOCKERFILE) -t $(BUILDER_IMAGE) ci/

builder-shell: builder ## Open a shell inside the builder image
	docker run --rm -it -v $(CURDIR):/workspace $(BUILDER_IMAGE)

lint: ## Run shellcheck on shell scripts
	@files="$$(find tools ci -name '*.sh' -type f)"; \
	if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck -x $$files; \
	else \
		docker run --rm -v $(CURDIR):/workspace $(BUILDER_IMAGE) shellcheck -x $$files; \
	fi

docs: ## Build the documentation site (strict mode)
	python3 -m venv $(VENV)
	$(VENV)/bin/pip install -q -r requirements-docs.txt
	$(VENV)/bin/mkdocs build --strict

test: ## Run unit tests (bats) inside the builder image
	docker run --rm -v $(CURDIR):/workspace $(BUILDER_IMAGE) bats tests/unit

clean: ## Remove local build artifacts
	rm -rf site $(VENV) .cache
