FROM golang:1.8.3-alpine

# To use as custom-build docker images, 
# container image must have installed following tools: 
#  git, ssh, tar, gzip, ca-certificates
# https://circleci.com/docs/2.0/custom-images/
RUN set -x \
    && apk add --no-cache \
    git \
    openssh-client \
    tar \
    gzip \
    ca-certificates \
    build-base \
    curl \
    py-pip

RUN set -x \
    && pip install awscli

ENV GOPATH /go
ENV APP_DIR ${GOPATH}/src/github.com

RUN set -x \
    && adduser -D -u 1000 go \
    && echo 'go:password' | chpasswd \
    && mkdir -p ${APP_DIR} \
    && chown -R go:go /go

WORKDIR ${APP_DIR}
USER go

RUN set -x \
    && go get -u github.com/golang/dep/...
