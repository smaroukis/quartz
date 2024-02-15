---
title: Creating Citekey Title in Readwise to mimic Zotero
date: 2024-01-12
description: 
tags:
  - personal-knowledge-management
  - using-software
slug: readwise-citekeys
draft: false
math: false
---

Since Readwise uses jinja2 templating language, we can use the jinja filters to create a custom title given the metadata of a book or article.  

Requires
- Readwise
- Obsidian
- Readwise plugin in Obsidian

In Zotero, citekeys are an informal citation key used as a title or citation upon export that is created from the metadata of a book or article. 

I typically use something like `<authorLastName><Title><Year>`  

For example: `nietzscheBirthofTragedy1884`

In Zotero's Better BibTex plugin we can defined this using:

```
auth.lower + shorttitle(3,3) + year
```
![](attachments/Screenshot%202024-01-12%20at%202.09.51%20PM.png)
To mimic this in Readwise we have to do some work to create our own title by stripping punctuation and whitespace. 

In the "File name" section, use a custom filename with the following filters:

![](attachments/Screenshot%202024-01-12%20at%202.18.36%20PM.png)

```
{{ author.split(' ') | last | lower if author|wordcount >=2 else author|lower}}{{ title|replace(' ', '')|replace('#','_')|replace('.','_')|replace('"', '')|replace("'", "")|replace(":", "-") }}{{ published_date|date('Y') }}
```

The result should come into Readwise as follows (note I emailed readwise support about having issues with the `published_date` coming in)

![](attachments/Screenshot%202024-01-12%20at%204.41.32%20PM.png)