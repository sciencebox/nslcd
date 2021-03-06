FROM cern/cc7-base:20201201-1.x86_64

MAINTAINER Enrico Bocchi <enrico.bocchi@cern.ch>

RUN yum -y install \
        nss-pam-ldapd \
        openldap-clients && \
      yum clean all && \
      rm -rf /var/cache/yum

RUN rm -f /etc/nscd.conf /etc/nsswitch.conf

CMD ["/usr/sbin/nslcd", "--debug"]
