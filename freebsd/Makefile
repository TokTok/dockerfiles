build: Dockerfile
	docker build -t toxchat/freebsd:base .

run:
	docker run --rm -it -v $(realpath ../../c-toxcore):/c-toxcore toxchat/freebsd /c-toxcore/.travis/cmake-freebsd-stage2
