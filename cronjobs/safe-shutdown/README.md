# SMARTDOWN Utility

Getestet wurde `smartdown.sh` unter FreeNAS 9.x und FreeNAS 10.0.

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

