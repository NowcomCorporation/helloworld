FROM debian:jessie as build-env

# install curl
RUN apt-get update && apt-get install -qy curl

# install go runtime
RUN curl -s https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | tar -C /usr/local -xz

# prepare go environment
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/go/bin

# add the current build context
ADD . /go/src/github.com/nowcomcorporation/helloworld

# compile the binary
RUN cd /go/src/github.com/nowcomcorporation/helloworld && go install -v .

#FROM alpine
#LABEL maintainer="Robert Kozak <rkozak@nowcom.com>"

#WORKDIR /go/bin
#COPY --from=build-env /go/bin /go/bin
#COPY --from=build-env /usr/local/go/bin /usr/local/go/bin

EXPOSE 80

ENTRYPOINT ["/go/bin/helloworld"]
