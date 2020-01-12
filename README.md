# NASTOOLS für FreeNAS Server

Skripte und Cronjobs für FreeNAS Server.

Starte FreeNAS WebGUI (Beispiel):

- https://freenas.local

Installiert wird das Script in einem dedizierten Dataset. Unter FreeNAS werden mehrere Festplatten zu einem logischen Volume `vol1` zusammengefasst. Das Volume kann dann ein oder mehrere Datasets enthalten, z.B. `system`.

Das Script liegt dann z.B. unter:

    /mnt/vol1/system/nastools/smart-shutdown/bin/smartdown.sh logger
  
  
