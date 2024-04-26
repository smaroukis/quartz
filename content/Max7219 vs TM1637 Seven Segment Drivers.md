---
title: Max7219 vs TM1637 Seven Segment Drivers
date: 2024-02-26
description: 
tags:
  - electronics
slug: seven-segment-driver-comparison
draft: false
math: false
---
Two chips commonly used to drive seven segment displays are the MAX7219 and the TM1637 chip, but they have differences that the designer should be aware of. The MAX7219 is better for cascading devices and operates at higher speeds whereas the TM1637 includes both a 2x6 keyscan capability and a can only drive common anodes[^1]. While the TM1637 uses a two-wire synchronous serial protocol similar to I2C (requiring only a clock and data in/out line), on the other hand the MAX7219 uses SPI (requiring `DIN`/`MOSI`, `CS` and `CLK` lines), and can be used like a cascadable shift register since it also has a `DOUT` line that can be cascaded to the next.

the tl;dr the MAX7219 is better for cascading 8-digit displays and has more features for display driving (internal BCD-decoder, can set max segment current separate from PWM dimming settings, can drive any 8x8 matrix), whereas the TM1637 is good for a single display (up to 6 digits[^1]) and also includes a keyscan functionality.

> Show me the ~~datasheets~~, application schematics!

| MAX7219 Application | TM1637 Application |
| ---- | ---- |
| ![](attachments/Screenshot%202024-02-26%20at%201.47.11%20PM.png) | ![](attachments/Screenshot%202024-02-26%20at%206.42.19%20PM.png) |
| Notes: 5V input, can multiplex any 8x8 matrix (whether it is seven segment or 8x8 dot matrix) | Notes: Shown is the 1637 version which can only drive 6 digits. The 1638 can drive 8 digits.   |

## MAX7219
![](attachments/Screenshot%202024-02-26%20at%2012.17.48%20PM.png)


The  chip is commonly used to drive LED dot matrixes, but can also be used to drive Seven Segment displays (it has internal decoding for driving common cathode seven segment displays). It is basically just a generic 8x8 multiplexed display driver which drives 8 columns and 8 rows independently, so we can actually drive either common anode or common cathode displays. 
- can drive common cathode or common anode (can only use internal BCD decoder for common cathode)
- sets max segment current (`I_SET`) based on a single external pullup resistor
- uses PWM to change the display brightness (set digitally by a register as X% of `I_SET`)
- easily cascaded with separate data in and out pins

The chip has an internal BCD decoder and we can set it to a decode mode and give it just the 4 bit binary-coded-decimal that we want on pins D3-0. If we don't set it to decode mode we just have to encode the 7-segments A-G ourselves. 

> [!EXAMPLE] Example - cascading MAX7219s
> ![](attachments/Pasted%20image%2020240226135911.png)
> 
> 7219s are daisy chained `DOUT`→`DIN` like shift registers. Unlike the TM1637, you don't have to address the second one, you can just shift data through the first.

## TM1637 / TM1638
![](attachments/Screenshot%202024-02-26%20at%206.46.38%20PM.png)
_Note shown above is the 8 digit capable TM1638 chip_

The TM1637 is can only be used with **common anode** seven segment displays, and I found it more prevalent than the Max chip on both amazon and aliexpress sellers.
- can only be used with common anode seven segment displays
- can drive 6 digits (`GRID 1...6` pins) → use TM1638 to drive 8 digits with one chip
- also has a keypad scan function and was being sold in keyscan + display driver kits
- has display dimming (via PWM duty cycle) but cannot set max segment current

Where as the Max 7219 acts as a shift register and can be cascaded (has separate data in and out pins), the TM1637 has just a combined data in/out pin. This is not to be used as a shift register data out, but rather for an MCU to read serial data to, for example, identify button presses (for matrix keypad scanning). 

## Example AliExpress Products

For example here is a screenshot for a THT  with an 8x8 dot matrix display. What's cool about this one is that the MAX7219 through hole type is provided with an IC socket. That makes it reusable for other projects, say if you want to start daisy chaining these together and build a large pcb to do so, you can reuse the chips you already have. 
Although the price is ¥176/display including chip, whereas you can get a set of 4 for around ¥460 yen  (¥115/display + chip) -- but in this case they are the SMD version and less reusable. 
%% TODO  - link project if we ever maker it %%

![](attachments/Screenshot%202024-02-26%20at%2012.11.17%20PM.png)


This one says its now down to ¥75 for **four**, but I don't know if I believe it since it's also ¥75 for **one**. Note for this one it will be the SMD version of the Max chip.
![](attachments/Screenshot%202024-02-26%20at%2012.16.32%20PM.png)

Here is the SMD chip with one of the LED matrixes removed from its sockets:
![](attachments/Screenshot%202024-02-26%20at%2012.17.48%20PM.png)

I did find one seller selling the Max chip with a seven segment display, but the shipping time was 2 months...

![](attachments/Screenshot%202024-02-26%20at%2012.19.23%20PM.png)


## Seven Segment Displays with the TM1637


You can tell that they are using the TM1637 by the title, but also because the TM1637 does not have separate Data In and Out pins. It has a combined DIO (data in and out).

|  |  |
| ---- | ---- |
| ![](attachments/Screenshot%202024-02-26%20at%2012.21.42%20PM.png) | ![](attachments/Screenshot%202024-02-26%20at%2012.20.30%20PM.png) |
|  |  |
  


[^1]: The TM1637 can drive 6 digits, and the TM1638 can drive 8. I found more commonly 4 digit displays using the TM1637 than 8 digit displays (as 2 sets of 4 digit displays) using the TM1638. 