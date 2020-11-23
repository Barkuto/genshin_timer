#!/usr/bin/env sh

set -e

npm run build

cd dist
git init
git remote add origin https://github.com/Barkuto/genshin_timer.git
git checkout --orphan gh-pages
git add -A
git commit -m 'deploy'
git push --set-upstream origin gh-pages

cd -