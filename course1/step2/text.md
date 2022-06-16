## Tags
Um die Liste der vorhandenen Container Images etwas übersichtlicher zu gestalten kann ich das Format der Anzeige dezent ändern: `docker image ls --format '{{.Repository}}/{{.Tag}}'`{{exec}}. 

Tags sind oftmals Versionsnummern, können aber jeder halbwegs sinnige Zeichenkette sein.

Der Tag `latest`{{}} hat eine besondere Bedeutung: Er zeigt laut Konvention immer auf die jeweils aktuellste Version eines Container Images. Während der Entwicklung mag das Vorteile haben, in der Produktion möchte ich jedoch exakt festlegen, welche Applikation in welcher Version in meiner Umgebung läuft, um Bugs und Inkompatibilitäten bestmöglichst ausschließen zu können. Hier sollte ich den `latest`-Tag also möglichst vermeiden.

## Image Name:Tag vs Image ID
Wenn wir uns alle vorhandenen Images mit `docker image ls`{{exec}} anzeigen fällt auf, dass wir zwei alpine-Images mit unterschiedlichen Tags vorliegen haben: `latest` und `3.16.0`. Die Image ID beider Image ist aber die selbe.

## Was bedeutet das?

<details>
  <summary>Antwort</summary>
  <p>Eine Image ID ist eine eindeutige Referenz auf ein Container Image. Tags sind willkürlich gewählte Bezeichner und mehrere Tags können tatsächlich auf das gleiche Image mit der gleichen Image ID zeigen: Genau dies ist bei <code>alpine:latest</code> und <code>alpine:3.16.0</code> der Fall.</p>
</details> 

