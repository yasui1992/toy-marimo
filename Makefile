.PHONY: build
build:
	@docker build \
	--target runtime \
	-t toy-marimo \
	.

.PHONY: build-wasm-server
build-wasm-server:
	@docker build \
	-f Dockerfile.wasm-server \
	--target runtime \
	-t toy-marimo-wasm-server \
	.

.PHONY: run
run:
	@docker run \
	--rm \
	-p 8000:8000 \
	-v $(PWD)/mnt:/app/mnt \
	toy-marimo

.PHONY: export-wasm
export-wasm:
	@if [ -z "$(filename)" ]; then \
		echo "Error: filename is not set. Usage: make export-wasm filename=<your .py filename>"; \
		exit 1; \
	fi
	@rm -rf $(PWD)/html_wasm/export
	@mkdir $(PWD)/html_wasm/export
	@docker run --rm \
	-v $(PWD)/mnt/notebooks/$(filename):/tmp/$(filename) \
	-v $(PWD)/html_wasm/export:/tmp/export \
	toy-marimo export html-wasm \
	/tmp/$(filename) \
	-o /tmp/export \
	--mode run

.PHONY: serve-wasm
serve-wasm:
	@docker run \
	--rm \
	-p 8000:8000 \
	toy-marimo-wasm-server
