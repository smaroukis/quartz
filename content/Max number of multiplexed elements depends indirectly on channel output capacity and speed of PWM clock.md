---
title: Max number of multiplexed elements depends indirectly on channel output capacity and speed of PWM clock
date: 2024-04-04
description: Analysis of the non-linear tradeoffs in multiplexed display designs, focusing on the impact of gamma correction on perceived brightness levels and the limitations posed by output channel capacity and brightness requirements
tags:
  - leds
  - electronics
slug: 
draft: false
math: true
---

Here I show that the tradeoff between number of perceived brightness levels and number of multiplex elements is non-linear due to the power law for perceived brightness (requiring [gamma correction](Gamma%20Correction%20corrects%20for%20the%20human%20eye's%20non%20linear%20response%20to%20brightness%20levels.md)). In fact the limiting factor on the number of digits we can multiplex is due to both ① the number of parallel output channels and the driver chip's channel max output and ② the number of desired perceived brightness levels, with ① being in my opinion the more limiting of the two (although I need empirical experiments to conclude this).

In the table below we can see, for the 10 multiplexed-digit case, if we limit the individual channel output max current to 40mA this gives us only an equivalent of 4mA of DC current, which must be further subdivided into brightness levels to be able to implement a dimming effect. The number of gamma-corrected brightness levels is 23, where level 23 represents a full 1ms of on time, and level 1 represents 1ms/23=43us of on time.[^2]

| N (multiplexed elements) | Max Gamma-corrected Brightness Levels | $T_{on}$ (ms) | Duty Cycle (of refresh rate) | Required instantaneous current for 20mA DC (per channel) | Channel average current given max 40mA per channel |
| ------------------------ | ------------------------------------- | ------------- | ---------------------------- | -------------------------------------------------------- | -------------------------------------------------- |
| 4                        | 35                                    | 2.5           | 25%                          | 80mA                                                     | 10mA                                               |
| 10                       | 23                                    | 1             | 10%                          | 200mA                                                    | 4mA                                                |
| 15                       | 19                                    | 0.67          | 7%                           | 285mA                                                    | 2.8mA                                              |
_Assuming 100Hz refresh rate, 1MHz PWM clock, 8 channel output_

In summary, due to the nonlinear response of perceived brightness vs emitted intensity ($B_p \propto \sqrt[2.2]I$ w/ B=perceived brightness, I=intensity/current [^1]), if we have 8 units of time that we can divide into intensity/PWM/current, we actually only get $8^{1/2.2}\approx 2.57$ perceivable levels of brightness.

## Thorough Example 

Say we have a 1MHz PWM clock, that means the smallest unit of time we can update the PWM signal is 1us. Say we need a refresh rate of 100Hz - that is we need to sweep through all the multiplexed switches within 10ms. So in this case each switch can be on for a maximum of 10ms÷Ndigits. In the case of the 4 digit-multiplexed seven segment display,  $T_{digit} = 10\text{ms}/N_{digit}=2.5\text{ms}$. 

$$ T_{digit} = \frac{T_{RR}}{N_{digit}}=\frac{1}{f_{RR}N_{digit}}\bigg\rvert_{f_{RR}=100, N=4}=2.5\text{ms}$$

> [!NOTE] What are we multiplexing across?
> Here we are talking about multiplexing digits, but since you can multiplex across other things like segments, columns or rows we can more generally write $N_{digit}$ as $N_{mux}$. I will continue to talk about multiplexing digits here.

Let's go back to our PWM clock. How many PWM cycles can we fit into one digit multiplexing cycle? Divide the multiplexing period by the PWM unit period 2.5ms÷1us = 2500 PWM cycles within one multiplexing cycle. We can also get this directly from 

$$M_{PWM-per-mux}=\frac{T_{digit}}{T_{PWM}}=\frac{f_{PWM}}{f_{RR}N_{digit}}\bigg\rvert_{\text{PWM}=1\text{MHz, RR}=100, N=4}=2500 \text{ ``levels"}$$

But note that gamma correction results in increasingly more intensity required for the next level of perceived brightness ($B_p \approx I^{2.2}$). So even though we think we might have 2500 levels of brightness due to the 2500 PWM cycles, 1) at this timescale (1us) the $\Delta B$ isn't actually perceptible and 2) we actually only get $2500^{1/2.2}=35$ levels of perceived brightness.

$$M_{perceived}=\bigg(\frac{f_{PWM}}{f_{RR}N_{digit}}\bigg)^\frac{1}{2.2}=\sqrt[2.2]{2500} \approx 35$$

Another thing to thing about is the minimum time-on required per LED to appear "fully lit". Searching around the web gave between 100us to 2ms, but of course this depends on how hard we are driving the LEDs (typ. 20ms constant current). Above our $T_{digit}$ is already at 2.5ms which is at the upper edge. At 4 digits let's calculate the duty cycle of each digit. This will tell us how much we need to increase the current to reach our typical average LED current of 20mA.

$$D_{100\%B}=\frac{1}{N_{digit}}\bigg\rvert_{N=4}=25\%$$

At a 25% duty cycle, for 20mA average current we would need 80mA. This required equivalent current increases proportionally with the number of digits. Note that if we are driving a lot of segments, say 8, this means we need 80mA per channel and total 640mA, which is quite a bit and might exceed the driver capability.

Typically the maximum output is given per channel (or per-segment here). Assuming the channels are independent, that is they can all be driven at their max of something like 300mA per channel, we can calculate the maximum number of digits (lowest duty cycle) given a desired DC current as 

$$N_{max}=\frac{I_{max,chann}}{I_{DC}}=\frac{300}{20}=15 \text{ digits}$$

Then we can go back to our $M_{perceived}$ equation and substitute 

$$M_{perceived}=\bigg(\frac{f_{PWM}}{f_{RR}N_{digit}}\bigg)^\frac{1}{2.2}\bigg\rvert_{N=15\text{, PWM}=1\text{MHz, RR}=100} \approx 19$$

But wait! We want to check that $T_{digit} \ge 100\mu s$:

$$ T_{digit} = \frac{1}{f_{RR}N_{digit}}\bigg\rvert_{N=15\text{, }f=100Hz}=667\mu s \text{ ✅}$$

Note in the case we want $T_{digit} \ge 1\text{ms}$ our max number of digits is:

$$N_{max}=\frac{1}{f_{RR}{T_{digit}}}= 10$$

## Example Summary

In the case that we have a 10 digits to multiplex, and each multiplex cycle drives 8 segments 
So here is the summary of the specific case (N=10, $f_{RR}=100$, $f_{PWM}=1\text{MHz}$)
- 10 digits to multiplex
- during each multiplexed cycle:
	- 10 digits at 100Hz refresh rate gives us a digit on-time of 1/(10×100)=1ms, meeting the minimum on time spec
	- 8 segments driven from independent channels at the channel max of 300mA results in 300mA for 1ms resulting in 30mA of DC current through each segment 
	- 1MHz PWM clock gives 23 levels of perceived brightness (1000 × 1us "levels" of intensity) 


## Final Thoughts 

Things to note
- number of segments doesn't really affect anything except for the current requirements (these are basically parallel outputs) → although the MCU will have to either cycle through $K_{seg}$ to check if it should be still "on" or not for the individual brightness control OR setup callback timers depending on the individual brightness levels, so it does add complexity to the serial code
- tradeoff between $M_{perceived}$, levels of perceived brightness, and $N_{digits}$, since the more digits we have cuts into the number of PWM units we can give to each multiplex cycle. 
- I think the limiting factor on $N_{digits}$ is the $f_{RR}$ and the minimum on-time. But note that the minimum on-time is actually very dependent on the amount of current that we push through it, so actually **the channel max current limits the number of multiplexed digits _indirectly_ through $T_{mux,min}$** — even though we noted that the channel current directly impacts the number of _segments_ (parallel outputs) and not the number of multiplexed digits.

[^1]: this nth root function is similar to $\log_2 x$ but with less of a "knee"
[^2]: I will also need to add off time for de-ghosting