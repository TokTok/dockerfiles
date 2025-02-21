DOCKER_BUILD := docker build --ulimit memlock=67108864

run: build-serving
	docker run --rm -it -e PORT=8080 -p 8080:8080 ghcr.io/toktok/kythe-serving

build-serving: build-tables build-release build-webui
	$(DOCKER_BUILD) serving -t ghcr.io/toktok/kythe-serving

build-tables: build-buildenv
	$(DOCKER_BUILD) tables -t ghcr.io/toktok/kythe-tables

build-buildenv: build-release
	$(DOCKER_BUILD) buildenv -t ghcr.io/toktok/kythe-buildenv

build-release:
	$(DOCKER_BUILD) release -t ghcr.io/toktok/kythe-release

build-webui:
	$(DOCKER_BUILD) webui -t ghcr.io/toktok/kythe-webui
