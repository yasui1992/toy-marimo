.PHONY: build
build:
	@docker build \
	--target runtime \
	-t toy-marimo \
	.

.PHONY: run
run:
	@docker run \
	--rm \
	-p 8000:8000 \
	-v $(PWD)/mnt:/app/mnt \
	toy-marimo
