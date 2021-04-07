#!/usr/bin/env sh
GEN_PW_SSH=$(for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
GEN_PW_SSH_KEY=$(for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-128
done)
GEN_PW_FTP=$(for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
GEN_PW_MYSQL=$(for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
GEN_PW_MAIL=$(for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)

if [[ -f $(which uuencode 2>/dev/null) ]]
    then
        echo "SSH-Password: $GEN_PW_SSH"
        echo "SSH-KEY-Password: $GEN_PW_SSH_KEY"
        echo "FTP User Password: $GEN_PW_FTP"
        echo "MYSQL User Password: $GEN_PW_MYSQL"
        echo "e-Mail User Password: $GEN_PW_MAIL"
    else
	    apt update && apt install sharutils
        echo "SSH-Password: $GEN_PW_SSH"
        echo "SSH-KEY-Password: $GEN_PW_SSH_KEY"
        echo "FTP User Password: $GEN_PW_FTP"
        echo "MYSQL User Password: $GEN_PW_MYSQL"
        echo "e-Mail User Password: $GEN_PW_MAIL"

fi
