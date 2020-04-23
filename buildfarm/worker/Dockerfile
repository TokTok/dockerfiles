# hadolint ignore=DL3007
FROM toxchat/buildfarm-base:latest as base
# hadolint ignore=DL3007
FROM toxchat/builder:latest

COPY --from=base /buildfarm-operationqueue-worker_deploy.jar /
COPY logging.properties worker.config /config/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
