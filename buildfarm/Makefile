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


.INTERMEDIATE: rbe_configs_gen
rbe_configs_gen:
	wget -O $@ https://github.com/bazelbuild/bazel-toolchains/releases/download/v5.1.1/rbe_configs_gen_linux_amd64
	chmod +x $@

test/tools/toolchain/LICENSE: rbe_configs_gen
	$(MAKE) push-builder
	./rbe_configs_gen \
	  --bazel_version="4.2.2" \
	  --toolchain_container=toxchat/builder:latest \
	  --output_src_root="$(realpath test)" \
	  --output_config_path=tools/toolchain \
	  --exec_os=linux \
	  --target_os=linux


check: build-buildfarm-base build-buildfarm-server build-buildfarm-worker test/integration_test test/tools/toolchain/LICENSE
	test/integration_test
