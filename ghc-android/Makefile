build: build-i686 build-arm

build-i686: Makefile
	docker build -t toktoknet/ghc-android:latest.i686 -f i686/Dockerfile i686

build-arm: Makefile
	docker build -t toktoknet/ghc-android:latest.arm -f arm/Dockerfile arm


push: push-i686 push-arm

push-i686: build-i686
	docker push toktoknet/ghc-android:latest.i686

push-arm: build-arm
	docker push toktoknet/ghc-android:latest.arm


Makefile: configure ../Makefile.pm $(shell find src -type f)
	./$<
