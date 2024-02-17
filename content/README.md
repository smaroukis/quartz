> Note if you are viewing this on the `https://til.maroukis.net` domain this is the README of the source notes at <https://github.com/smaroukis/til-source>. 

**Today I Learned / TIL / Breadcrumbs**
- The TIL website is inspired by others such as [Simon Willison](https://til.simonwillison.net/) and hackaday's concept of leaving [Breadcrumbs](https://hackaday.com/2023/08/09/share-your-projects-leave-breadcrumbs/) for projects. 
- With great thanks to Jacky Zhao's amazing [Quartz](https://quartz.jzhao.xyz/) project, it makes publishing from Obsidian to a hosted static site easy.

### Quartz Setups
- See the [forked repo](https://github.com/smaroukis/quartz), as there are some custom build steps locally or in github actions added to keep this repo (markdown source notes) separate from the quartz repo.

### Obsidian Setups
- set default attachment location
- set default links to markdown
- plugins: 
	- Templater
	- Obsidian Git

### Template
The template isn't included in the remote so it doesn't copy over to the Hugo site. I place this file in the `Templates` folder (e.g. `Templates/t-til.md`). This uses the Templater plugin to create a new post with the correct frontmatter used by hugo.

```
---
title: <% tp.file.title %>
date: <% tp.file.creation_date("YYYY-MM-DD") %>
description: 
tags: 
math: false
---
```