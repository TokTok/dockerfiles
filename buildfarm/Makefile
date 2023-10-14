build: build-builder build-buildfarm-base build-buildfarm-server build-buildfarm-worker

build-nix:
	docker build nix -t toxchat/nix:built
	id=$$(docker create toxchat/nix:built) && \
	   (docker cp -L $$id:/root/nix/nix.tar.gz nix.tar.gz && docker load -i nix.tar.gz; \
	   rm -f nix.tar.gz; \
	   docker rm -v $$id)

build-builder: build-nix
	docker build builder -t toxchat/builder:latest

build-bazel: build-builder
	docker build bazel -t toxchat/bazel:latest

build-buildfarm-base:
	docker build base -t toxchat/buildfarm-base:latest

build-buildfarm-server: build-buildfarm-base
	docker build server -t toxchat/buildfarm-server:latest

build-buildfarm-worker: build-buildfarm-base
	docker build worker -t toxchat/buildfarm-worker:latest


push: push-builder push-buildfarm-base push-buildfarm-server push-buildfarm-worker

push-nix: build-nix
	docker push toxchat/nix:latest

push-builder: build-builder
	docker push toxchat/builder:latest

push-bazel: build-bazel
	docker push toxchat/bazel:latest

push-buildfarm-base: build-buildfarm-base
	docker push toxchat/buildfarm-base:latest

push-buildfarm-server: build-buildfarm-server
	docker push toxchat/buildfarm-server:latest

push-buildfarm-worker: build-buildfarm-worker
	docker push toxchat/buildfarm-worker:latest


check: build-buildfarm-base build-buildfarm-server build-buildfarm-worker test/integration_test test/tools/toolchain/LICENSE
	test/integration_test
