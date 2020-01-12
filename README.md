# NASTOOLS für FreeNAS Server

Skripte und Cronjobs für FreeNAS Server.

Starte FreeNAS WebGUI (Beispiel):

- https://freenas.local

Die NASTOOLS-Scripte sollten in einem dedizierten Dataset abgelegt werden. Unter FreeNAS werden mehrere Festplatten zu einem logischen Volume `vol1` zusammengefasst. Das Volume kann dann ein oder mehrere Datasets enthalten, z.B. `system`, enthalten.

Ein Script `smartdown.sh` kann dann z.B. folgendermaßen aufgerufen werden:

    /mnt/vol1/system/nastools/smart-shutdown/bin/smartdown.sh info
  
  
