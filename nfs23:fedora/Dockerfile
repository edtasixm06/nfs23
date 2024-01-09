# NFS Fedora32
# @edt ASIX M06-ASO 2023-2024
FROM fedora:32
RUN yum -y install vim nmap git tree procps  nfs-utils
RUN mkdir /opt/docker
ADD . /opt/docker
COPY exports /etc/exports
RUN mkdir /export
WORKDIR /export
RUN git clone https://gitlab.com/edtasixm06/m06-aso.git
RUN chmod +x /opt/docker/startup.sh
CMD /opt/docker/startup.sh
