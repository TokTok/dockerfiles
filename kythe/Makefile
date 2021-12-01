DOCKER_BUILD := docker build --ulimit memlock=67108864

run: build-serving
	docker run --rm -it -e PORT=8080 -p 8080:8080 toxchat/kythe-serving

build-serving: build-tables build-release build-webui
	$(DOCKER_BUILD) serving -t toxchat/kythe-serving

build-tables: build-buildenv
	$(DOCKER_BUILD) tables -t toxchat/kythe-tables

build-buildenv: build-release
	$(DOCKER_BUILD) buildenv -t toxchat/kythe-buildenv

build-release:
	$(DOCKER_BUILD) release -t toxchat/kythe-release

build-webui:
	$(DOCKER_BUILD) webui -t toxchat/kythe-webui
