---
title: Always Question Your Assumptions
date: 2023-08-20
description: 
tags:
  - life-tips
math: false
---

Today I learned to always question your assumptions, even the most basic ones.

I forgot how the internal contacts of a pushbutton switch were connected. Somehow I thought that because they can straddle the middle of a breadboard, they are meant to connect left to right. 

But of course that does not work for anywhere else on the breadboard, where the horizontal strips are connected. After a few hours of debugging via `print`s (I thought it was in my logic, or that I didn't understand `static` variables), I had to pullout the big guns and go into `gdb` , which I usually try to avoid. 

I quickly found that `buttonState` was 0, and not 1 as expected for the `INPUT_PULLUP`
![Screenshot 2023-08-20 at 12.37.39 PM](attachments/Screenshot%202023-08-20%20at%2012.37.39%20PM.png)

Then of course I looked for the schematic of the pushbutton:
![Screenshot 2023-08-20 at 12.35.05 PM](attachments/Screenshot%202023-08-20%20at%2012.35.05%20PM.png)

Ouch!

