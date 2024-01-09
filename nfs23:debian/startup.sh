#! /bin/bash

exportfs -avr
/sbin/rpcbind
/sbin/rpc.statd
/usr/sbin/rpc.nfsd
/usr/sbin/rpc.mountd -F
/bin/bash
