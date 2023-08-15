# Extract index.
FROM toxchat/kythe-release:latest as release
FROM toxchat/kythe-tables:latest as tables
FROM toxchat/kythe-webui:latest as webui
FROM ubuntu:22.04

COPY --from=release /opt/kythe /opt/kythe

COPY --from=tables /data /data
COPY --from=webui /data /data

COPY entrypoint.sh /opt/entrypoint.sh
CMD ["/opt/entrypoint.sh"]
