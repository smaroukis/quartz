---
title: Where to find the Arduino pin definitions in the ATTiny core file
date: 2024-02-27
description: 
tags: 
slug: 
draft: true
math: false
---
Here's how to verify your pin numbers (those used by `digitalWrite`, etc) for non standard / gqmcu's being used with the Arduino IDE, such as the ATTiny85 below.

Since I couldn't find the ATTiny core hardware files downloaded locally by the IDE, I looked at the GitHub repo.

In Arduino IDE (I'm using v2.3.2) go to the Board Manager and search for the board in question. Click More Info to go to the GitHub repo page. 

![](attachments/Screenshot%202024-02-27%20at%2012.25.45%20PM.png)


Under `attiny/variants/tiny8/pins_arduino.h` ([repo](https://github.com/damellis/attiny/blob/master/variants/tiny8/pins_arduino.h)) we see the pinout ASCII diagram for the 8 pin version:

![](attachments/Screenshot%202024-02-27%20at%2012.24.26%20PM.png)


But the actual code will be a digital pin to a bit mask

> `PROGMEM` says to store the data in the program memory instead of volatile SRAM. 



DDRB = data direction register b


> Note `_BV` function is a macro used in AVR-GCC (the compiler used for Arduino) to create a bitmask with a single bit set to 1 at the specified position. The name `_BV` stands for "Bit Value".

```c
#define _BV(bit) (1 << (bit))
```
