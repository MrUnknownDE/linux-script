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
MYSQL_ROOT_PASSWORD="5kze2%!Np@U#rbi@ubvn"
MYSQL_MYSQLADMIN_PASSWORD="rU@DPsd3NyDJ*8x#m4z$MXuoYAL#svjv"
PHPMYADMIN_PASSPHRASE="3$HyzXf#NX!R*WdiYXvvR3fKmgMQHW^CgsjV4KWK^7&fNUaMZZx3FGF2t!V&*bVFs!9$4JSZC7D%vtfnMHZyKKcAGR8gESTQVx^xs2TwodhBJQF9srt^SYatvJE*jkXx"

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

HEIGHT=10
WIDTH=70
CHOICE_HEIGHT=4
BACKTITLE="(L)inux(A)apache(M)ysql(P)HP Installer - $VERSION"
TITLE="Has LAMP ever been installed on this instance?"
MENU="Choose one of the following options:"

OPTIONS=(1 "No"
         2 "Yes"
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
        1) # - No
            echo "Lets Go!"
            echo "start installer" # - start the normal installer
            sudo apt update
            sudo apt upgrade -y
            sudo apt install apache2 apache2-utils mariadb-server mariadb-client -y 
            echo "$SECURE_MYSQL"
            sudo apt install php7.3 libapache2-mod-php7.3 php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline -y 
            sudo a2enmod php7.3
            sudo systemctl restart apache2
            sudo a2dismod php7.3
            sudo apt install php7.3-fpm -y 
            sudo a2enmod proxy_fcgi setenvif
            sudo a2enconf php7.3-fpm
            sudo systemctl restart apache2
            sudo apt install wget -y 
            sudo apt install php php-cgi php-mysqli php-pear php-mbstring php-gettext libapache2-mod-php php-common php-phpseclib php-mysql -y
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
        2) # - Yes
            echo "Here where go again :)"
            sudo apt update
            sudo apt upgrade
            sudo apt remove apache2 mariadb-server mariadb-client php7.3 libapache2-mod-php7.3 php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline apache2-utils php7.3-fpm php php-cgi php-mysqli php-pear php-mbstring php-gettext libapache2-mod-php php-common php-phpseclib php-mysql -y
            sudo apt-get autoremove -y
            sudo rm -r /var/www/*
            echo ""
            echo "start installer" # - start the normal installer
            sudo apt update
            sudo apt upgrade -y
            sudo apt -o DPkg::options::=--force-confmiss --reinstall install apache2 apache2-utils mariadb-server mariadb-client -y 
            echo "$SECURE_MYSQL"
            sudo apt -o DPkg::options::=--force-confmiss --reinstall install php7.3 libapache2-mod-php7.3 php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline -y 
            sudo a2enmod php7.3
            sudo systemctl restart apache2
            sudo a2dismod php7.3
            sudo apt -o DPkg::options::=--force-confmiss --reinstall install php7.3-fpm -y 
            sudo a2enmod proxy_fcgi setenvif
            sudo a2enconf php7.3-fpm
            sudo systemctl restart apache2
            sudo apt install wget -y 
            sudo apt -o DPkg::options::=--force-confmiss --reinstall install php php-cgi php-mysqli php-pear php-mbstring php-gettext libapache2-mod-php php-common php-phpseclib php-mysql -y
            wget -P Downloads https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
            wget -P Downloads https://files.phpmyadmin.net/phpmyadmin.keyring
            gpg --import ~/Downloads/phpmyadmin.keyring
            wget -P Downloads https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz.asc
            gpg --verify ~/Downloads/phpMyAdmin-latest-all-languages.tar.gz.asc
            mkdir /var/www/html/phpmyadmin
            sudo tar xvf ~/Downloads/phpMyAdmin-latest-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
            sudo cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
            sudo chmod 660 /var/www/html/phpmyadmin/config.inc.php
            sudo chown -R 33:33 /var/www/html/phpmyadmin
            sudo systemctl restart apache2
            echo "CREATE USER 'mysqladmin'@'localhost' IDENTIFIED BY '$MYSQL_MYSQLADMIN_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost'; FLUSH PRIVILEGES;"  | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
            echo "GRANT ALL PRIVILEGES ON *.* TO 'mysqladmin'@'localhost';" | mysql -u root -password="$MYSQL_ROOT_PASSWORD"
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
            echo "Finish, more information on the installer-log.txt in you home dir"
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
