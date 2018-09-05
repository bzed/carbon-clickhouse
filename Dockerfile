FROM registry.access.redhat.com/devtools/go-toolset-7-rhel7

WORKDIR /go/src/github.com/lomik/carbon-clickhouse
COPY . .

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    yum install -y golang make ca-certificates

RUN make && cp carbon-clickhouse /usr/local/bin/carbon-clickhouse
RUN mkdir -p /etc/carbon-clickhouse
RUN ./carbon-clickhouse -config-print-default | sed 's,/var/log/carbon-clickhouse/carbon-clickhouse.log,stdout,g' > /etc/carbon-clickhouse/config

CMD ["/usr/local/bin/carbon-clickhouse", "-config", "/etc/carbon-clickhouse/config"]

EXPOSE 2003/udp 2003/tcp 2004/tcp 2005/tcp 2006/tcp
