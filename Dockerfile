FROM hashicorp/terraform:latest

RUN apk add --no-cache curl
RUN apk add jq
RUN apk add aws-cli


# add kube configs and crts
COPY . /terra-fied

# terraform state directory
# RUN mkdir /terra-fied/.state
# VOLUME .state

WORKDIR /terra-fied