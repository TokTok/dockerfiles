run:
	docker run --rm -it -v $(PWD)/../../c-toxcore:/c-toxcore toxchat/freebsd ./cmake-freebsd-stage2

build-final:
	docker build -t toxchat/freebsd final

build: Dockerfile
	docker build -t toxchat/freebsd-base .
	-docker rm freebsd_setup_vm
	docker run -it --name=freebsd_setup_vm toxchat/freebsd-base ./setup-vm
	docker commit freebsd_setup_vm toxchat/freebsd-layered
	docker rm freebsd_setup_vm
