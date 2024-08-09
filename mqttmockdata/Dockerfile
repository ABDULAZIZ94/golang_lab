FROM --platform=amd64 golang:alpine

LABEL version = "1.0"

LABEL maintainer="Abdul Aziz <aziz@vectolabs.com>"

WORKDIR $GOPATH/src/gitlab.com/mqttmockdata

COPY . .

COPY ./cmd/.env.* .

RUN go get -d -v ./...

RUN go install -v ./...

EXPOSE 7790

EXPOSE 3030

CMD [ "cmd" ]

