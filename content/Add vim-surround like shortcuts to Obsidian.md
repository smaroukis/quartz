---
title: Add vim-surround like shortcuts to Obsidian
date: 2023-06-23
description: 
tags: [obsidian, vim]
math: false
---

I installed the [Obsidian](https://obsidian.md) [Vimrc support](https://github.com/esm7/obsidian-vimrc-support) plugin to add better keyboard shortcuts for quickly surrounding selected text with parentheses - `()` . 

Create and add the following to your custom `.vimrc` file (the plugin defaults to `.obsidian.vimrc`):

```config
exmap surround_wiki surround [ ](%20)
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets
```

Usage:
- position cursor anywhere on a word in normal vim mode and type `s(` for parenthesis `[[` for double brackets (special case), etc. See the above mappings for details.