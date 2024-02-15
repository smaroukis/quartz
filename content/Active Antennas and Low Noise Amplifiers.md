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

For example, here is the design of hackRF LNA and dc biasing circuit with a decoupling capacitor. ==TODO==


> The Notecard design allows the option of a passive or active GPS antenna, and can supply a 3.3V - 4.0V bias voltage to power an active antenna's LNA. If an active antenna requires a different voltage, the board designer can inject whatever voltage they require into the antenna's coax by feeding it to the `VACT_GPS_IN` pin. (via [docs](https://dev.blues.io/datasheets/notecard-datasheet/note-wbglw/#antenna-requirements))

But note, for the boards that already include an amplification stage directly from the antenna, called a Low Noise Amplifier (LNA), the docs state that **an active antenna cannot be used**. This is likely because they have no way to bypass the LNA, and the resulting doubly-amplified signal would clip above what's expected, or worse, damage other parts of the board.

On the flip side, when we have the DC bias feeding into the antenna, if we have a passive antenna this could result in a direct short to ??? ==TODO develop further the affect of feeding a DC bias to a passive antenna==

==TODO add LNA closeup==


Showing the active GPS switch on the Notecarrier Pi
![](attachments/IMG_5659%201.jpg)