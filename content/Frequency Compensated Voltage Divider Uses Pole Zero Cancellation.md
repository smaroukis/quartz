---
title: Frequency Compensated Voltage Divider Uses Pole Zero Cancellation
date: 2024-10-19
description: The frequency compensated divider uses pole zero cancellation to achieve constant gain over all frequencies.
tags:
  - electronics
  - analog-electronics
slug: 
draft: false
math: true
---

Inside oscilloscope probes there is a variable capacitor to compensate for the unknown capacitance of the scope's front end. We want to match this with our probe so that we get a flat response over the whole bandwidth of both devices (both the probes and the oscilloscope). The mismatch can be seen as under or overshoot when probing a square wave, but interestingly in the frequency domain we can show that the mismatch results in improper cancellation of the pole and the zero created by the two RC filters.

The trick is to get $R_1C_1 = R_2C_2$. There is actually always zero at $\frac{1}{R_2C_2}$ (the pole is a bit more complicated).

When $R_1C_1 \ne R_2 C_2$ then something like the following happens:

![](attachments/Screenshot%202024-10-19%20at%204.56.35%20PM.png)

In this case $R_1C_1 > R_2C_2$ the zero from $\frac{1}{R_2 C_2}$ happens to be at lower frequencies than the pole, thus dominating the gain vs. magnitude plot at lower frequencies resulting in an increasing slope until the pole comes in to flatten things out.

When the pole and zeros exactly cancel, the response is flat:
![](attachments/Screenshot%202024-10-19%20at%205.01.13%20PM.png)

## Related
- https://wiki.analog.com/university/courses/alm1k/circuits1/alm-cir-voltage-divider
