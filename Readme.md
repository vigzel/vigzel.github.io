
# Current setup

Current theme: [Chirpy][chirpy]

I'm currently using both Option 2 (Github Actions) and Option 3 (publish.bat) for my publishing setup.

Unpublished posts are located inside `_drafts` folder. 
In order to see my "drafts", when I'm building localy I use

```
bundle exec jekyll serve --drafts
```


Saving changes includes these three commands in repetition:

```
git add .
git commit -m "commit"
git push
```

To combine them in one I added an alias to `.gitconfig` file:

```
[alias]
    lazypush = "!f() { git add -A && git commit -m \"$@\" && git push; }; f"
```

Usage: `git lazypush "commit message goes here"`


This seems like an interesting theme: 
 * [TeXt-theme](https://tianqi.name/jekyll-TeXt-theme/docs/en/quick-start)

[chirpy]: https://chirpy.cotes.info/