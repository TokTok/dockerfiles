build: build-builder build-base build-server build-worker

build-builder:
	docker build builder -t toxchat/builder:1.0.0

build-base: build-builder
	docker build base -t toxchat/buildfarm-base:1.0.0

build-server: build-base
	docker build server -t toxchat/buildfarm-server:1.0.0

build-worker: build-base
	docker build worker -t toxchat/buildfarm-worker:1.0.0


push: push-builder push-base push-server push-worker

push-builder: build-builder
	docker push toxchat/builder:1.0.0

push-base: build-base
	docker push toxchat/buildfarm-base:1.0.0

push-server: build-server
	docker push toxchat/buildfarm-server:1.0.0

push-worker: build-worker
	docker push toxchat/buildfarm-worker:1.0.0


check: build-server build-worker test/integration_test
	test/integration_test
