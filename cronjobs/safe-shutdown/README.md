# SMARTDOWN Utility

SMARTDOWN wird als Cronjob regelmäßig ausgeführt. Es prüft, ob noch genutzte Verbindungen zum NAS bestehen. Falls keine aktiven Verbindungen mehr aktiv sind, wird das NAS heruntergefahren, bis es mit Wake-on-LAN wieder aufgeweckt wird.

Getestet wurde `smartdown.sh` unter FreeNAS 9.x, 10.x und 11.2.

Aufruf:
```
./smartdown.sh info
```

## Installation

Das Utility wird als `cronjob` ausgeführt. Der Job kann über die FreeNAS Webkonsole unter *Tasks* eingerichtet werden. 

Angenommen, `smartdown.sh` liegt unter `/mnt/vol1/system/nastools/bin/`. Dann lautet der auszuführende Befehl:
```
/mnt/vol1/system/nastools/bin/smartdown.sh safe
```

