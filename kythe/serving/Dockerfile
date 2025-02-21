# Extract index.
FROM ghcr.io/toktok/kythe-release:latest as release
FROM ghcr.io/toktok/kythe-tables:latest as tables
FROM ghcr.io/toktok/kythe-webui:latest as webui
FROM ubuntu:22.04

COPY --from=release /opt/kythe /opt/kythe

COPY --from=tables /data /data
COPY --from=webui /data /data

COPY entrypoint.sh /opt/entrypoint.sh
CMD ["/opt/entrypoint.sh"]
