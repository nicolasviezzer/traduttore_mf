# Decoder 🔮

Un traduttore ironico tra "linguaggio maschile" e "linguaggio femminile" — decodifica il sottotesto di un messaggio e suggerisce anche una risposta.

**Per gioco, non per scienza.** Nessuna pretesa di verità su come "parlano" uomini o donne: è uno strumento leggero per sorridere e magari capirsi un po' meglio.

## 🚀 Demo

Apri `index.html` in qualsiasi browser, oppure pubblicalo con GitHub Pages (vedi sotto).

## 🔑 Come funziona la API key

Decoder chiama l'API di [Anthropic](https://www.anthropic.com) per generare le traduzioni. Non essendoci un backend, ogni persona che usa l'app inserisce **la propria** API key premendo l'icona ⚙️ in alto a destra.

- La key viene salvata **solo nel `localStorage` del tuo browser** — non è mai scritta nel codice, non viene committata, non passa da nessun server intermedio.
- Le richieste vanno direttamente dal browser a `api.anthropic.com`.
- Puoi crearne una su [console.anthropic.com/settings/keys](https://console.anthropic.com/settings/keys).

⚠️ **Nota di sicurezza:** tenere una API key nel browser (anche solo in `localStorage`) è adatto a un uso personale o a un progetto demo, ma espone la key a chiunque abbia accesso a quel browser/dispositivo o esegua codice sulla stessa pagina (XSS). Non è il pattern consigliato per un prodotto con utenti reali: per quello servirebbe un piccolo backend che tiene la key lato server. Per un progetto GitHub aperto e "smanettone", va benissimo così.

## 📦 Pubblicare su GitHub Pages

```bash
git init
git add .
git commit -m "Decoder: prima versione"
git branch -M main
git remote add origin https://github.com/TUO-USERNAME/decoder.git
git push -u origin main
```

Poi su GitHub: **Settings → Pages → Deploy from branch → main → / (root)**. Dopo un minuto l'app sarà live su `https://TUO-USERNAME.github.io/decoder/`.

## 🛠️ Stack

Solo HTML/CSS/JS vanilla in un unico file (`index.html`). Nessuna build, nessuna dipendenza da installare.

## 📄 Licenza

MIT — vedi [LICENSE](LICENSE).
