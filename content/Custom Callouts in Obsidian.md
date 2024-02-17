---
title: Custom Callouts in Obsidian
date: 2023-08-26
description: 
tags:
  - obsidian
math: false
---

TIL how to add custom icons to callouts in obsidian. The quickest way is to provide an icon name found at <https://lucide.dev> , for example with the <https://lucide.dev/icons/bot> icon `bot`, including the following in a custom css file in `/path/to/vault/.obsidian/snippets`:

```css
/* in   /vault_root/.obsidian/snippets/custom-callouts.css */
.callout[data-callout="ai"] {
    --callout-color: 192, 77, 88;
    --callout-icon: bot;
}
```

Then enable this in the Obsidian Settings > Appearance > CSS Snippets

> Note it won't work with Obsidian Publish

Aside: I'm using it to create callouts for AI/LLM generated content that I include in my notes, so I know that I may need to verify the truthfulness of the statement later, such as in [POP to PC vs BX instruction](POP%20to%20PC%20vs%20BX%20instruction).