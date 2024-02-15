---
title: Vim - delete all lines not containing a keyword
date: 2024-01-12
description: 
tags:
  - personal-knowledge-management
  - obsidian
  - vim
slug: 
draft: false
math: false
---

To delete all the lines below the current not containing an `=`:

```
:,+g!/==/d
```

OR
```
:,+v/==/d
```

This is used in a book highlighting workflow where I highlight the most important quotes in markdown (surrounding words by `==`) and then move those important highlights to another note.



