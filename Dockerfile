# haproxy-lb
FROM centos:centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Chandu Manda <cmanda@axway.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for Load balancer for STEC" \
      io.k8s.display-name="haproxy-lb 1.0" \
      io.openshift.expose-services="444:http,443:http,22:tcp,10080:tcp,10443:tcp,4022:tcp,4021:tcp" \
      io.openshift.tags="axwcentos,haproxy-lb"

# TODO: Install required packages here:
RUN yum -y update; yum clean all;
RUN yum -y install sudo net-tools bind-utils haproxy telnet which unzip wget expect cronie; yum clean all

#install application pre-requisites
#RUN yum -y install glusterfs perl perl-Data-Dumper glibc.i686 libgcc.i686 ncurses-libs.i686 libstdc++.i686 zlib.i686 libaio.i686 compat-libstdc++-33 compat-db47 libaio; yum clean all;

LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

# TODO (optional): Copy the builder files into /opt/app-root
COPY ./etc/ /opt/app-root/etc

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
#RUN chown -R 1001:1001 /opt/app-root
RUN echo "root:axway" | chpasswd

#setup non-root user
RUN adduser axway
RUN usermod -aG wheel axway
RUN echo "axway:axway" | chpasswd
RUN echo "axway    ALL=(ALL)       ALL" >> /etc/sudoers.d/axway

# This default user is created in the openshift/base-centos7 image
#USER 1001

EXPOSE 22 444 80 443 8080 10080 10443 8006 4022 17617 17627 19617 19627

# TODO: Set the default CMD for the image
CMD ["/usr/libexec/s2i/usage"]
