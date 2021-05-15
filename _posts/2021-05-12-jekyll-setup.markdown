---
layout: post
title:  "Github pages with Jekyll"
date:   2021-05-12 16:54:25 +0200
categories: [Tutorial]
tags: [jekyl, github-pages]
---


# Instalation

Install Jekyl according to instructions on [jekyllrb][jekyllrb]  
Setup Github page according to instruction on [github][gh-pages]

# About

`Jekyll` is a static site generator. Jekyll takes Markdown and HTML files and creates a complete static website based on your choice of layouts. 

`GitHub Pages` is a static site hosting service that takes HTML, CSS, and JavaScript files straight from a repository on GitHub, and **optionally** runs the files through a build process (using Jekyll), and publishes a website. 


After you push files to a branch selected as publishing source, Github will:
 * Use **Jekyll** to build your site
   - If you wan't to  disable the Jekyll build process create an empty file called `.nojekyll` in the root directory
 * Publish any static files that you pushed to your repository

# Publishing options

Checkout your repo and create empty project with `jekyll new .`


## Option 1


1. Open the `Gemfile` that Jekyll created.  
  - Add "#" to the beginning of the line that starts with gem "jekyll" to comment out this line.
  - Add the github-pages gem by editing the line starting with # gem "github-pages". Change this line to:
  ```
  gem "github-pages", "~> 214", group: :jekyll_plugins
  ```
  > 214 is the latest supported version of the github-pages gem at the time of writing
2. Save and close the Gemfile.
4. From the command line, run `bundle update`
5. Push changes to your master branch
6. Under repository settings, set `branch master /(root)` as your publishing source

![Github page source](/assets/images/gh-page-source.jpg)

> Cons:
 * Odd URLs: https://vigzel.github.io/jekyll/update/2021/05/14/welcome-to-jekyll.html
 * You can't use third party plugins that are not whitelisted by github pages
 * You can't use latest jekyll
   - current jekyll version is 4.2, while github pages uses 3.9 due to breaking changes in 4.0. 
   - jekyll 4.0 was published in August of 2019. (#you-do-the-math)
   

## Option 2

This option will enable you to use latest and greates from jekyll.

 1. Create branch `gh-pages` and set it's `(root)` as your hosting source
 2. Create Github Action that will build your site and push it to the branch `gh-pages`
   - _actions are added in the root folder under `.github\workflows\`_

> When Github Action builds your site from master branch, the contents of the destination directory will be automatically pushed to the gh-pages branch with a commit, ready to be used for serving.  
The Action we’re using here will create (or reset an existing) gh-pages branch on every successful deploy.

```yml
name: Build and deploy Jekyll site to GitHub Pages

on:
  push:
    branches:
      - master

jobs:
  github-pages:
    runs-on: ubuntu-16.04
    steps:
    - uses: actions/checkout@v2

    # Use GitHub Actions' cache to shorten build times and decrease load on servers
    - uses: actions/cache@v2
      with:
        path: vendor/bundle
        key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile') }}
        restore-keys: |
          ${{ runner.os }}-gems-

    # Standard usage
    - uses:  helaili/jekyll-action@v2
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
        target_branch: 'gh-pages'
```

> Cons:
 - build action can last some time (up to 20 minutes) 
 - build can fail (if it fails you'll get notified by email)


## Option 3

Same as Option2, but instead of `Github Action`, local `.bat` file is used to build and publish.

If build fails, it fails localy. Publish is fast because site is built localy, and after push to branch `gh-pages` github can just publish static site, it does't go through build process since I add `.nojekyll` in site root.


```bat
call bundle exec jekyll build

cd _site

if not exist .nojekyll (type NUL > .nojekyll)
if exist .git (rmdir /s/q .git)

REM Setup git
git init
git config user.name "vigzel"
git config user.email "zeljkv@gmail.com"


REM PUBLISH
git add .
git commit -m "Publish site"
git push --force https://github.com/vigzel/vigzel.github.io.git master:gh-pages

REM Clean up
rmdir /s/q .git

cd ..
```

> Cons:
 - can't edit page on the fly (directly online over github)


[jekyllrb]: https://jekyllrb.com/docs/
[gh-pages]: https://pages.github.com/