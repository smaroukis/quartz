---
title: Thermal Design Flaw Causes the Rigol DP832 Power Supply to Reset
date: 2024-02-28
description: 
tags:
  - electronics
slug: 
draft: false
math: false
---

It's pretty crazy that a 5V linear regulator, _powering the display circuitry_, being improperly heat-sinked causes the whole $450 precision power supply to reset. Well I guess it's not so surprising since it is the only regulator powering the digital display, but what's more surprising is that it looks like just a pretty measly black anodized heatsink was grabbed out of the parts bin, "this should work right? I found it over there in my scrap pile". Not that I would do a better job of designing a power supply but even I wrote about this in one of my first TIL posts (see [Linear Regulators Are (not) That Hot](Linear%20Regulators%20Are%20(not)%20That%20Hot.md))

From "EEVblog [#512](https://www.youtube.com/hashtag/512) - Rigol DP832 Bad Design Investigation" →  https://youtu.be/y-KkPLWZJko?si=7UP6E97G2XBQfj-y&t=1566

Apparently this is for pre-2013 Rigol DP832s/DP832As and Rigol later upgraded the board with a larger, silver heatsink and firmware which you can see [here](https://youtu.be/6Kfp77-7VU8?si=vGnikuwrr4MzG1sI&t=238) in the second screencapture below. 

Original heatsink that caused issues when the linear regulator went into thermal shutdown and blanked the display causing a full reset:
![](attachments/Screenshot%202024-02-28%20at%206.17.39%20PM.png)
> "Five watts?!?, it's bloody ridiculous, did no one even stick their finger on this or think about it?"


![](attachments/Screenshot%202024-02-28%20at%206.41.18%20PM.png)
_Upgraded heatsink hungry for more WATTS_


