#!/bin/bash
set -e

# Go to the directory that contains the static site
cd public 

# Add CNAME if we use an external url
if [ -n "$CNAME" ]; then
    echo "$CNAME" > CNAME
fi

# Setup directory to be pushed to the github pages repo
git init

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "travis@unigornel.org"

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add .
git commit -m "Deploy output of ($TRAVIS_COMMIT) to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch.
git push --force --quiet https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git master >/dev/null

