# https://raw.githubusercontent.com/TokTok/dockerfiles/master/windows/src/Dockerfile.in
FROM toktoknet/windows:latest.i686-shared
MAINTAINER Iphigenia Df "iphydf@gmail.com"

RUN cd /usr/src/mxe \
&& make -j12 \
   ffmpeg \
   gtk2 \
   openal \
   qtbase \
   qtsvg \
   qttools \
&& make clean-junk clean-pkg

RUN curl https://fukuchi.org/works/qrencode/qrencode-3.4.4.tar.gz | tar zx \
&& cd qrencode-3.4.4 \
&& ./configure \
     --prefix=/usr/src/mxe/usr/i686-w64-mingw32.shared \
     --host=i686-w64-mingw32.shared \
     --disable-thread-safety \
     --enable-shared --disable-static \
&& make && make install \
&& cd .. && rm -rf qrencode-3.4.4*

RUN apt-get install -y tcl

COPY patches/sqlcipher.patch /work/
RUN git clone --depth=1 --branch=v3.3.1 https://github.com/sqlcipher/sqlcipher \
&& cd sqlcipher \
&& patch -p1 < ../sqlcipher.patch \
&& autoreconf -fi \
&& sed -i -e 's/SQLITE_OS_UNIX=1/SQLITE_OS_WIN=1/' configure \
&& sed -i -e 's/install:\tsqlcipher\$(BEXE)/install:/' Makefile.in \
&& sed -i -e 's/\$(LTINSTALL) sqlcipher\$(BEXE)/#&/' Makefile.in \
&& ./configure \
     --prefix=/usr/src/mxe/usr/i686-w64-mingw32.shared \
     --host=i686-w64-mingw32.shared \
     --disable-tcl \
     --disable-amalgamation \
     --with-crypto-lib=openssl \
     --enable-shared --disable-static \
     || (cat config.log && false) \
&& make && make install \
&& cd .. && rm -rf sqlcipher*

ENV DEFAULT_DOCKCROSS_IMAGE toktoknet/windows-qt5:latest.i686-shared
