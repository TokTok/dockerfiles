# Extract index.
FROM toxchat/kythe-buildenv:latest

# From: https://kythe.io/examples/#extracting-other-bazel-based-repositories
RUN ["git", "clone", "--depth=50", "--recursive", "-j8",\
 "https://github.com/TokTok/toktok-stack",\
 "/src/workspace"]

RUN ["/opt/build_index.sh"]
