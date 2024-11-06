FROM golang:bullseye as base
WORKDIR /app
USER root

RUN apt-get -f -y install --reinstall ca-certificates \
    && update-ca-certificates
RUN export PATH=$(go env GOPATH)/bin:$PATH

RUN go install go.k6.io/xk6/cmd/xk6@latest
RUN xk6 build --with github.com/avitalique/xk6-file@latest
USER k6
ENTRYPOINT ["/usr/local/bin/run.sh"]
