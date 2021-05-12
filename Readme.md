Kreirao sam prazan site sa `jekyll new .`

Zatim sam prema <a href="https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-a-repository-for-your-site">uputama</a> postavio github-pages plugin na verziju 214 koja je bila <a href="https://pages.github.com/versions/">zadnja verzija</a> u trenutku kreiranja sitea i onda pokrenuo `bundle update`.

```
gem "github-pages", "~> 214", group: :jekyll_plugins
```

Ipak sam odustao od ove gore implementacije/

 * "Github pages" hosta statički HTML koji mu se postavi. 
 * "Github pages" također podržava i Jekyll pages, gdje github zapravo koristi Jekyll da builda repo i generira statičke stranice koje će hostati. Međutim ovo ima nekoliko mana:
	- može trajati do 20 min, iako je obično instantno
	- neki jekyll plugini nisu podržani
	- github je jaaaako spor sa updateima, ne prate jekyll verzije ažurno, čak godinu i nešto kaskaju…

Ljudi uglavnom koriste Github Actions kako bi na svaki push na master pokrenuli build i push na branch "gh-pages" na kojem se onda hosta stranica. 
 * I'd recommend using GitHub Actions to build your site and publish it on GitHub Pages: https://github.com/BryanSchuetz/jekyll-deploy-gh-pages
 * GitHub Actions are the way to go if you want to use a custom Jekyll or plugins at your own risk.

Ne vidim zašto ne bi sam buildao sa jekyllom lokalno i onda to pushao na repo i postavio _site kao host dir....

