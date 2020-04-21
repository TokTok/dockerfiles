build: build-builder build-buildfarm-base build-buildfarm-server build-buildfarm-worker

build-builder:
	docker build builder -t toxchat/builder:1.0.0

build-buildfarm-base:
	docker build base -t toxchat/buildfarm-base:1.0.0

build-buildfarm-server:
	docker build server -t toxchat/buildfarm-server:1.0.0

build-buildfarm-worker:
	docker build worker -t toxchat/buildfarm-worker:1.0.0


push: push-builder push-buildfarm-base push-buildfarm-server push-buildfarm-worker

push-builder: build-builder
	docker push toxchat/builder:1.0.0

push-buildfarm-base: build-buildfarm-base
	docker push toxchat/buildfarm-base:1.0.0

push-buildfarm-server: build-buildfarm-server
	docker push toxchat/buildfarm-server:1.0.0

push-buildfarm-worker: build-buildfarm-worker
	docker push toxchat/buildfarm-worker:1.0.0


check: build-buildfarm-server build-buildfarm-worker test/integration_test
	test/integration_test
