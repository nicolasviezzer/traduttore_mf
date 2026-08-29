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

Decoder chiama la [Gemini API di Google](https://ai.google.dev/), che ha un **piano gratuito**. Non essendoci un backend, ogni persona che usa l'app inserisce **la propria** API key premendo l'icona ⚙️ in alto a destra.

- La key viene salvata **solo nel `localStorage` del tuo browser** — non è mai scritta nel codice, non viene committata, non passa da nessun server intermedio.
- Le richieste vanno direttamente dal browser a `generativelanguage.googleapis.com`.
- Puoi crearne una gratis in trenta secondi su [aistudio.google.com/apikey](https://aistudio.google.com/apikey).

### Modello

Di default Decoder usa **`gemini-3.5-flash-lite`**: è veloce, sta nel free tier ed è più che sufficiente per battute e sottotesti. Dal menu ⚙️ puoi passare a `gemini-3.1-flash-lite`, `gemini-2.5-flash-lite`, `gemini-3.5-flash` (più bravo, un po' più lento) o all'alias `gemini-flash-lite-latest`.

Il free tier ha limiti di richieste al minuto e al giorno: se vedi l'errore *"Hai esaurito le richieste gratuite del momento"*, aspetta un minuto.

⚠️ **Nota di sicurezza:** tenere una API key nel browser (anche solo in `localStorage`) è adatto a un uso personale o a un progetto demo, ma espone la key a chiunque abbia accesso a quel browser/dispositivo o esegua codice sulla stessa pagina (XSS). Non è il pattern consigliato per un prodotto con utenti reali: per quello servirebbe un piccolo backend che tiene la key lato server. Per un progetto GitHub aperto e "smanettone", va benissimo così.

💡 Su [aistudio.google.com/apikey](https://aistudio.google.com/apikey) puoi limitare la key a un singolo progetto e revocarla in qualsiasi momento — consigliato se la usi da un sito pubblico.

## 📦 Pubblicare su GitHub Pages

Il repo è già pronto: `index.html` sta nella root e c'è un `.nojekyll` che evita che GitHub provi a processarlo come sito Jekyll.

Serve solo attivare Pages, **dal proprietario del repository** (richiede permessi di admin):

**Settings → Pages → Source: Deploy from a branch → Branch: `main` → Folder: `/ (root)` → Save**

Dopo un minuto l'app è live su `https://nicolasviezzer.github.io/traduttore_mf/`.

> ⚠️ GitHub Pages su un repository **privato** è disponibile solo con GitHub Pro / Team / Enterprise. Con un account gratuito bisogna prima rendere pubblico il repository (**Settings → General → Danger Zone → Change visibility**). Il codice non contiene nessuna API key, quindi renderlo pubblico non espone segreti.

## 🛠️ Stack

Solo HTML/CSS/JS vanilla in un unico file (`index.html`). Nessuna build, nessuna dipendenza da installare.

`traduttore.html` è rimasto come redirect verso `index.html`, per non rompere i vecchi link.

## 📄 Licenza

MIT — vedi [LICENSE](LICENSE).
