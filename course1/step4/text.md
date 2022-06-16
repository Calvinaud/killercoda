Lasst uns mit dem Container Image `alpine:3.16.0` arbeiten und einige Tags hinzufügen und wieder entfernen.

## Ein Tag hinzufügen

Mit `docker tag <referenz> <name>:<tag>` können wir ein bestehendes Image mit einem neuen Tag versehen. Angenommen wir haben dieses Image getestet und möchten es mit einem `stable`-Tag versehen, um das festzuhalten: `docker tag alpine:3.16.0 alpine:stable`{{exec}}. 

## Ein Tag entfernen

Mit dem Release von alpine 3.17.0 muss ich das `stable`-Tag entfernen, um es neu zu vergeben: Jedes Tag zeigt auf genau ein Image, ein Image kann aber eine Vielzahl an Tags haben.

Ein Tag zu entfernen ist gar nicht so einfach, funktioniert eigentlich nur über das Entfernen des Images mit `rmi` (**r**emove **im**age): `docker rmi alpine:stable`{{exec}}. Solange es noch mindestens ein weiteres Tag (hier: `alpine:3.16.0`) gibt, welches auf die Image ID zeigt wird Docker das Image auch nicht direkt aus unserem lokalen Cache löschen.

## Referenz auf die Registry

Wir erinnern uns: Die Registry ist eigentlich Teil des Container Image Names, wird er weggelassen arbeitet Docker mit der URL `hub.docker.com/library`. Möchten wir ein Container Image in unsere Registry pushen, müssen wir vorab das Tag des Container Images entsprechend setzen: `docker tag alpine:3.16.0 cr.tik.uni-stuttgart.de/library/alpine:latest`{{exec}}. Genau diesen Tag pushe ich später dann auch: `docker push cr.tik.uni-stuttgart.de/library/alpine:latest`.

> **Hinweis**: Unsere Container Registry ist nur aus dem Uni-Netz erreichbar.

## Übung
Ziehe das Image `hello-world:latest` und tagge es als `myapp:1.0.0`