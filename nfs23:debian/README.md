# nfs23:alpine
## @edt ASIX M06-ASO Curs 2023-2024

#### NFS Debian

Procediment:
 * Instal·lar els paquets
 * Definir les exportacions
 * Activar els serveis


#### Descripció

El servidor NFS és diferent en sistemes Debian, Alpine, Fedora, etc. En uns (alpine i fedora) el paquet és
*nfs-utils* i des d'aquest paquet activant-lo amb systemctl ja s'estira de tot.  En altres (Debian) està
format pels paquets **nfs-common** i **nfs-kernel-server**.


En tot cas el problema és que si no és disposa del systemctl per activar-ho tot, cal activar manualment els
serveis depenents un a un.


També s'ha d'estar al cas de si s'estan compartint *shares* amb NFS3 o NFS4 que canvia totalment.

**Atenció**: un *problema*afegit és que NFS no permet exportar dels sistemes de fitxers tmpfs i overlay, de manera
que caldrà que el sistema de fitxers subjacent dels directoris a exportar sigui per exemple ext4. Una manera
de fer-ho és que sigui un volum muntant al container.

**Atenció**: cal fer que els containers siguin **privileged** o activar les *CAP* capabilities pertinents si es vol
poder exportar i muntar (en tots dos casos!).



#### Creació del container / execució

Per treballar-hi interactivament
```
$ docker run --rm --name nfsa -h nfsa --net mynet --privileged -v data-nfs-deb:/export -it edtasixm06/nfs23:debian /bin/bash
/export # /opt/docker/startup.sh
/export # exportfs -v
```

Per deixar-lo en detach
```
[ecanet@mylaptop]$ docker run --rm --name nfsd -h nfsd --net mynet --privileged -v data-nfs-deb:/export -p 2049:2049 -d edtasixm06/nfs23:debian 
c67a2d920268787374348079034fe948328eb8628bb2a7c03c0f331ebc00b7b9

[ecanet@mylaptop]$ docker ps
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS         PORTS                                       NAMES
c67a2d920268   edtasixm06/nfs23:debian   "/bin/sh -c /opt/doc…"   3 seconds ago   Up 2 seconds   0.0.0.0:2049->2049/tcp, :::2049->2049/tcp   nfsd

[ecanet@mylaptop]$ docker stop nfsd
nfsa
```



#### Muntar un recurs NFS com a client

Des de dins dle propi container
```
/export # mount -t nfs localhost:/export /mnt
/export # ls /mnt/
m06-aso
```


Des del host amfitrió 
```
[ecanet@mylaptop]$ nmap 172.18.0.2
Starting Nmap 7.80 ( https://nmap.org ) at 2024-01-09 12:02 CET
Nmap scan report for 172.18.0.2
Host is up (0.00013s latency).
Not shown: 998 closed ports
PORT     STATE SERVICE
111/tcp  open  rpcbind
2049/tcp open  nfs

[ecanet@mylaptop]$ sudo mount -t nfs  172.18.0.2:/export /mnt
[ecanet@mylaptop]$ mount -t nfs
172.18.0.2:/export on /mnt type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=172.18.0.2,mountvers=3,mountport=38786,mountproto=udp,local_lock=none,addr=172.18.0.2)
[ecanet@mylaptop]$ sudo umount /mnt 
```


Des d'un altre host (cal que el *docker run* propogui el port -p 2049:2049)
```
[ecanet@mylaptop]$ docker run --rm --name nfsa -h nfsa --net mynet --privileged -v data-nfs-deb:/export -p 2049:2049 -d edtasixm06/nfs23:debian 
56b2fa6b7f38f7a2d4756a71a34b1252a90f9f66c9c015136ad0b96ce5213ad0
[ecanet@mylaptop]$ docker ps
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS         PORTS                                       NAMES
56b2fa6b7f38   edtasixm06/nfs23:debian   "/bin/sh -c /opt/doc…"   3 seconds ago   Up 2 seconds   0.0.0.0:2049->2049/tcp, :::2049->2049/tcp   nfsd

[ecanet@mylaptop]$ sudo mount -t nfs  <ip-host-amfitrio>:/export /mnt
[ecanet@mylaptop]$ sudo umount /mnt
```





