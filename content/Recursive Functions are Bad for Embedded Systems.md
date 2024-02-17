---
title: Recursive Functions are Bad for Embedded Systems
date: 2023-08-26
description: 
tags:
  - embedded-systems
math: false
---

in [C221-L09-Modules Recursion and ARM Application Procedure Call Standard ✅](C221-L09-Modules%20Recursion%20and%20ARM%20Application%20Procedure%20Call%20Standard%20✅) I learned about the ARM Application Procedure Call Standard and that:

> Deep recursive functions should not be used in embedded systems since they use a lot of space on the stack, and we are limited in our stack space, instead try to use iterative versions of functions or lookup tables (18:00) in the video

This can be demonstrated at 15:17 in the video.

The youtube series is great for getting low level and understanding how machine instructions are executed by the CPU. 
