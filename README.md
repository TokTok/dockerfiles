# Dockerfile collection

This is a collection of Dockerfiles (see
[Wikipedia](https://en.wikipedia.org/wiki/Docker_(software))) for cross
compilation to various platforms. Currently, we provide two basic cross compiler
environments, each with a few platform variants. All environments are also
rebuilt and updated regularly when the source files change.

- GHC 8.0.1 on Android
  - `toktoknet/ghc-android:latest.aarch64`: ARM64
  - `toktoknet/ghc-android:latest.arm`: ARM EABI (32 bit)
  - `toktoknet/ghc-android:latest.i686`: Intel x86
  - `toktoknet/ghc-android:latest.x86_64`: AMD64

- Windows: contains pre-compiled `libvpx`, `opus`, `libsodium`, and `check`,
  used for toxcore compilation. It also contains a working `wine` installation
  set up to run executables built for the chosen platform.
  - `toktoknet/windows:latest.i686-shared`: Supporting both shared and
    statically linked libraries.
  - `toktoknet/windows:latest.i686-static`: Supporting only fully static builds.
    Choose this if you want to build statically linked binaries. Some libraries
    (like Qt) need to be built in a fully static environment to be statically
    linkable. The `-shared` variants won't support that use case.
  - `toktoknet/windows:latest.x86_64-shared`: Win64 shared linking environment.
  - `toktoknet/windows:latest.x86_64-static`: Win64 static linking environment.
    See above for considerations.

Furthermore, to support our own use cases, which are building the Tox client
[qTox](https://github.com/TokTok/qTox) and the Haskell Tox implementation
[hstox](https://github.com/TokTok/hs-toxcore), we support images built on the
above base environments:

- GHC 8.0.1 on Android with hstox dependencies pre-built. This allows for much
  shorter development cycles, as only hstox itself needs to be built. It also
  allows us to use a different system user for the hstox build, keeping the
  cabal package database read-only. All 4 platforms are supported. Replace
  `ghc-android` with `ghc-android-hstox` in the above list.
- Windows with Qt5. To build qTox, we provide an image with all its dependencies
  (Qt5, ffmpeg, gtk2, openal, qrencode, sqlcipher) in addition to the toxcore
  dependencies in the base image.

## Usage

### ghc-android

The `ghc-android` environments are used as follows (the ARM build is used as an
example):

```sh
IMAGE=toktoknet/ghc-android:latest.arm
# Pull the image from dockerhub.
docker pull $IMAGE
# Get the "dockrun" script from the image, which automatically mounts the
# current directory to /work in the container.
docker run --rm $IMAGE cat /root/dockrun > dockrun
chmod +x dockrun
```

Now we can use the `dockrun` script to build cabal packages in the current
directory:

```sh
./dockrun target-cabal configure
./dockrun target-cabal build
```

After this, if your package built successfully, you will have ARM binaries in
your `dist` directory. If you have a non-simple `Setup.lhs`, you need to first
compile it with the host cabal:

```sh
./dockrun cabal configure        # Compiles Setup.lhs (or Setup.hs).
./dockrun target-cabal configure # Re-configure with target-cabal.
./dockrun target-cabal build
```

### windows

The Windows environments work in a similar way:

```sh
IMAGE=toktoknet/windows:latest.i686-shared
# Pull the image from dockerhub.
docker pull $IMAGE
# Get the "dockrun" script from the image, which automatically mounts the
# current directory to /work in the container.
docker run --rm $IMAGE > dockrun
chmod +x dockrun
```

Then, build your program or library:

```sh
# With autotools:
./dockrun ./configure --host=i686-w64-mingw32.shared # note the "shared"
./dockrun make
# With cmake:
./dockrun i686-w64-mingw32.shared-cmake -B_build -H.
./dockrun make -C_build
```
