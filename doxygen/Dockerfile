FROM alpine:3.19.0

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN ["apk", "add", "--no-cache", \
 "bison", \
 "clang-dev", \
 "clang-static", \
 "cmake", \
 "flex", \
 "git", \
 "graphviz", \
 "libxml2-dev", \
 "llvm-dev", \
 "llvm-gtest", \
 "llvm-static", \
 "samurai", \
 "texlive"]

ENV CC=clang CXX=clang++ CXXFLAGS="-Dstat64=stat -Dfstat64=fstat"

WORKDIR /work
RUN git clone --depth=1 https://github.com/doxygen/doxygen /work/doxygen \
 && sed -i -e 's|.*finally, turn off warnings|//&|' doxygen/src/clangparser.cpp \
 && cmake -Wno-dev -Hdoxygen -B_build -GNinja -Duse_libclang=ON -Duse_libc++=OFF \
 && cmake --build _build --target=install \
 && rm -rf doxygen _build
