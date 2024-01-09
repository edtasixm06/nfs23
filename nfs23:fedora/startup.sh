#! /bin/bash

exportfs -arv
rpcbind
rpc.statd
rpc.nfsd
rpc.mountd -F
/bin/bash
