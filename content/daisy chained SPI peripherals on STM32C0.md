---
title: daisy chained SPI peripherals on STM32C0
date: 2024-05-13
description: 
tags:
  - electronics
  - embedded-systems
  - stm32
slug: 
draft: true
math: false
---

It should be possible to implement a daisy-chainable data-forwarding shift-register-like SPI setup with an STM32 MCU using DMA and the SPI peripheral, but reading some notes online makes it seem like the lower end MCUs may not have the SPI or DMA hardware needed (the devils in the details and I haven't gone there).

With two separate DMA channels, on for SPI Rx and one for SPI Tx, each pointing to the same ring buffer but with an offset, we should be able to use one DMA channel/stream to transfer the received SPI data into the SRAM/buffer and another DMA channel/stream to move the to-be-transmitted data from SRAM to the SPI Output data register. 

If we get the timing right we can implement a Serial In and Serial Out shift register with no CPU interaction. 

Why could this be useful? It would allow us to cascade MCUs to implement something similar to the APA102 RGB LED driver chip which are connected daisy-chain style (although the implementation is a bit different). 

![](attachments/Screenshot%202024-04-30%20at%204.48.43%20PM.png)
> [source](https://www.ti.com/lit/an/slvae25a/slvae25a.pdf?ts=1714440217157) - shows an example SPI frame for daisy chaining, including header bytes, address bytes, and data bytes with statuses returned by the peripherals ; also see [analog app note](https://www.analog.com/en/resources/technical-articles/daisychaining-spi-devices.html)

![](attachments/Screenshot%202024-04-30%20at%205.18.40%20PM.png)
> https://www.analog.com/en/resources/technical-articles/daisychaining-spi-devices.html

But users on the STM32 forum were saying out
