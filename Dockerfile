FROM python:alpine
LABEL maintainer "Tony Davis <tony@virtuallytd.com>"

ARG CLI_VERSION=1.18.188

RUN apk -uv add --no-cache \
    groff \
    less \
    && pip install --no-cache-dir awscli==$CLI_VERSION

WORKDIR /aws

CMD sh