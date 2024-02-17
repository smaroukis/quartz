---
title: Active Antennas and Low Noise Amplifiers
date: 2023-10-26
description: 
tags:
  - electronics
slug: active-antennas
draft: false
math: true
---

When messing around with a blues.io notecard and an external GPS antenna, I was getting 0/0 SNR db ratio on the readout from the `card.location` request. Obviously it means my antenna isn't connected, or something is wrong at the hardware level.

The fact was I had attached an active antenna and hadn't set up the notecard to provide the DC bias that the active antenna needs.

> The Notecard design allows the option of a passive or active GPS antenna, and can supply a 3.3V - 4.0V bias voltage to power an active antenna's LNA. If an active antenna requires a different voltage, the board designer can inject whatever voltage they require into the antenna's coax by feeding it to the `VACT_GPS_IN` pin. (via [docs](https://dev.blues.io/datasheets/notecard-datasheet/note-wbglw/#antenna-requirements))

But note, for the boards that already include an amplification stage directly from the antenna, called a Low Noise Amplifier (LNA), the docs state that **an active antenna cannot be used**. This is likely because they have no way to bypass the on-board LNA, and the resulting doubly-amplified signal would clip above what's expected, or worse, damage other parts of the board.

So at least for Blues.io devices, notecarriers/notecards with an onboard LNA cannot use an active antenna, and for the ones without the onboard LNA we can toggle the the `Active GPS` DIP switch. 

Showing the active GPS switch on the Notecarrier Pi
![|300](attachments/IMG_5659%201.jpg)


Schematic - the `VACT_GPS_OUT` line will be connected to the coax middle pin, proving a DC bias for the active antenna LNA. 
>  https://github.com/blues/note-hardware/blob/master/Notecarrier-Pi/v1.1/Notecarrier-Pi%20schematic%20v1.1.pdf
![](attachments/Screenshot%202024-02-15%20at%204.56.39%20PM.png)


From the hackRF front end, we can see a 100nF DC blocking cap and a biasing circuit. The biasing circuit is to provide the DC bias to the active antenna (with control by the MCU) and then the capacitor removes this bias for the rest of the RF front end.  
> https://github.com/rad1o/hardware/blob/master/datasheets/else/hackrf-one-schematic.pdf

![](attachments/Screenshot%202024-02-15%20at%205.02.20%20PM.png)



## References
- https://dev.blues.io/datasheets/notecarrier-datasheet/notecarrier-a/#active-gps-onboard-antenna
- https://dev.blues.io/datasheets/notecard-datasheet/note-wbglw/#active-gps 