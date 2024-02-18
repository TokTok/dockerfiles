FROM alpine:3.19.0

RUN ["apk", "add", "--no-cache", \
 "bash", \
 "file", \
 "g++", \
 "gcc", \
 "git", \
 "linux-headers", \
 "musl-dev", \
 "nawk"]

RUN ["git", "clone", "--branch=pkgsrc-2023Q4", "--depth=1", "https://github.com/NetBSD/pkgsrc", "/work/pkgsrc"]
WORKDIR /work/pkgsrc/bootstrap
ENV TOOLS_PLATFORM.awk=/usr/bin/nawk
RUN ["./bootstrap"]
ENV PATH=/usr/pkg/bin:$PATH
RUN ["/usr/pkg/sbin/pkg_admin", "-K", "/usr/pkg/pkgdb", "fetch-pkg-vulnerabilities"]

WORKDIR /work/pkgsrc/chat/toxcore
RUN ["bmake"]
