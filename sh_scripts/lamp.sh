#!/bin/bash
# Make sure only root can run our script
VERSION="Version: 1.0v"
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
TITLE="Are you ready for the installation? "
MENU="Choose one of the following options:"

OPTIONS=(1 "Yes"
         2 "No"
         3 "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
    case $CHOICE in
        1) # - Yes
            echo "Lets Go!"
            echo "start installer" # - start the normal installer
            apt update && apt install expect sharutils gnupg gnupg2 gnupg1 unzip zip wget curl -y
            echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
            wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
            sudo apt update
            sudo apt upgrade -y
            sudo apt install wget apache2 apache2-utils mariadb-server mariadb-client lsb-release ca-certificates apt-transport-https software-properties-common php php-cgi php-mysql php-pear php-mbstring libapache2-mod-php php-common php-phpseclib php-mysql php8.0-bcmath php8.0-curl-dbgsym php8.0-gmp-dbgsym php8.0-mysql php8.0-pspell-dbgsym php8.0-tidy php8.0-bcmath-dbgsym php8.0-dba php8.0-imap php8.0-mysql-dbgsym php8.0-readline php8.0-tidy-dbgsym php8.0-bz2 php8.0-dba-dbgsym php8.0-imap-dbgsym php8.0-odbc php8.0-readline-dbgsym php8.0-xdebug php8.0-bz2-dbgsym php8.0-dev php8.0-interbase php8.0-odbc-dbgsym php8.0-snmp php8.0-xml php8.0-cgi php8.0-enchant php8.0-interbase-dbgsym  php8.0-opcache php8.0-snmp-dbgsym php8.0-xml-dbgsym php8.0-cgi-dbgsym php8.0-enchant-dbgsym php8.0-intl php8.0-opcache-dbgsym php8.0-soap php8.0-xsl php8.0-cli php8.0-fpm php8.0-intl-dbgsym php8.0-pgsql php8.0-soap-dbgsym php8.0-zip php8.0-cli-dbgsym php8.0-fpm-dbgsym php8.0-ldap php8.0-pgsql-dbgsym php8.0-sqlite3 php8.0-zip-dbgsym php8.0-common php8.0-gd php8.0-ldap-dbgsym php8.0-phpdbg php8.0-sqlite3-dbgsym php8.0-common-dbgsym php8.0-gd-dbgsym php8.0-mbstring php8.0-phpdbg-dbgsym php8.0-sybase php8.0-curl php8.0-gmp php8.0-mbstring-dbgsym php8.0-pspell php8.0-sybase-dbgsym -y 
            echo "$SECURE_MYSQL"
            apt update
            rm -r /var/www/html/*
            wget https://files.phpmyadmin.net/phpMyAdmin/5.1.3/phpMyAdmin-5.1.3-all-languages.zip
            mkdir /var/www/html/phpmyadmin
            unzip phpMyAdmin-5.1.3-all-languages.zip
            mv phpMyAdmin-5.1.3-all-languages/* /var/www/html/phpmyadmin
            curl https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/res/phpmyadmin-config.inc.php --output /var/www/html/phpmyadmin/config.inc.php   
            sudo chmod 660 /var/www/html/phpmyadmin/config.inc.php
            sudo chown -R 33:33 /var/www/html/phpmyadmin
            sudo systemctl restart apache2
            echo "CREATE USER 'mysqladmin'@'localhost' IDENTIFIED BY '$MYSQL_MYSQLADMIN_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost'; FLUSH PRIVILEGES;"  | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
            echo "GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost';" | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
            curl https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/res/lamp.html > /var/www/html/index.html
            curl https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/res/lamp.php > /var/www/html/lamp.php
            clear
            echo "Do you want to have a domain certified by Let's Encrypt? (yes/no)" && read answer;
            if [ $answer == "yes" ]; then
                apt install certbot python3-certbot-apache -y
                certbot register
                echo "Domain Name:" && read domain;
                certbot --apache -d ${domain}
                crontab -l > letsencrypt.cron
                echo "40 3 * * 0 letsencrypt renew >> /var/log/letsencrypt-renew.log && /etc/init.d/apache2 restart" > letsencrypt.cron
                crontab letsencrypt.cron
                rm letsencrypt.cron
                clear
                echo "
                Thank you for using this Script
                Your Webserver is available on http://${domain}/ and http://${domain}/phpmyadmin
                
                MySQL-Login (localhost)
                user: root
                password: $MYSQL_ROOT_PASSWORD (Please change this password! It is static )

                phpMyAdmin-Login
                user: mysqladmin
                password: $MYSQL_MYSQLADMIN_PASSWORD (Please change this password! It is static)
                
                You want to improve my script or have a wish then open an issues on Github :)
                >> https://github.com/MrUnknownDE/linux-script/issues/new" > installer-log.txt
                cat installer-log.txt
            else
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
            fi
            ;;
        2) # - No
            echo "exit Installer!" 
            ;;
        3) # - Exit/Quit
            clear
            echo "exit Installer!"
            ;;
        *) # - Error
            echo "Error! Please report this bug on Github"
            echo "https://github.com/MrUnknownDE/linux-script/issues/new"
            ;;
    esac
