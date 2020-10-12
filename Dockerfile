FROM golang:1.12.0

ENV USER root

WORKDIR /go/src/github.com/cloudflare/cfssl
COPY . .

# restore all deps and build
RUN go get github.com/cloudflare/cfssl_trust/... && \
  go get github.com/GeertJohan/go.rice/rice && \
  rice embed-go -i=./cli/serve && \
  cp -R /go/src/github.com/cloudflare/cfssl_trust /etc/cfssl && \
  go install ./cmd/... && \
  go clean -r -cache -modcache

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install awscli && pip cache purge

RUN chmod 755 init_cfssl.sh

EXPOSE 8888

CMD /go/src/github.com/cloudflare/cfssl/init_cfssl.sh
