---
title: Fixing pdf syntax errors when printing a pdf as a book on lulu
date: 2024-04-02
description: Convert the pdf to postscript and run job options in Acrobat Distiller
tags:
  - using-software
slug: 
draft: false
math: false
---
To print a 400 page ebook pdf I used lulu.com which has great pricing (around $0.06/color page), but when I uploaded I received a lot of errors.

There wasn't much online about how to take an existing pdf where we don't have access to the source and fix it for printing. The key is to export PDF > PostScript and then run a lulu-provided Job Options file in Acrobat Distiller on the `.ps` file, which will try to fix it up for printing and export to pdf. 

Here are my original errors on lulu.com:
![](attachments/Screenshot%202024-04-01%20at%2012.22.11%20PM.png)
I confirmed these errors locally in Adobe Acrobat by running the Preflight "Digital printing (color)" profile: 
![](attachments/Screenshot%202024-04-02%20at%2012.22.01%20PM.png)

## Fixing Errors Locally

Steps
1. Download the Acrobat Job Options file from the [lulu website](https://help.lulu.com/en/support/solutions/articles/64000255519-pdf-creation-settings). 
2. In Acrobate export to PostScript
3. Open the Job Option file which should pullup Acrobat Distiller
4. Open/import the `.ps` file into Distiller and run the `Lulu-Interior-Job-Options` job
5. Upload the created pdf online

