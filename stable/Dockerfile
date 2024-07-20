FROM centos:8

ENV     LD_LIBRARY_PATH=/usr/local/lib
ENV     CXXFLAGS="-fPIC -march=native -O2"
ENV	CFLAGS="-fPIC -march=native -O2"

RUN     pushd /etc/yum.repos.d/ && \
        sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
        sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
        popd

RUN     yum -y update && \
        yum install -y \
                util-linux \
                glibc-devel \
                postgresql-libs \
                postgresql-devel \
                gcc \
                gcc-c++ \
                python3-devel \
                python3-setuptools    

RUN     pip3 install psutil setuptools pygresql psycopg2
#lockfile paramiko            

RUN     ls /usr/bin/python3.6 >> /dev/null 2>&1 && ln -s /usr/bin/python3.6 /usr/bin/python

RUN     yum install --enablerepo=powertools -y \
                unzip \
                which \
                tar \
                util-linux-ng \
                passwd \
                openssh-clients \
                openssh-server \
                ed \
                m4 \
                wget \
                sudo \
                git \
                net-tools \
                iproute \
	        bison \
                flex \
                make \
                perl-devel \
	        perl-ExtUtils-Embed \
                readline-devel \
                apr-devel \
                libevent-devel \
                libyaml-devel \
                libcurl-devel \
                bzip2-devel \
                libxml2-devel \
                openssl-devel \
                scl-utils \
                cmake3 \
                libzstd-devel \
                rsync

RUN     mkdir -p /usr/src/

COPY    gpdb-archive-main /usr/src/gpdb

RUN     cd /usr/src/gpdb && mkdir -p /usr/local/gpdb && \
        # git submodule update --init && \
        ./configure --disable-orca --with-perl --with-python --with-libxml --with-gssapi --prefix=/usr/local/gpdb && \
        make -j8 && \
        make -j8 install 

RUN     yum clean all && \
        chmod 755 /usr/local/gpdb/greenplum_path.sh && source /usr/local/gpdb/greenplum_path.sh

COPY    gpdb-entrypoint.sh gpdb-seg-entrypoint.sh configs/* /tmp/

RUN     cat /tmp/sysctl.conf.add >> /etc/sysctl.conf \
        && cat /tmp/limits.conf.add >> /etc/security/limits.conf \
        && rm -f /tmp/*.add \
	# && cp /usr/local/lib/lib* /usr/local/gpdb/lib/ \
        && chmod 777 /tmp/gpinitsystem.conf \
        && mv /tmp/discover_segments.sh /usr/local/bin/discover_segments.sh \
        && chmod 755 /usr/local/bin/discover_segments.sh \
        && mv /tmp/gpdb-entrypoint.sh /usr/local/bin/gpdb-entrypoint.sh \
        && mv /tmp/gpdb-seg-entrypoint.sh /usr/local/bin/gpdb-seg-entrypoint.sh \
        && chmod 755 /usr/local/bin/gpdb-entrypoint.sh \
        && chmod 755 /usr/local/bin/gpdb-seg-entrypoint.sh \
        && /usr/sbin/groupadd gpadmin \
        && /usr/sbin/useradd gpadmin -g gpadmin -G wheel \
        && echo "greenplum"|passwd --stdin gpadmin \
        && echo "gpadmin        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers \
        && mv /tmp/bash_profile /home/gpadmin/.bash_profile \
        && chown gpadmin:gpadmin /tmp/gpinitsystem.conf \
        && chown -R gpadmin: /home/gpadmin \
        && mkdir -p /gpdata/master /gpdata/segments \
        && chown -R gpadmin: /gpdata \
        && chown -R gpadmin: /usr/local/gpdb \
 	&& chown gpadmin:gpadmin /usr/local \
        && chown -R root:gpadmin /root \
        && rm -rf /run/nologin \
        && PATH=$PATH:/usr/src/gpdb/gpMgmt/bin

USER gpadmin
ENV LOGNAME gpadmin
WORKDIR /home/gpadmin

RUN mkdir .ssh && chmod 0700 .ssh && cd .ssh \
        && ssh-keygen -f id_rsa -t rsa -N '' \
        && touch authorized_keys \
        && chmod 0600 auth* id* \
        && chmod 0644 id*.pub \
        && cat id_rsa.pub | sed 's/@.*$/@master/' >> authorized_keys

ENV MASTER_DATA_DIRECTORY=/gpdata/master/gpseg-1

EXPOSE 5432 22

VOLUME /gpdata

ENTRYPOINT ["gpdb-entrypoint.sh"]
