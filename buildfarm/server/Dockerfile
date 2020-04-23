# hadolint ignore=DL3007
FROM toxchat/buildfarm-base:latest as base
FROM alpine:3.11.5
RUN apk --no-cache add openjdk8

COPY --from=base /buildfarm-server_deploy.jar /
COPY logging.properties server.config /config/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
