build: build-builder build-buildfarm-base build-buildfarm-server build-buildfarm-worker

build-builder:
	docker build builder -t toxchat/builder:latest

build-buildfarm-base:
	docker build base -t toxchat/buildfarm-base:latest

build-buildfarm-server:
	docker build server -t toxchat/buildfarm-server:latest

build-buildfarm-worker:
	docker build worker -t toxchat/buildfarm-worker:latest


push: push-builder push-buildfarm-base push-buildfarm-server push-buildfarm-worker

push-builder: build-builder
	docker push toxchat/builder:latest

push-buildfarm-base: build-buildfarm-base
	docker push toxchat/buildfarm-base:latest

push-buildfarm-server: build-buildfarm-server
	docker push toxchat/buildfarm-server:latest

push-buildfarm-worker: build-buildfarm-worker
	docker push toxchat/buildfarm-worker:latest


check: build-buildfarm-server build-buildfarm-worker test/integration_test
	test/integration_test
