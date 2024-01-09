# NFS alpine
# @edt ASIX M06-ASO 2023-2024
FROM alpine:latest
RUN apk add vim nmap git tree nfs-utils
RUN mkdir /opt/docker
ADD . /opt/docker
COPY exports /etc/exports
RUN mkdir /export
WORKDIR /export
RUN git clone https://gitlab.com/edtasixm06/m06-aso.git
RUN chmod +x /opt/docker/startup.sh
CMD /opt/docker/startup.sh
