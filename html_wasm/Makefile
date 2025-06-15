.PHONY: build-wasm
build-wasm:
	@docker build \
	--target runtime \
	-t toy-marimo-wasm \
	.

.PHONY: run-wasm
run-wasm:
	@docker run \
	--rm \
	-p 8000:8000 \
	toy-marimo-wasm
