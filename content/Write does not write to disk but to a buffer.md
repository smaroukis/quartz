---
title: Write does not write to disk but to a buffer
date: 2023-08-27
description: 
tags:
  - python
math: false
---


This is why in the mqtt-data-logger project the `__flush()` method is used every 2 seconds, it is like a "close" but for continuously writing

> [!ai] Writing vs Flushing
> The main difference between a write and a flush in file I/O is:
> 
> Write:
> - Writes data to the file buffer in memory
> - Data may not be written to actual disk yet
> - Faster because doesn't have to sync with disk
>
> Flush: 
> - Pushes buffered data from memory to disk
> - Ensures data is persisted to physical disk
> - Slower because requires disk sync
>
> In summary:
> - Write stores data in memory buffer
> - Flush commits buffer to actual disk
>
> When you write to a file, the data is stored in memory buffers that are faster to access, but not durable. The OS will eventually flush these buffers to disk.
> 
> But if power is lost before a flush, the data in buffers is lost. 
> 
> So flushing explicitly pushes buffers out to physical disk so data is persisted. This prevents data loss, but incurs disk sync overhead.
> 
> That's why this MQTT logger code flushes frequently - to avoid losing data. It pays the cost of slower disk sync to gain data durability.
> 
> So in high throughput logging:
> - Use writes for fast buffering 
> - Flush often to persist buffered data to disk
> 
> This gives both good performance from buffering and data reliability from frequent flushing.

