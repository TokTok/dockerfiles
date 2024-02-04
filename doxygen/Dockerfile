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
 "libc++-dev", \
 "libc++-static", \
 "libxml2-dev", \
 "llvm-dev", \
 "llvm-gtest", \
 "llvm-static", \
 "samurai", \
 "spdlog-dev", \
 "sqlite-dev", \
 "texlive"]

ENV CXXFLAGS="-stdlib=libc++"

WORKDIR /work
RUN git clone --depth=1 https://github.com/doxygen/doxygen /work/doxygen \
 && cmake -Hdoxygen -B_build -GNinja -Duse_libclang=ON -Duse_sys_sqlite3=on -Duse_sys_spdlog=ON \
 && cmake --build _build --target=install || true
# && rm -rf doxygen _build
