---
title: Gamma Correction corrects for the human eye's non linear response to brightness levels
date: 2024-03-15
description: 
tags:
  - electronics
  - leds
slug: 
draft: false
math: false
---
We use gamma correction to linearize the perceived brightness of a light source when created via PWM, especially in relation to other light sources around.

This is because even though PWM driving of LEDs results in a linear control of the amount of light outputted by the LED (luminous flux driven by average current), the human-perceived brightness does not change linearly.

For example a +5% duty cycle change from 5% to 10% which results in a +5% increase in average current through the LED, thus a +5% increase in luminous flux (actual "brightness") might result in a 7% change in perceived brightness. We use gamma correction to linearize the perceived brightness output to the PWM input (see graph below). 

I came across this when researching ways to drive large arrays of seven segments similar to the hexboard project [here](https://github.com/brainsmoke/hexboard). 

%% TODO project linke %%

![](attachments/Pasted%20image%2020240315104322.png)
> Source https://electricfiredesign.com/2022/11/14/gamma-correction-for-led-lighting/


