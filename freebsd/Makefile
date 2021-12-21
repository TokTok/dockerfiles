run:
	docker run --rm -it -v $(realpath ../../c-toxcore):/c-toxcore toxchat/freebsd /c-toxcore/.travis/cmake-freebsd-stage2

build-final:
	docker build -t toxchat/freebsd:latest final

build: Dockerfile
	docker build -t toxchat/freebsd:base .
	-docker rm freebsd_setup_vm
	docker run -it --name=freebsd_setup_vm toxchat/freebsd:base ./setup-vm
	docker commit freebsd_setup_vm toxchat/freebsd:layered
	docker rm freebsd_setup_vm
