---
title: Git submodule tricks
date: 2024-02-15
description: 
tags:
  - git
slug: git-tricks
draft: false
math: false
---
I was working with git submodules to help build this TIL site and there are some quirks to be aware of. Mainly that when we `git submodule add` it doesn't pull down the code by default, and we have to do a `git submodule update --init`. 

Also the `git submodule update --remote` command might send us into a detached HEAD state depending on what branch and/or commit we're tracking in the submodule. 

See this good writeup <https://www.activestate.com/blog/getting-git-submodule-track-branch/>

---

**Add submodule tracking a specific branch**
`git submodule add -b <branch_name> <repository_url> <path/to/submodule>`
`git submodule update --init`

> `git submodule update --init` is a special command we need to run to fetch the submodule code for the first time (it is not pulled in by default using `add`

**Updating submodule**
`git submodule update --remote`
> if you run the `git submodule update --remote` command after having edited code in the submodule, your module will go back into being in a detached head state, so you'll need to remember to re-checkout the next time you want to edit it again.

I found it's better just do go directly into the submodule and do a `git pull <remote> <branch>` to be explicit. 

**Editing Submodule**
Just need to `cd /path/to/submodule` and make edits, check out branches, push, whatever. Just note that when we do a `git submodule update --remote` command we will go to the detached head state, that is we will go to whatever commit hash we specified when we did a `git submodule add ...`. 

**May Need Extra Commit for Submodule Tracking**
> After making new commits in the submodule or pulling in new commits, `git status` will show the submodule as modified, even though we know we want to track the latest changes in the submodule. We can get rid of this by updating the submodule commit reference to the latest code in the remote branch by
`git add path/to/submodule` 
`git commit -m 'Update submodule tracking`


### Inspecting Submodule Status

Check status
`git submodule status <path/to/submodule>`

(Inside the submodule)
`git remote --vv` will show the remotes and if we are behind 

### Removing Submodule

1. Delete the relevant section from the `.gitmodules` file.
2. Stage the `.gitmodules` changes: `git add .gitmodules`
3. Delete the relevant section from `.git/config`.
4. Run `git rm --cached path_to_submodule` (no trailing slash).
5. Run `rm -rf .git/modules/path_to_submodule` (no trailing slash).
6. Commit the changes: `git commit -m "Removed submodule"`
7. Delete the now untracked submodule files: `rm -rf path_to_submodule`
