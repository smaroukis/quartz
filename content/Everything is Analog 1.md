---
title: Everything is Analog 1
date: 2024-07-13
description: 
tags:
  - embedded-systems
  - stm32
  - p3839
slug: 
draft: false
math: false
---

The bit-banged Clock waveform of a found-online TM1637 library for STM32 is ugly and only shows the clock getting up to 1.6V (3.3V supply) for "High"...but bit banging at `TM1637_BIT_DELAY = 40` works, and "10" doesn't (not enough time for the signal to reach the lower threshold of digital 1.)

No blinky (1.2V):
![](attachments/Screenshot%202024-07-13%20at%206.56.03%20PM.png)
Blinky (1.6V):
![](attachments/Screenshot%202024-07-13%20at%207.01.00%20PM.png)
Found culprit:
![](attachments/Screenshot%202024-07-13%20at%206.56.13%20PM.png)
