---
title: itoa not included in macos gcc following POSIX and ANSI standards
date: 2024/05-08
description: 
tags: 
slug: 
draft: false
math: false
---

Although the Arduino GCC implementation of `<stdlib.h>` includes `itoa()`, this is as an extension and not the standard for most compiler implementations following the ANSI / POSIX C standard library implementations.

Reasons include different ways of defining the function signature (returning the string versus taking a buffer as input), lack of error handling and potential buffer overflow.

Alternatives include `sprintf`/`snprintf` or `std::to_string` (C++11 and later).

