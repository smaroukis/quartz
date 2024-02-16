#!/usr/bin/env bash

# Requires: smaroukis/quartz already checked out and updated
# NB: This script is run within the github actions workflow runner
# BASE_DIR is the directory from which we called the script

BASE_DIR="$GITHUB_WORKSPACE"
SCRIPT_DIR="$BASE_DIR/_userscripts"
CONTENT_DIR="$BASE_DIR/content"

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL" # set this in the GH repo
# or do
# git config --global credential.helper store

# Step 0: Initialize submodule
# should be done in the github actions workflow

# Step 1: Switch to main branch in quartz/content submodule and pull updates
cd $CONTENT_DIR
# HERE - not getting the submodule?
echo "🍿 Updating content (main branch)..."
git submodule update --remote --merge
# git remote -vv
# git checkout main  # make sure we're on main and not the publish branch
# git pull origin main # get new content
# exit if issue

pushd $SCRIPT_DIR >> /dev/null
echo "🍿 Building New Index..."
source makeindex.sh # build new index
popd >> /dev/null
echo "🍿 Commit/push new content (built index)..."
git add -u
git commit -m 'auto commit new index'
git push origin main
# TODO Need to handle permissions here

# Step 3: Commit and push changes to smaroukis/quartz → main branch
cd $BASE_DIR
echo "🍿 Commiting Changes to quartz → main..."
git checkout main 
git add content # add new content including deletions
git commit -m "auto update content"
git push origin main