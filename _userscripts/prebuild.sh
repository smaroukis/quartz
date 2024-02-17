#!/usr/bin/env bash

# Requires: 
# - smaroukis/quartz already checked out, working directory is quartz
# - userscripts prebuild.sh and makeindex.sh in quartz/_userscripts
# - content stored in quartz/content
# - for local run need quartz npm dependencies installed

BASE_DIR=

if [ "$GITHUB_ACTIONS" = "true" ]; then
    # if github workflow
    echo "✅ Running in Github Actions runner..."
    BASE_DIR="$GITHUB_WORKSPACE"
    git config --global user.name "$GIT_USER"
    git config --global user.email "$GIT_EMAIL" # set this in the GH repo
else
    echo "✅ Running locally..."
    BASE_DIR="/Users/s/11_code/37b-til-quartz"
fi

SCRIPT_DIR="$BASE_DIR/_userscripts"
CONTENT_DIR="$BASE_DIR/content"

# Check if the current directory is the BASE_DIR
if [ "$PWD" = "$BASE_DIR" ]; then
    echo "✅ Current directory is the BASE_DIR: $BASE_DIR"
else
    echo "❌ Current directory is not the BASE_DIR: $BASE_DIR"
fi

# Step 1: Build new index and push new contents
pushd $SCRIPT_DIR >> /dev/null
echo "🍿 Building New Index..."
source makeindex.sh # build new index
popd >> /dev/null

if [ "$GITHUB_ACTIONS" = "true" ]; then
    echo "🍿 Commit/push new content/index.md..."
    git add content
    git commit -m 'auto commit new index'
    git push origin main
    # we will build the site in the workflow due to dependencies
else
    # serve the site locally
    npx quartz build --serve
fi