# LocalAI Studio

**Lokale KI-Verwaltungs- und Assistenzplattform für Windows 10/11 (x64).**

LocalAI Studio verbindet sich mit lokal installierten KI-Runtimes (Ollama, LM Studio, llama.cpp) und bietet eine einheitliche Oberfläche für Chat, Modellverwaltung, eigene Assistenten, Wissensdatenbanken (RAG), Dokumentanalyse, Prompt-Bibliothek und Leistungsüberwachung. Alle Daten bleiben auf deinem Computer.

> LocalAI Studio enthält **keine KI-Modelle und keine Inferenz-Engine**. Eine Runtime (empfohlen: [Ollama](https://ollama.com/download)) und Modelle werden separat installiert.

---

## Installation

1. `LocalAIStudio-Setup.exe` ausführen.
2. Wählen, ob für den aktuellen Benutzer (ohne Administratorrechte) oder für alle Benutzer installiert wird.
3. Optional eine Desktop-Verknüpfung anlegen. Eine Startmenü-Verknüpfung wird immer erstellt.

Alternativ kann `LocalAIStudio.exe` direkt ohne Installation gestartet werden (portable Einzeldatei).

**.NET muss nicht installiert sein** – die Laufzeit ist in die Anwendung integriert.

### Deinstallation
Über *Einstellungen → Apps* oder den Startmenü-Eintrag „LocalAI Studio deinstallieren“. Dabei wird gefragt, ob auch die persönlichen Daten gelöscht werden sollen (Standard: Nein). Heruntergeladene Modelle von Ollama/LM Studio sind nicht betroffen.

### Updates
Eine neue Version einfach über die bestehende installieren. Benutzerdaten liegen in `%LOCALAPPDATA%\LocalAIStudio` (außerhalb des Programmordners) und bleiben erhalten; die Datenbank wird bei Bedarf automatisch migriert.

---

## Erste Schritte

1. **Ollama installieren** (https://ollama.com/download) – oder LM Studio bzw. llama.cpp.
2. LocalAI Studio starten. Der **Einrichtungsassistent** prüft Betriebssystem und Hardware, sucht installierte Runtimes, testet die Verbindung und empfiehlt Modelle passend zu deinem Grafik- und Arbeitsspeicher.
3. Im **Modell-Manager → Modelle entdecken** ein Modell herunterladen (z. B. `qwen3:8b`), für die Wissensdatenbank zusätzlich ein Embedding-Modell (z. B. `embeddinggemma`).
4. Im **KI-Chat** loslegen.

Die Anwendung startet auch ohne installierte Runtime; Chat und Analyse sind dann nicht verfügbar und die Oberfläche zeigt Hinweise zur Einrichtung.

---

## Funktionen

| Bereich | Funktionen |
|---|---|
| **Dashboard** | Aktives Modell, Runtime, Verbindungsstatus, installierte Modelle, freier Speicher, RAM/CPU/GPU/VRAM, letzte Unterhaltungen und Modelle, Aktivitäten, Schnellzugriff. Widgets lassen sich ein-/ausblenden und umsortieren. |
| **KI-Chat** | Streaming, Markdown, Syntaxhervorhebung, Code kopieren, Antwort kopieren, neu generieren, stoppen, Nachricht bearbeiten und erneut senden, einzelne Nachrichten löschen, Suche, Umbenennen, Export (Markdown/JSON/TXT), Modellwechsel mitten in der Unterhaltung, Systemprompt, Antwortzeit und Token/s, Gedankengang von Reasoning-Modellen, Wissensdatenbank mit Quellenangaben, **Bildanhänge für Vision-Modelle** (Schaltfläche, Strg+V oder Drag & Drop; Bilder werden lokal auf max. 1600 px verkleinert). |
| **Modell-Manager** | Installierte Modelle aller Runtimes mit Details (Parameter, Quantisierung, Kontext, Fähigkeiten, Lizenz), Katalog mit Suche und Kategorien (Allzweck, Programmierung, Reasoning, Klein, Mehrsprachig, Embedding, Vision) inkl. Kompatibilitätsbewertung, Download mit Fortschritt, Pause/Fortsetzen/Abbrechen, Löschen (mit Bestätigung), Laden/Entladen, GGUF-Import. |
| **Assistenten-Studio** | Eigene Assistenten mit Name, Beschreibung, Avatar (Symbol oder Bild), Systemprompt, Modell, Parametern und Wissensdatenbank; erstellen, bearbeiten, duplizieren, löschen. Sechs Beispielassistenten. |
| **Wissensdatenbank** | Mehrere Datenbanken, Import von PDF, TXT, Markdown, DOCX, CSV, JSON sowie Bildern (PNG, JPG, BMP, TIFF, GIF) (auch per Drag & Drop), lokale Extraktion inkl. **Texterkennung (OCR) für gescannte PDFs und Bilder** über die in Windows integrierte OCR, Chunking, lokale Embeddings, semantische Suche, Neuindizierung und Entfernen von Dokumenten, Nutzung im Chat mit Seiten-/Zeilenangaben. |
| **Dokumentanalyse** | Zusammenfassen, technisch erklären, Wichtiges extrahieren, Dokumente vergleichen, strukturierte Zusammenfassung, freie Fragen – mit Anzeige der verwendeten Fundstellen und Trennung zwischen „im Dokument belegt“ und „nicht überprüfbar“. Große Dokumente werden per Abschnittsauswahl bzw. Map-Reduce verarbeitet. |
| **Prompt-Bibliothek** | Kategorien, Favoriten, Suche, Bearbeiten, Duplizieren, Löschen, direkt in den Chat einfügen. Beispiel-Prompts in sieben Kategorien. |
| **Leistungsmonitor** | CPU, RAM, GPU, VRAM als Verlaufsdiagramme, verfügbarer Speicher, Speicherbedarf der App, geladene Modelle, Runtime-Prozesse, Token/s und Antwortzeiten der letzten Generierungen. Nicht ermittelbare Werte werden als „nicht verfügbar“ angezeigt, nie geschätzt. |
| **Benchmark** | Mehrere Modelle (auch runtimeübergreifend) mit identischen Testaufgaben messen: Aufwärmlauf mit Ladezeit, Wiederholungen mit Median, Zeit bis zum ersten Token, Token/s, Prompt-Verarbeitung, Gesamtdauer, Spitzen-RAM/VRAM, automatische Plausibilitätsprüfung. Deterministischer Modus (Temperatur 0, Seed 42), andere Modelle vorher entladen, Denkmodus abschaltbar, eigene Prompts. Rangliste mit Balkendiagrammen, Einzelläufe, Antwortvergleich nebeneinander, gespeicherte Läufe, Export als Markdown-Bericht oder CSV. |
| **Online-Benchmarks** (Einstellungen) | Zeigt veröffentlichte Benchmark-Ergebnisse deiner installierten Modelle aus **BenchLM** (aktuell; Gesamtwert, Rang, Kategorien wie Reasoning, Programmieren, Wissen) und dem **Hugging Face Open LLM Leaderboard** (archiviert, Stand März 2025; IFEval, BBH, MATH, GPQA, MUSR, MMLU-PRO). Abruf nur auf Knopfdruck mit Bestätigung, Abgleich lokal (keine Modellnamen werden übertragen), Zwischenspeicher im Datenordner, freie Suche. Fehlen Ergebnisse für die exakte Größe, werden Größen derselben Familie als gekennzeichneter Vergleich gezeigt. |
| **Einstellungen** | Sprache, Hell/Dunkel, Startverhalten, Update-Prüfung, Runtimes und Endpunkte inkl. Diagnose, Timeouts, Speicherorte, Chat-Standards, Verlauf, Nur-lokal-Modus, Verlauf bzw. alle Daten löschen. |

### Unterstützte Funktionen je Runtime

| Funktion | Ollama | LM Studio | llama.cpp |
|---|:-:|:-:|:-:|
| Modellliste, Chat (Streaming) | ✓ | ✓ | ✓ |
| Embeddings | ✓ | ✓ | nur mit `--embedding` |
| Modelle herunterladen / löschen | ✓ | – (in LM Studio) | – |
| Laden / Entladen | ✓ | – (automatisch in LM Studio) | Serverstart mit GGUF |
| GGUF-Import | ✓ | – | ✓ (Serverstart) |
| Dienst starten | ✓ | mit `lms` CLI | ✓ (llama-server.exe) |
| Top K / Wiederholungsstrafe | ✓ | ✓ | ✓ |
| Kontextlänge pro Anfrage | ✓ | – (beim Laden) | – (beim Serverstart) |

Nicht unterstützte Funktionen sind in der Oberfläche deaktiviert und mit einer Erklärung versehen.

---

## Datenschutz & Sicherheit

- **Nur-lokal-Modus** (Standard): Endpunkte außerhalb dieses Computers werden blockiert. Wird er deaktiviert und ein externer Endpunkt eingetragen, warnt die Anwendung ausdrücklich, dass Daten das Gerät verlassen.
- Keine Telemetrie, keine Konten, kein voreingestellter Update-Server.
- Internetverbindungen nur bei bestätigten Modell-Downloads (über Ollama), beim ausdrücklich ausgelösten Abruf der Online-Benchmarks (benchlm.ai, huggingface.co – es werden nur öffentliche Datensätze heruntergeladen, keine Daten gesendet) und optional bei der Update-Prüfung gegen eine selbst konfigurierte HTTPS-Adresse.
- Dokumente werden lokal extrahiert und über die lokale Runtime eingebettet.
- KI-Antworten führen **niemals** automatisch Befehle aus.
- Löschen von Modellen, Unterhaltungen, Nachrichten, Assistenten, Prompts und Wissensdatenbanken erfordert eine Bestätigung.
- Der llama.cpp-Server wird immer an `127.0.0.1` gebunden.

### Speicherorte
| Daten | Ort |
|---|---|
| Datenbank (Einstellungen, Unterhaltungen, Assistenten, Prompts, Index) | `%LOCALAPPDATA%\LocalAIStudio\localai-studio.db` |
| Avatarbilder | `%LOCALAPPDATA%\LocalAIStudio\avatars` |
| Protokolle (14 Tage) | `%LOCALAPPDATA%\LocalAIStudio\logs` |
| Exporte | standardmäßig `Dokumente\LocalAI Studio` |
| Ollama-Modelle | `OLLAMA_MODELS` bzw. `%USERPROFILE%\.ollama\models` |

---

## Fehlerbehebung

| Problem | Lösung |
|---|---|
| „Ollama ist nicht erreichbar“ | Ollama starten (Startmenü oder Schaltfläche „Ollama starten“), Endpunkt unter *Einstellungen → KI-Runtime* prüfen (Standard `http://127.0.0.1:11434`). |
| „Ollama wurde nicht gefunden“ | Ollama von https://ollama.com/download installieren. |
| LM Studio wird nicht gefunden | In LM Studio unter „Developer“ den lokalen Server starten, dann *Endpunkt automatisch erkennen*. |
| Keine Modelle im Chat | Im Modell-Manager ein Modell herunterladen; Embedding-Modelle erscheinen nicht in der Chat-Auswahl. |
| Zeitüberschreitung bei der ersten Antwort | Große Modelle laden lange – *Antwort-Timeout* erhöhen. |
| Wissensdatenbank indiziert nicht | Embedding-Modell auswählen bzw. herunterladen (z. B. `embeddinggemma`). Bei gescannten PDFs prüfen, ob ein Windows-OCR-Sprachpaket installiert ist. |
| „Modell kann keine Bilder verarbeiten“ | Ein Vision-Modell wählen (Modell-Manager → Kategorie „Vision“). |
| Diagnose | *Einstellungen → KI-Runtime → Verbindung testen* zeigt Endpunkt, Port, Installation, API-Status und Modelle. Protokolldatei: *Einstellungen → Über*. |

---

## Bekannte Einschränkungen

- Oberfläche derzeit nur auf Deutsch.
- Texterkennung nutzt die Windows-OCR und benötigt ein installiertes OCR-Sprachpaket (bei deutschem Windows meist vorhanden; sonst Einstellungen → Zeit und Sprache → Sprache). Erkennungsfehler sind möglich, Handschrift wird kaum erkannt. DOCX-Seitenzahlen sind Näherungswerte.
- Bildanhänge funktionieren nur mit Vision-Modellen (z. B. gemma3, qwen2.5vl, llava); bei anderen Modellen verhindert die App das Senden mit einem Hinweis. Pro Anfrage werden die Bilder der letzten drei Nachrichten mitgesendet.
- Online-Benchmarks: BenchLM-Daten stehen unter CC BY-NC 4.0 (kommerzielle Nutzung nur mit Lizenz von BenchLM); das Open LLM Leaderboard ist seit März 2025 archiviert und enthält keine neueren Modelle. Die automatische Namenszuordnung kann bei ungewöhnlichen Modellnamen unvollständig sein. Veröffentlichte Werte beziehen sich auf die Originalmodelle, nicht auf quantisierte lokale Varianten.
- Benchmark-Werte hängen von Hardware, Treibern, Hintergrundlast und Runtime-Version ab; Läufe erfolgen bewusst nacheinander, nicht parallel.
- Der Modellkatalog ist eine eingebettete, kuratierte Liste (Größen sind Richtwerte); beliebige Ollama-Modelle können per Name geladen werden.
- Pausieren eines Downloads bricht die Übertragung ab; Ollama setzt beim Fortsetzen mit den bereits geladenen Teilen fort.
- GPU-Werte über `nvidia-smi` (NVIDIA) bzw. Windows-Leistungsindikatoren; sind beide nicht verfügbar, wird „nicht verfügbar“ angezeigt.
- Die optionalen Zukunftsfunktionen (Spracheingabe, Sprachausgabe, Bildgenerierung, Plugin-System usw.) sind **nicht enthalten**; die Architektur (Schnittstelle `IAiProvider`, modulare Dienste) ist dafür vorbereitet.

---

## Entwicklung

**Voraussetzungen:** .NET 10 SDK, Inno Setup 6 (für den Installer).

```
LocalAIStudio.slnx
src/LocalAIStudio.Core/     Kernlogik: SQLite + Migrationen, Runtimes (IAiProvider), RAG, Dokumente, Metriken
src/LocalAIStudio/          WPF-Oberfläche (MVVM, CommunityToolkit.Mvvm)
tests/LocalAIStudio.Tests/  Unit- und Integrationstests (xUnit)
installer/                  Inno-Setup-Skript
tools/make-icon.ps1         erzeugt das Anwendungssymbol
build.ps1                   Tests, Veröffentlichung und Installer
```

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

Ergebnis in `release\`: `LocalAIStudio.exe` (eigenständig) und `LocalAIStudio-Setup.exe`.

**Tests:** `dotnet test tests\LocalAIStudio.Tests` (57 Tests). Die Integrationstests benötigen ein laufendes Ollama mit `qwen3:0.6b` und `embeddinggemma`, die OCR-Tests ein Windows-OCR-Sprachpaket, die Vision-Tests `gemma3:4b`, die Online-Tests eine Internetverbindung.

**Neue Runtime hinzufügen:** `IAiProvider` implementieren (OpenAI-kompatible Server können von `OpenAiCompatibleProvider` erben), Funktionen über `ProviderFeatures` und `ParameterSupport` deklarieren und im `ProviderManager` registrieren.

**Testdatenordner:** Die Umgebungsvariable `LOCALAISTUDIO_DATA` setzt einen abweichenden Datenordner.
