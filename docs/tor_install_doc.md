# "Perfekte" Tor Relay Settings

Benutzen Sie dafür bitte das Betriebsystem **Debian 10** oder die neuere **Ubuntu Server** *(20.04)* Version. 

Tor installieren sie ganz normal über den Paket-Manager des Betriebsystem. `(apt install tor)`


Die Relay-Config:
```
# System Relevant
RunAsDaemon 1
MaxMemInQueues 2 GB
HashedControlPassword <your hased Password>
CookieAuthentication 0
DisableDebuggerAttachment 0

# Port Relevant
Address mccurry.johanneskr.de
ORPort 9001
ControlPort 9051
DirPort 9030
SocksPort 0

# Verzeichnis Relevant
DataDirectory /var/lib/tor
Log notice file /var/log/tor/notices.log

# Metrics Relevant
ContactInfo abuse<at>johanneskr<dot>de
Nickname Currywurst

# Netzwerk Relevant
RelayBandwidthRate 100 MB      # Der Traffic Limit (100 MB = 100MB/s)
RelayBandwidthBurst 100 MB     # Der Traffic Limit (100 MB = 100MB/s)
AccountingStart month 1 00:00  # Wann der Limit startet, in diesem Fall am ersten Tag im Monat um 0 Uhr
AccountingMax 15000 GB         # Wie viel Traffic dein Server hat
ExitPolicy reject6 *:*, reject *:*
```
**Ergebnis:**
![img](https://nosence.xyz/MoSe7/QUCuVoje98.png/raw)

___
So, falls jemand noch lust hat und Spaß mit dem Abuse Team von dem jewaligen ISP haben will. Pack ich euch noch die Config für ein **Exit-Relay** rein.
Ein Exit-Relay ist der letzte Punkt von einer Tor-Verbindung und wird somit schnell als der schlechte Server darfgestellt, da über ihn die Angriffe aus dem Tor Netzwerk ausgeführt werden.

**Also im groben Zusammengefasst:** Ihr begibt euch da ein großes Risiko.
Wichtig ist noch zu sagen, das ihr euch bitte [Diese Datei](https://gitweb.torproject.org/tor.git/plain/contrib/operator-tools/tor-exit-notice.html) downloaded und die in eurem Data-Directory gepackt wird.


Die Exit-Config:
```
# System Relevant
RunAsDaemon 1
MaxMemInQueues 2 GB
HashedControlPassword <your hased Password>
CookieAuthentication 1
DisableDebuggerAttachment 0

# Port Relevant
Address mccurry.johanneskr.de
ORPort 9001
ControlPort 9051
DirPort 80
SocksPort 0

# Verzeichnis Relevant
DirPortFrontPage /etc/tor/tor-exit-notice.html
DataDirectory /var/lib/tor
Log notice file /var/log/tor/notices.log

# Metrics Relevant
ContactInfo abuse<at>johanneskr<dot>de
Nickname Currywurst

# Netzwerk Relevant
RelayBandwidthRate 100 MB      # Der Traffic Limit (100 MB = 100MB/s)
RelayBandwidthBurst 100 MB     # Der Traffic Limit (100 MB = 100MB/s)
AccountingStart month 1 00:00  # Wann der Limit startet, in diesem Fall am ersten Tag im Monat um 0 Uhr
AccountingMax 15000 GB         # Wie viel Traffic dein Server hat

# Exit-Police
ExitPolicy accept *:20-23     # FTP, SSH, telnet
ExitPolicy accept *:43        # WHOIS
ExitPolicy accept *:53        # DNS
ExitPolicy accept *:79-81     # finger, HTTP
ExitPolicy accept *:88        # kerberos
ExitPolicy accept *:110       # POP3
ExitPolicy accept *:143       # IMAP
ExitPolicy accept *:194       # IRC
ExitPolicy accept *:220       # IMAP3
ExitPolicy accept *:389       # LDAP
ExitPolicy accept *:443       # HTTPS
ExitPolicy accept *:464       # kpasswd
ExitPolicy accept *:465       # URD for SSM (more often: an alternative SUBMISSION port, see 587)
ExitPolicy accept *:531       # IRC/AIM
ExitPolicy accept *:543-544   # Kerberos
ExitPolicy accept *:554       # RTSP
ExitPolicy accept *:563       # NNTP over SSL
ExitPolicy accept *:587       # SUBMISSION (authenticated clients [MUA's like Thunderbird] send mail over STARTTLS SMTP here)
ExitPolicy accept *:636       # LDAP over SSL
ExitPolicy accept *:706       # SILC
ExitPolicy accept *:749       # kerberos
ExitPolicy accept *:873       # rsync
ExitPolicy accept *:902-904   # VMware
ExitPolicy accept *:981       # Remote HTTPS management for firewall
ExitPolicy accept *:989-990   # FTP over SSL
ExitPolicy accept *:991       # Netnews Administration System
ExitPolicy accept *:992       # TELNETS
ExitPolicy accept *:993       # IMAP over SSL
ExitPolicy accept *:994       # IRCS
ExitPolicy accept *:995       # POP3 over SSL
ExitPolicy accept *:1194      # OpenVPN
ExitPolicy accept *:1220      # QT Server Admin
ExitPolicy accept *:1293      # PKT-KRB-IPSec
ExitPolicy accept *:1500      # VLSI License Manager
ExitPolicy accept *:1533      # Sametime
ExitPolicy accept *:1677      # GroupWise
ExitPolicy accept *:1723      # PPTP
ExitPolicy accept *:1755      # RTSP
ExitPolicy accept *:1863      # MSNP
ExitPolicy accept *:2082      # Infowave Mobility Server
ExitPolicy accept *:2083      # Secure Radius Service (radsec)
ExitPolicy accept *:2086-2087 # GNUnet, ELI
ExitPolicy accept *:2095-2096 # NBX
ExitPolicy accept *:2102-2104 # Zephyr
ExitPolicy accept *:3128      # SQUID
ExitPolicy accept *:3389      # MS WBT
ExitPolicy accept *:3690      # SVN
ExitPolicy accept *:4321      # RWHOIS
ExitPolicy accept *:4643      # Virtuozzo
ExitPolicy accept *:5050      # MMCC
ExitPolicy accept *:5190      # ICQ
ExitPolicy accept *:5222-5223 # XMPP, XMPP over SSL
ExitPolicy accept *:5228      # Android Market
ExitPolicy accept *:5900      # VNC
ExitPolicy accept *:6660-6669 # IRC
ExitPolicy accept *:6679      # IRC SSL
ExitPolicy accept *:6697      # IRC SSL
ExitPolicy accept *:8000      # iRDMI
ExitPolicy accept *:8008      # HTTP alternate
ExitPolicy accept *:8074      # Gadu-Gadu
ExitPolicy accept *:8080      # HTTP Proxies
ExitPolicy accept *:8082      # HTTPS Electrum Bitcoin port
ExitPolicy accept *:8087-8088 # Simplify Media SPP Protocol, Radan HTTP
ExitPolicy accept *:8332-8333 # Bitcoin
ExitPolicy accept *:8443      # PCsync HTTPS
ExitPolicy accept *:8888      # HTTP Proxies, NewsEDGE
ExitPolicy accept *:9418      # git
ExitPolicy accept *:9999      # distinct
ExitPolicy accept *:10000     # Network Data Management Protocol
ExitPolicy accept *:11371     # OpenPGP hkp (http keyserver protocol)
ExitPolicy accept *:19294     # Google Voice TCP
ExitPolicy accept *:19638     # Ensim control panel
ExitPolicy accept *:50002     # Electrum Bitcoin SSL
ExitPolicy accept *:64738     # Mumble
ExitPolicy reject *:*
IPv6Exit 1
```
# Noch fragen?
### IPv6
Falls euer Server eine IPv6 Addresse hat, dann müsst ihr an der jewaligen Config den folgenden Parameter angeben: 
`ORPort [INSERT_IPV6_ADDRESS]:9001` 

### Danke! 
Ich bedanke mich fürs Lesen dieser Markdown Datei und wünsche euch viel Spaß beim unterstützten des Tor-Netzwerkes. Falls noch fragen oder Verbesserungsvorschläge sind, können sie mich per E-Mail, die versteckt in den Configurationen sind, erreichen :) 