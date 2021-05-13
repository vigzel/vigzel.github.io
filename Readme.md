Kreirao sam prazan site sa `jekyll new .`

Zatim sam prema [uputama][instructions] postavio github-pages plugin na verziju 214 koja je bila [zadnja verzija][gp-version] u trenutku kreiranja sitea i onda pokrenuo `bundle update`.

```
gem "github-pages", "~> 214", group: :jekyll_plugins
```

Ipak sam odustao od ove gore implementacije/

 * GitHub Pages is a static site hosting service that takes HTML, CSS, and JavaScript files straight from a repository on GitHub, optionally runs the files through a build process (using Jekyll), and publishes a website. 
 * "Github pages" hosta statički HTML koji mu se postavi. 
 * "Github pages" također podržava i Jekyll pages, gdje github zapravo koristi Jekyll da builda repo i generira statičke stranice koje će hostati. Međutim ovo ima nekoliko mana:
	- može trajati do 20 min, iako je obično instantno
	- neki jekyll plugini nisu podržani
	- github je jaaaako spor sa updateima, ne prate jekyll verzije ažurno, čak godinu i nešto kaskaju…

Ljudi uglavnom koriste Github Actions kako bi na svaki push na master pokrenuli build i push na branch "gh-pages" na kojem se onda hosta stranica. 
 * I'd recommend using GitHub Actions to build your site and publish it on GitHub Pages: https://github.com/BryanSchuetz/jekyll-deploy-gh-pages
 * GitHub Actions are the way to go if you want to use a custom Jekyll or plugins at your own risk.

Ne vidim zašto ne bi sam buildao sa jekyllom lokalno i onda to pushao na repo i postavio _site kao host dir....


GitHub Pages publishes any static files that you push to your repository. You can create your own static files or use a static site generator to build your site for you. 
GitHub Pages will use Jekyll to build your site by default. If you want to use a static site generator other than Jekyll, disable the Jekyll build process by creating an empty file called .nojekyll in the root of your publishing source, then follow your static site generator's instructions to build your site locally.

Ako želiš ipak koristiti branch "gh-pages" na koji ti github builda i publisha, tu su upute za [github-actions][github-actions].
 * prednost ovoga je da edit možeš napraviti izravno na githubu
 * jednostavno možeš setupirati neki periodički build (npr. buildaj mi site svaki dan u ponoć), ako je zbog nekog plugina to potrebno
 * commit log je pregledniji jer ne ukljucuje generirane/buildane datoteke u docs

To combine these three commands in one
```
git add .
git commit -a -m "commit" (do not need commit message either)
git push
```
Add an alias to `.gitconfig` file:
```
[alias]
    lazypush = "!f() { git add -A && git commit -m \"$@\" && git push; }; f"
```


Usage: `git lazypush "Long commit message goes here"`



Vidi: https://tianqi.name/jekyll-TeXt-theme/docs/en/quick-start

[instructions]: https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-a-repository-for-your-site
[gp-version]: https://pages.github.com/versions/
[github-actions]: https://jekyllrb.com/docs/continuous-integration/github-actions/