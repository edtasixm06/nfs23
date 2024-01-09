# NFS debian 11
# @edt ASIX M06-ASO 2023-2024
FROM debian:11
RUN apt-get update && apt-get install -y  vim nmap git tree iproute2 nfs-common nfs-kernel-server
RUN mkdir /opt/docker
ADD . /opt/docker
COPY exports /etc/exports
RUN mkdir /export
WORKDIR /export
RUN git clone https://gitlab.com/edtasixm06/m06-aso.git
RUN chmod +x /opt/docker/startup.sh
CMD /opt/docker/startup.sh
