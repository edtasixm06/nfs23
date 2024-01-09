#! /bin/sh

exportfs -arv
rpcbind
rpc.statd
rpc.nfsd
rpc.mountd -F
/bin/sh
