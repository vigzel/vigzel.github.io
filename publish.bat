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