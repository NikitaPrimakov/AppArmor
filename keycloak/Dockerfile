ARG DNS_QUERY=sso-dev-cfg

FROM registry.access.redhat.com/ubi9 AS ubi-micro-build

COPY certs/*.crt /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust

RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs p11-kit --releasever 9 --setopt install_weak_deps=false --nodocs -y && \

  dnf --installroot /mnt/rootfs clean all && \
  rpm --root /mnt/rootfs -e --nodeps setup

FROM quay.io/keycloak/keycloak:23.0

COPY --from=ubi-micro-build /etc/pki /etc/pki

USER root

RUN keytool -import -trustcacerts -alias tst.local -file /etc/pki/ca-trust/source/anchors/lo_iss.crt -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass changeit -noprompt
RUN keytool -import -trustcacerts -alias dkb.invalid -file /etc/pki/ca-trust/source/anchors/lo_root.crt -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass changeit -noprompt

RUN chmod 666 /usr/lib/jvm/java-17-openjdk-17.0.10.0.7-2.el9.x86_64/lib/tzdb.dat # для решение проблем с применением tzdb.dat

USER keycloak

ENV JAVA_OPTS_APPEND="-Djgroups.dns.query=${DNS_QUERY}"

COPY cache-ispn.xml /opt/keycloak/conf/cache-file.xml

RUN /opt/keycloak/bin/kc.sh build --cache=ispn --cache-stack=kubernetes --cache-config-file=cache-file.xml --features=docker --db=postgres

COPY cache-ispn.xml /opt/keycloak/conf/cache-ispn.xml


ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
