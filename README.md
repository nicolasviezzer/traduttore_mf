# Decoder 🔮

Un traduttore ironico tra "linguaggio maschile" e "linguaggio femminile" — decodifica il sottotesto di un messaggio e suggerisce anche una risposta.

**Per gioco, non per scienza.** Nessuna pretesa di verità su come "parlano" uomini o donne: è uno strumento leggero per sorridere e magari capirsi un po' meglio.

## 🚀 Demo

Pubblicato su GitHub Pages con una key condivisa: chi apre il sito non deve configurare niente. Per farlo girare in locale servono due righe, vedi [Sviluppare in locale](#sviluppare-in-locale).

## 🎭 Come traduce

Le due direzioni fanno due lavori opposti.

**Lui → Lei** *espande*: prende tre parole piatte e srotola tutti i livelli che ci stavano dentro, ritornello compreso.

> **«sto bene»** → *Sto bene, o starò bene, non lo so — in ogni caso voglio che tu pensi che sto bene, perché credo che se lo pensi tu poi finisca per essere vero anche per me.*

**Lei → Lui** *comprime*: toglie premesse, cuscinetti e rassicurazioni, e lascia solo la cosa vera in una forma impossibile da fraintendere.

> **«Non è niente, davvero, lascia stare»** → *È qualcosa. Chiedimelo una seconda volta, con calma, e te lo dico.*

Ogni decodifica produce **due letture diverse**: il pulsante *↻ un'altra lettura* le alterna senza rifare la chiamata.

## 🔑 Come funziona la API key

Decoder chiama la [Gemini API di Google](https://ai.google.dev/), che ha un **piano gratuito**. Non c'è nessun backend: le richieste vanno direttamente dal browser a `generativelanguage.googleapis.com`.

**La key è una sola per tutti e non viene mai chiesta a chi usa l'app.** Non c'è nessun pannello impostazioni: la key viene iniettata dentro `index.html` durante il deploy, a partire dal secret `GEMINI_API_KEY` (vedi sotto). Chi apre il sito scrive un messaggio e basta.

Se il secret non è configurato, l'app lo dice con un avviso in cima e tiene il pulsante disattivato, invece di far scoprire il problema al primo clic.

### Modello

Decoder usa **`gemini-3.5-flash-lite`**: veloce, dentro il free tier, più che sufficiente per battute e sottotesti. È fissato nella costante `MODEL` in cima allo `<script>` di `index.html` — una riga da cambiare se vuoi passare a `gemini-3.1-flash-lite`, `gemini-2.5-flash-lite` o `gemini-3.5-flash` (più bravo, un po' più lento).

Il free tier ha limiti di richieste al minuto e al giorno: se compare *"Hai esaurito le richieste gratuite del momento"*, aspetta un minuto.

### Sviluppare in locale

Aprendo `index.html` in locale il segnaposto non è stato sostituito, quindi la key non c'è. Per provare l'app dalla tua macchina, impostala una volta dalla console del browser:

```js
localStorage.setItem("decoder_gemini_api_key", "AIza...")
```

Vale solo per il tuo browser, non finisce mai nel codice, e sul sito pubblicato viene ignorata in favore della key del build.

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

Per un prodotto con utenti reali il pattern giusto sarebbe un piccolo backend (es. un Cloudflare Worker) che tiene la key lato server e fa da proxy, così al browser non arriva mai. Per un progetto "smanettone" con una key dedicata e limitata, va bene così.

## ⚡ Push rapido

`push.bat` fa tutto in un colpo: aggiunge le modifiche, committa, si riallinea a `origin` con un rebase e pusha. Il push su `main` fa partire da solo il deploy.

```bat
push.bat
push.bat sistemato il prompt di Lei verso Lui
```

Senza argomenti il messaggio di commit è `Aggiornamento <data> <ora>`; tutto quello che scrivi dopo il nome diventa il messaggio. Se il rebase trova conflitti si ferma e ti dice come uscirne, senza pushare niente.

## 🛠️ Stack

Solo HTML/CSS/JS vanilla in un unico file (`index.html`). Nessuna dipendenza da installare; l'unico passaggio di "build" è la sostituzione della key fatta da Actions.

`traduttore.html` è rimasto come redirect verso `index.html`, per non rompere i vecchi link.

## 📄 Licenza

MIT — vedi [LICENSE](LICENSE).
