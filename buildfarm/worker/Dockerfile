FROM toxchat/buildfarm-base:latest as base
FROM toxchat/builder:latest

COPY --from=base /buildfarm-memory-worker_deploy.jar /
COPY logging.properties worker.config /config/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
