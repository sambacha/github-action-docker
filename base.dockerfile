# syntaxdocker/dockerfile-upstream:master-experimental
FROM alpine:3.16 AS builder

ARG VERSION="local"
ARG REVISION="none"
ARG GITHUB_WORKFLOW="none"
ARG GITHUB_RUN_ID="none"
ARG WORKSPACE_DIR=/workspace

RUN apk upgrade
RUN apk update && apk add --no-cache \
    && apk add --no-cache bash git grep coreutils \
    && rm -rf /var/cache/*/* \
    && echo "" > /root/.ash_history;

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
ENV LC_ALL=en_US.UTF-8


# see https://github.blog/2022-04-12-git-security-vulnerability-announced/
RUN git config --global --add safe.directory ${WORKSPACE_DIR}
ENV ACTIONS_RUNNER_DEBUG=true

# Build doc by default
WORKDIR ${WORKSPACE_DIR}
ENTRYPOINT ['']
CMD []


LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.revision=${REVISION}
LABEL org.opencontainers.image.vendor="CommodityStream, Inc"
LABEL org.opencontainers.image.licenses="UPL-1.0"
LABEL github.workflow=${GITHUB_WORKFLOW}
LABEL github.runid=${GITHUB_RUN_ID}