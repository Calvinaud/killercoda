Docker erlaubt es uns, Container zu starten, zu stoppen und zu managen. Die dafür notwendigen 
Container Images müssen im lokalen Cache vorliegen. 

## Container Images anzeigen
Mit `docker image ls`{{exec}} kann ich mir eine Liste aller lokal vorhandenen Container Images auflisten lassen.

## Container anzeigen
`docker container ls`{{exec}} zeigt eine Liste aller derzeit laufenden Container an. Der Parameter `--all`{{}} zeigt auch Container an, die bereits beendet wurden: `docker container ls --all`{{exec}}

1) Wieviele Container Images liegen derzeit im System?

<details>
  <summary>Antwort</summary>
  <p><code>docker image ls</code> zeigt, dass drei Images lokal vorhanden sind: Zwei <code>alpine</code>-Images mit unterschiedlichen Tags und ein <code>hello-world</code>-Image</p>
</details> 

<br />

2) Wieviele Container laufen derzeit?

<details>
  <summary>Antwort</summary>
  <p><code>docker container ls</code> zeigt, dass derzeit kein Container läuft.</p>
</details> 

2) Wieviele Container sind auf dem System vorhanden?

<details>
  <summary>Antwort</summary>
  <p>Auch wenn <code>docker container ls</code> keine Ausgabe enthält besagt dass nur, dass derzeit kein Container läuft. <code>docker container ls --all</code> führt zwei bereits beendete <code>alpine:latest</code>-Container auf</p>
</details> 

