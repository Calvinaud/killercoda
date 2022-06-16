## Image Tags sind Aliase
Ich kann mit unterschiedlichen Tags auf das gleiche Image verweisen, das erlaubt mir eine flexible Strukturierung meiner Container Images: Angenommen ich habe eine Web-Applikation `webapp`, ein Update bringt Änderungen mit sich die ein neues Minor-Release rechtfertigen:

| Applikation `webapp`    | Image ID |
|-------- |-----------------|
|`1.4.2` | `66e1443684b0`   |
|`1.5.0` | `e5a475a03805`   |

Ich versehe oder ändere meine bisherigen Tags der alten Version wie folgt:

| Tag    | Image ID (alt) |  Image ID (neu) |
|--------|----------------|-----------------|
|`latest` | `66e1443684b0`            |`e5a475a03805`  |
|`1.5.0` |            | `e5a475a03805` |
|`1.5` |            | `e5a475a03805` |
|`1.4.2` | `66e1443684b0`            |  |
|`1.4` | `66e1443684b0`            |  |
|`1` | `66e1443684b0`            | `e5a475a03805` |

Meine Anwender haben nun sehr flexible Möglichkeiten, ob und in welchem Umfang sie Funktionsänderungen oder Bugfixes meiner Applikation erhalten. Referenzieren sie

- `1.4`: Sie bleiben auf der alten Version `1.4.2`, da diese getestet wurde und kompatibel zu ihrer Umgebung ist. Funktionsänderungen halten nur in Minor Releases Einzug, das ist also eine recht sichere Sache
- `1.4.2`: Möchte ich zwingend vor einem Update testen, dann pinne ich meine Applikation hart auf eine spezifische Versionsnummer/ Tag
- `1`: Breaking changes kommen am ehesten in Major Releases, daher bleibe ich auf Version 1.x, erhalte aber Funktionsupdates und Hotfixes von Minor Releases und Hotfix Releases. 
- `latest`: Bitte gib mir jede Änderung. Ich diskutiere später mit meinem Chef, warum ich das für eine gute Idee halte