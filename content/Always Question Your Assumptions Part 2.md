---
title: Always Question Your Assumptions Part 2
date: 2024-02-27
description: 
tags:
  - electronics
slug: 
draft: false
math: false
---
I was trying to program an ATTiny using an Arduino Mega, so I needed to connect the `MOSI`, `MISO`, `SCK`,`VCC`, and `GND` pins. 

On the most recent version of the Mega data sheet, when seeing `COPI` on the `SPI` bus, I immediately assumed this was `Child Out Parent In`, which I thought sounded _weird_ and confusing since this is previously the `MOSI` pin, why would they reverse the order when [removing casual references to slavery](https://hackaday.com/2020/06/29/updating-the-language-of-spi-pin-labels-to-remove-casual-references-to-slavery/)? Oh well...[^1]

An hour later I'm getting `avrdude` errors and trying to debug, is my clock set right, did I follow the instructions correctly, **did I set the correct pins in my Arduino ISP sketch?**

Of course I didn't. Not ~~Child~~, Controller  -- oof. This can be added to the [traps for young players](traps%20for%20young%20players). 

For my future reference:

| Previous Name | New Name | New New Name | Notes |
| ---- | ---- | ---- | ---- |
| `SDO`/`SDI` |  |  | Used for single role hardware, this makes the same mistake of ambiguity as in the `Tx`/`Rx` pins, since in/out depends on your point of reference, so `COPI` is preferred.  |
| `MOSI`/`MISO` | `COPI`/`CIPO` [^2] | `PICO`/`POCI` | "Controller Out Peripheral In" |
| `SS` | `CS` |  | Chip select |

[^1]: You'll note that I had not read the linked article at the time.

[^2]: Updated from `COPI` to `PICO` because of similarity offensive term in Polish