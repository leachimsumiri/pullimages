# pullxesarimages

Mit dem Shell Script können nach jeder Sprint Lieferung die Docker Images geladen, gespeichert und gezippt werden. Mit dem Ergebnis kann der Import lokaler Images im Installation-Manager durchgeführt werden.

## Repository	

https://bach1.evva.com/bitbucket/projects/XSYS/repos/pullxesarimages/browse

## Dokumentation

https://wiki.evva.com/display/XS3/pullXesarImages+-+Shell+Script

## Verwendung

Das Skript verwendet das Versions-Verwaltungssystem git um die Version Info vom Bitbucket Server der EVVA zu laden, die Applikation jq als JSON processor für ebendiese Version Info und docker um die Images vom Harbor (Registry sfw.evva.com) oder vom Nexus zu ziehen.

## Voraussetzungen:

- Terminal/Eingabeaufforderung welche Shell Scripts ausführen kann (Unix Terminal oder Git for Windows)
- jq und docker sind installiert (evt. müssen aliase zur Verwendung von jq verwendet werden. Bei Installation via beispielsweise Homebrew oder Chocolatey (Paket Manager für Windows siehe https://chocolatey.org/install ) ist dies nicht notwendig)
	- macOS: brew install jq
	- Windows: choco.exe install jq
- das Version Info Repository (https://bach1.evva.com/bitbucket/scm/xs3/version-info.git) ist im ausführenden Verzeichnis geklont worden
- das Repo ändert sich in jeder Version und muss somit immer wieder gezogen werden um die aktuelle Version auslesen zu können
- die ausführende Docker Engine muss Zugriff auf die jeweilige Docker Registry (nexus3 oder harbor) haben und eingeloggt sein (docker login %REPOSITORY%)
	- Docker DNS muss auf den Google-DNS Server (8.8.8.8) zeigen, ansonsten wird der harbor nicht gefunden

### Aufruf im Terminal

./saveDown.sh %VERSION% %REPOSITORY%

### Repositories der Images
		- xesar
		- xesar-staging
		- xesar-development
		- nexus3

## Output

Das Version Info Repository (https://bach1.evva.com/bitbucket/scm/xs3/version-info.git) wird anhand der in den Parametern übergebenen Version und dem Repository lokal geklont.
Es wird ein Verzeichnis mit dem zugehörigen Xesar-Versionsnamen und Repository angelegt indem alle benötigten Images im .tar Format liegen. Das Verzeichnis kann anschließend so als Import Folder verwendet werden.