#!/bin/bash
# Make sure only root can run our script
VERSION="Version: 0.6v"
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

clear
echo "$VERSION"
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                  (L)inux                     #"
echo "#                  (A)pache                    #"
echo "#                  (M)ysql                     #"
echo "#                  (P)HP                       #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"
echo ""
echo "It will now install the following packages: dialog, expect, sharutils"
sleep 2
sudo apt update && apt install dialog expect sharutils -y
GEN_PASS=$(
for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
GEN_PASS2=$(
for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
GEN_PASS3=$(
for ((n=0;n<1;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-32
done)
MYSQL_MYSQLADMIN_PASSWORD=$GEN_PASS
MYSQL_ROOT_PASSWORD=$GEN_PASS2
PHPMYADMIN_PASSPHRASE="$GEN_PASS3"

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")
serviceIP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')

HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=5
BACKTITLE="(L)inux(A)apache(M)ysql(P)HP Installer - $VERSION"
TITLE="Has LAMP ever been installed on this instance?"
MENU="Choose one of the following options:"

OPTIONS=(1 "No"
         2 "Yes"
         3 "Exit"
         4 "testing...")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
    case $CHOICE in
        1) # - No
            echo "Lets Go!"
            echo "start installer" # - start the normal installer
            sudo apt update
            sudo apt upgrade -y
            sudo apt install wget apache2 apache2-utils mariadb-server mariadb-client lsb-release ca-certificates apt-transport-https software-properties-common-y 
            echo "$SECURE_MYSQL"
            echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
            wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
            apt update
            sudo apt install php php-cgi php-mysqli php-pear php-mbstring php-gettext libapache2-mod-php php-common php-phpseclib php-mysql php8.0-bcmath php8.0-curl-dbgsym php8.0-gmp-dbgsym php8.0-mysql php8.0-pspell-dbgsym php8.0-tidy php8.0-bcmath-dbgsym php8.0-dba php8.0-imap php8.0-mysql-dbgsym php8.0-readline php8.0-tidy-dbgsym php8.0-bz2 php8.0-dba-dbgsym php8.0-imap-dbgsym php8.0-odbc php8.0-readline-dbgsym php8.0-xdebug php8.0-bz2-dbgsym php8.0-dev php8.0-interbase php8.0-odbc-dbgsym php8.0-snmp php8.0-xml php8.0-cgi php8.0-enchant php8.0-interbase-dbgsym  php8.0-opcache php8.0-snmp-dbgsym php8.0-xml-dbgsym php8.0-cgi-dbgsym php8.0-enchant-dbgsym php8.0-intl php8.0-opcache-dbgsym php8.0-soap php8.0-xsl php8.0-cli php8.0-fpm php8.0-intl-dbgsym php8.0-pgsql php8.0-soap-dbgsym php8.0-zip php8.0-cli-dbgsym php8.0-fpm-dbgsym php8.0-ldap php8.0-pgsql-dbgsym php8.0-sqlite3 php8.0-zip-dbgsym php8.0-common php8.0-gd php8.0-ldap-dbgsym php8.0-phpdbg php8.0-sqlite3-dbgsym php8.0-common-dbgsym php8.0-gd-dbgsym php8.0-mbstring php8.0-phpdbg-dbgsym php8.0-sybase php8.0-curl php8.0-gmp php8.0-mbstring-dbgsym php8.0-pspell php8.0-sybase-dbgsym -y
            wget -P Downloads https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
            wget -P Downloads https://files.phpmyadmin.net/phpmyadmin.keyring
            gpg --import ~/Downloads/phpmyadmin.keyring
            wget -P Downloads https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz.asc
            gpg --verify ~/Downloads/phpMyAdmin-latest-all-languages.tar.gz.asc
            mkdir /var/www/html/phpmyadmin
            sudo tar xvf ~/Downloads/phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
            sudo chown -R 33:33 /var/www/html/phpmyadmin
            echo "
<?php
declare(strict_types=1);
$cfg['blowfish_secret'] = '$GEN_PASS'; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */
$i = 0;
$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';" > /var/www/html/phpmyadmin/config.inc.php
            sudo chmod 660 /var/www/html/phpmyadmin/config.inc.php
            sudo systemctl restart apache2
            echo "CREATE USER 'mysqladmin'@'localhost' IDENTIFIED BY '$MYSQL_MYSQLADMIN_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost'; FLUSH PRIVILEGES;"  | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
            echo "GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost';" | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
            rm -r /var/www/html/*
            wget -p /var/www/html/index.html https://static.syslul.de/src/johannes/
            clear
            echo "Do you want to have a domain certified by Let's Encrypt?"
            read answer
            if &#91; "$answer" != "yes" &#93;; then
                apt install certbot python-certbot-apache -y
                
            exit 1
            fi
            
            echo "
            Thank you for using this Script
            Your Webserver is available on http://$serviceIP/ and http://$serviceIP/phpmyadmin
            
            MySQL-Login (localhost)
            user: root
            password: $MYSQL_ROOT_PASSWORD (Please change this password! It is static )

            phpMyAdmin-Login
            user: mysqladmin
            password: $MYSQL_MYSQLADMIN_PASSWORD (Please change this password! It is static)
            
            You want to improve my script or have a wish then open an issues on Github :)
            >> https://github.com/MrUnknownDE/linux-script/issues/new" > installer-log.txt
            cat installer-log.txt 
            ;;
        4)
            echo "DB Root Passwort: $MYSQL_ROOT_PASSWORD"
            echo "DB Root GEN PASSWORT:$MYSQL_ROOT_GEN_PASSWORD"
            echo "DB Root GEN PASSWORT 2:$MYSQL_ROOT_GEN_PASSWORD"
            echo "DB Admin Passwort: $MYSQL_MYSQLADMIN_GEN_PASSWORD"
            echo "DB Admin Passwort 2: $MYSQL_MYSQLADMIN_GEN_PASSWORD"
            ;;
        2) # - Yes
            HEIGHT=15
            WIDTH=70
            CHOICE_HEIGHT=5
            BACKTITLE="(L)inux(A)apache(M)ysql(P)HP Installer - $VERSION"
            TITLE="Then please reinstall the server or uninstall the existing LAMP"
            MENU="Choose one of the following options:"

            OPTIONS=(1 "okey")
            dialog --clear \
                   --backtitle "$BACKTITLE" \
                   --title "$TITLE" \
                   --menu "$MENU" \
                   $HEIGHT $WIDTH $CHOICE_HEIGHT \
                   "${OPTIONS[@]}" \
                   2>&1 >/dev/tty
            ;;
        3) # - Exit/Quit
            clear
            echo "exit Installer"
            ;;
        *) # - Error
            echo "Error! Please report this bug on Github"
            echo "https://github.com/MrUnknownDE/linux-script/issues/new"
            ;;
    esac
