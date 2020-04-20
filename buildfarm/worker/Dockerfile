FROM toxchat/buildfarm-base:1.0.0 as base
FROM toxchat/builder:1.0.0

COPY --from=base /buildfarm-operationqueue-worker_deploy.jar /
COPY logging.properties worker.config /config/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
