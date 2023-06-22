#!/usr/bin/env sh
if [[ -f $(which uuencode 2>/dev/null) ]]
    then
        GEN_PW_SSH=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_SSH_KEY=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w128 | head -n 1)
        GEN_PW_FTP=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_MYSQL=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_MAIL=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        echo "SSH-Password: $GEN_PW_SSH"
        echo "SSH-KEY-Password: $GEN_PW_SSH_KEY"
        echo "FTP User Password: $GEN_PW_FTP"
        echo "MYSQL User Password: $GEN_PW_MYSQL"
        echo "e-Mail User Password: $GEN_PW_MAIL"
    else
        GEN_PW_SSH=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_SSH_KEY=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w128 | head -n 1)
        GEN_PW_FTP=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_MYSQL=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        GEN_PW_MAIL=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n 1)
        echo "SSH-Password: $GEN_PW_SSH"
        echo "SSH-KEY-Password: $GEN_PW_SSH_KEY"
        echo "FTP User Password: $GEN_PW_FTP"
        echo "MYSQL User Password: $GEN_PW_MYSQL"
        echo "e-Mail User Password: $GEN_PW_MAIL"

fi

