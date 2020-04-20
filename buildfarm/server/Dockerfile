FROM toxchat/buildfarm-base:1.0.0 as base
FROM alpine:3.11.5
RUN apk --no-cache add openjdk8

COPY --from=base /buildfarm-server_deploy.jar /
COPY logging.properties server.config /config/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
