---
title: A biquinary counter is a mod-5 counter with a toggling top-bit every 5th count
date: 2024-02-22
description: 
tags:
  - electronics
slug: 
draft: false
math: false
---

biquinary
**:** of, based on, being, or relating to a mixed-base system of numbers in which each decimal digit _n_ is represented as a pair of digits _xy_ where _n_ = 5_x_ + _y_ and _x_ is written in base 2 (binary) as 0 or 1 and _y_ is written in base 5 (quinary) as 0, 1, 2, 3, or 4

It is a count-to-5 3-bit counter with a 4th top bit toggling every 5th count (so two cycles of 5 counts). 

When using the 74LS90 BCD decade counter for the first time I was wondering why they had two separate counters in side, a mod-2 counter and a mod-5 counter.

The common way to configure the 74LS90 as a BCD 4-bit decade counter is as follows ([source](https://www.uobabylon.edu.iq/eprints/publication_12_16297_163.pdf)- CLK A is the mod-2 counter input and CLK B is the mod-5 counter input):
![](attachments/Screenshot%202024-02-22%20at%2010.53.13%20AM.png)
_By connecting, `Q_A`, the output of the mod-2 counter (1-bit output that toggles every two cycles) to, `CLK_B`, the input of the mod-5 counter (3 bit output that counts up to 5), we create a mod-10 (decade) counter._

But we can also create a _biquinary_ counter, where for the 4 bit output the bottom 3 bits have two cycles of incrementing from `000...100`, and the MSB is `0` for the first 5 sub-cycles, and `1` for the last 5. A timing and state diagram explains it better:
![](attachments/Screenshot%202024-02-22%20at%2011.03.37%20AM.png)
_Note clocks are falling edge triggered. The way to setup the biquinary counter is to have the main clock input into `CLK B` (the mod-5 counter) and have the `Q_D` output (MSB of the mod-5 counter) as the input to `CLK A`. This means when the mod-5 MSB goes from `1`→`0` (on the 5th count) the mod-2 counter will toggle. Note that the biquinary outputs must be taken as shown, with `Q_A` as the MSB and `Q_B` as the LSB._

**Usefulness**
The top bit can be thought of as a checksum .This is actually used in the Japanese abacus counting system. It seems it is also used in one of the worlds oldest existing working computers [([hackaday](https://hackaday.com/2019/08/03/maybe-the-oldest-computer-probably-the-oddest/))], but here it is implemented with 7 relays for 7 bits, instead of the 4 bits above .

#todo add photo of abacus

#todo add project link
