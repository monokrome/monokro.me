all: target/debug/mk

target/debug/mk:
	cargo build

develop:
	which watchexec || cargo install watchexec
	watchexec --restart "cargo run"

clean:
	rm -rf target

.PHONY: all clean develop
