FROM devtools/go-toolset-7-rhel7:latest as builder

WORKDIR /go/src/github.com/lomik/carbon-clickhouse

COPY . .

RUN apk --no-cache add make

RUN make

FROM rhel7/rhel-atomic:latest

RUN apk --no-cache add ca-certificates
WORKDIR /

COPY --from=builder /go/src/github.com/lomik/carbon-clickhouse/carbon-clickhouse ./usr/bin/carbon-clickhouse

CMD ["carbon-clickhouse"]

