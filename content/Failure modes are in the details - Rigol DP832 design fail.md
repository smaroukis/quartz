---
title: Failure modes are in the details - Rigol DP832 design fail
date: 2024-02-28
description: 
tags: 
slug: 
draft: false
math: false
---

It's pretty crazy that a 5V linear regulator, _powering the display circuitry_, being improperly heat-sinked causes the whole $400 precision power supply to reset. Apparently this is for pre-2013 Rigol DP832s/DP832As (see also [Linear Regulators Are (not) That Hot](Linear%20Regulators%20Are%20(not)%20That%20Hot.md)).

![](attachments/Screenshot%202024-02-28%20at%206.17.39%20PM.png)
"5W, it's bloody ridiculous, did no one even stick their finger on this or think about it?"

From "EEVblog [#512](https://www.youtube.com/hashtag/512) - Rigol DP832 Bad Design Investigation" →  https://youtu.be/y-KkPLWZJko?si=7UP6E97G2XBQfj-y&t=1566
