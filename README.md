# Decoder 🔮

Un traduttore ironico tra "linguaggio maschile" e "linguaggio femminile" — decodifica il sottotesto di un messaggio e suggerisce anche una risposta.

**Per gioco, non per scienza.** Nessuna pretesa di verità su come "parlano" uomini o donne: è uno strumento leggero per sorridere e magari capirsi un po' meglio.

## 🚀 Demo

Apri `index.html` in qualsiasi browser, oppure pubblicalo con GitHub Pages (vedi sotto).

## 🎭 Come traduce

Le due direzioni fanno due lavori opposti.

**Lui → Lei** *espande*: prende tre parole piatte e srotola tutti i livelli che ci stavano dentro, ritornello compreso.

> **«sto bene»** → *Sto bene, o starò bene, non lo so — in ogni caso voglio che tu pensi che sto bene, perché credo che se lo pensi tu poi finisca per essere vero anche per me.*

**Lei → Lui** *comprime*: toglie premesse, cuscinetti e rassicurazioni, e lascia solo la cosa vera in una forma impossibile da fraintendere.

> **«Non è niente, davvero, lascia stare»** → *È qualcosa. Chiedimelo una seconda volta, con calma, e te lo dico.*

Ogni decodifica produce **due letture diverse**: il pulsante *↻ un'altra lettura* le alterna senza rifare la chiamata.

## 🔑 Come funziona la API key

Decoder chiama la [Gemini API di Google](https://ai.google.dev/), che ha un **piano gratuito**. Non c'è nessun backend: le richieste vanno direttamente dal browser a `generativelanguage.googleapis.com`.

La key può arrivare da due strade, e la prima che c'è vince:

1. **La tua key personale**, inserita dall'icona ⚙️ e salvata **solo nel `localStorage` del tuo browser**. Non viene mai committata. Creane una gratis in trenta secondi su [aistudio.google.com/apikey](https://aistudio.google.com/apikey).
2. **La key condivisa del sito**, iniettata durante il deploy dal secret `GEMINI_API_KEY` (vedi sotto). Serve a far funzionare la demo pubblica senza chiedere niente a chi arriva.

Se apri `index.html` in locale, la key condivisa non c'è: serve la tua.

### Modello

Di default Decoder usa **`gemini-3.5-flash-lite`**: è veloce, sta nel free tier ed è più che sufficiente per battute e sottotesti. Dal menu ⚙️ puoi passare a `gemini-3.1-flash-lite`, `gemini-2.5-flash-lite`, `gemini-3.5-flash` (più bravo, un po' più lento) o all'alias `gemini-flash-lite-latest`.

Il free tier ha limiti di richieste al minuto e al giorno: se vedi l'errore *"Hai esaurito le richieste gratuite del momento"*, aspetta un minuto.

## 📦 Pubblicare su GitHub Pages

Il deploy è automatico: [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) parte a ogni push su `main`, copia il sito in `_site/`, sostituisce il segnaposto `__GEMINI_API_KEY__` dentro `index.html` con il secret e pubblica.

Servono tre passaggi, tutti **dal proprietario del repository** (richiedono permessi di admin):

1. **Il secret** — Settings → Secrets and variables → Actions → *New repository secret*, nome `GEMINI_API_KEY`, valore la key presa da [aistudio.google.com/apikey](https://aistudio.google.com/apikey). Senza questo secret il workflow si ferma con un errore esplicito invece di pubblicare un sito rotto.
2. **Pages** — Settings → Pages → **Source: GitHub Actions**. (Non "Deploy from a branch": la key va iniettata durante il build.)
3. **Visibilità** — Pages su un repository **privato** richiede GitHub Pro / Team / Enterprise. Con un account gratuito bisogna prima rendere pubblico il repository: Settings → General → Danger Zone → *Change visibility*.

Fatto questo, l'app è live su `https://nicolasviezzer.github.io/traduttore_mf/` e chi la apre non deve inserire nessuna key.

### 🔒 Cosa sapere sulla key condivisa

**La key iniettata è leggibile da chiunque visiti il sito.** GitHub Pages serve solo file statici: il secret resta nascosto nei log di Actions, ma finisce in chiaro nell'HTML pubblicato e basta un "visualizza sorgente" per copiarlo. Vale anche con repository privato, perché il *sito* Pages è pubblico comunque.

È un compromesso accettabile per una demo, a patto di mettere le protezioni:

- **Limita la key al dominio.** Su [Google Cloud → Credentials](https://console.cloud.google.com/apis/credentials), sulla key: *Application restrictions → Websites*, e aggiungi `https://nicolasviezzer.github.io/*`. Blocca l'uso da altri siti (non blocca `curl`, ma taglia via l'abuso casuale).
- **Limita le API.** *API restrictions → Restrict key →* solo Generative Language API.
- **Resta sul free tier** e non collegare un account di fatturazione a quel progetto: nel peggiore dei casi si esaurisce la quota gratuita, non arriva un conto.
- **Tieni una key dedicata** solo per questo sito, così revocarla non rompe altro.

Chi vuole non pesare sulla quota comune può sempre inserire la propria key dall'icona ⚙️: ha la precedenza su quella condivisa.

⚠️ Anche la key personale nel `localStorage` è esposta a chi ha accesso a quel browser/dispositivo o esegue codice sulla stessa pagina (XSS). Per un prodotto con utenti reali il pattern giusto sarebbe un piccolo backend (es. un Cloudflare Worker) che tiene la key lato server e fa da proxy. Per un progetto "smanettone", va bene così.

## 🛠️ Stack

Solo HTML/CSS/JS vanilla in un unico file (`index.html`). Nessuna dipendenza da installare; l'unico passaggio di "build" è la sostituzione della key fatta da Actions.

`traduttore.html` è rimasto come redirect verso `index.html`, per non rompere i vecchi link.

## 📄 Licenza

MIT — vedi [LICENSE](LICENSE).
