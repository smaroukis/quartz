---
title: STM32CubeIDE - live expression viewer doesn't work for variables stored on the stack
date: 2024-02-09
description: Today I learned something about the STM32CubeIDE debugger
tags:
  - stm32
  - CubeIDE
  - using-software
slug: 
draft: false
math: false
---

When trying to use the live expression view to look at a variable, I noticed it wasn't appearing in the live expression view. I remembered that global variables and variables in main are stored at different places in memory and I thought that might be why. Turns out I was right. 

Apparently the live expression viewer doesn't work for variables stored on the stack. This should be added to the list of [[traps for young players]]. Luckily I have watched the course on [Modern Embedded Programming](https://notes.maroukis.net/200-Courses/221-Modern-Embedded/C221-L13-Startup+Code+Part-1+What+is+startup+code+and+how+the+CPU+gets+from+reset+to+main+%E2%9C%85) so I know that the uninitialized global variables are stored in the `.bss` section of ROM and copied to RAM at runtime.

See video demo below.

## Example Code

This code does NOT work for live expressions in STM32CubeIDE.
```c

int main(void)
{
	int counter; // will be stored in the stack 

    /* Loop forever */
	while(1) {
		counter ++;
	}
}
```

Instead, declare the variable outside of main:
```c
int counter; // will be stored in the .bss section of ROM (uninitialized), copied to RAM at runtime
// note in some DSPs the .bss section will NOT be zeroed out

int main(void)
{
    /* Loop forever */
	while(1) {
		counter ++;
	}
}

``` 
## Video

![](attachments/cubeIDE-live-expressions.mov)