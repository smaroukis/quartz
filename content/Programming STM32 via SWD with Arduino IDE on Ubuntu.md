---
title: Programming STM32 via SWD with Arduino IDE on Ubuntu
date: 2025-02-16
description: Oh Linux. I just wanted to quickly program an STM32 chip over SWD with the Arduino IDE for a blinky test but ...
tags:
  - arduino
  - stm32
  - embedded-systems
slug: stm32-arduino-swd
draft: false
math: false
---

Oh Linux. I just wanted to quickly program an STM32 chip over SWD with the Arduino IDE for a blinky test but ...

Issue #1 is that the AppImage runs in an isolated environment and does not load the `.bashrc` thus it does not have access to the STM32CubeProgrammer executable. 

Issue #2 is the sandboxing issue (something about deprecation of unprivileged kernel namespaces affecting Electron applications)

These can both be fixed in the desktop entry by setting the environment variables when we run the AppImage: 
```
Exec=env PATH=$PATH:/path/to/stm32cubeprogrammer /path/to/arduino-ide_2.X.X_Linux_64bit.AppImage --no-sandbox
```

But somehow that didn't work for me 🤷, so a workaround is to execute the AppImage from within a `bash` session with the added `--no-sandbox` flag. Note the path to the STM32CubeProgrammer binary was already added in my `~/.bashrc`.

## Full Steps (Ubuntu >= 22.04)

1 -  Download [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) 

2 - Add the executable to the PATH
Add the STM32CubeProgrammer executable to `~/.bashrc` if it is installed in a place not visible by the default `PATH`, e.g. in `~/.bashrc` add:
`export PATH=/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH`

Verify executable visibility with `which STM32_Programmer_CLI`

See this [stm32duino page](https://github.com/stm32duino/Arduino_Core_STM32/wiki/Upload-methods#requirement) for more.

3 - Install Arduino IDE 2 AppImage

4 - Make sure FUSE is installed to run the AppImage
```
sudo add-apt-repository universe
sudo apt install libfuse2
```

5 - (Skipped since I was using SWD) Add rule to `/etc/udev/rules.d/99-arduino.rules` (see [instructions](https://docs.arduino.cc/software/ide-v2/tutorials/getting-started/ide-v2-downloading-and-installing/#linux)

6 - Arduino IDE - Add the Additional Boards Managers URL for the STM32 cores package 
See stm32duino [Getting Started](https://github.com/stm32duino/Arduino_Core_STM32/wiki/Getting-Started#add-stm32-boards-support-to-arduino).
File > Preferences > Additional Boards Managers URLs = (Add the URL from the link above)

7 - Arduino IDE - Install the board package
Boards Manager > STM32 MCU based boards by STMicroelectronics

8 - Arduino IDE - Select board under Board menu

9 - (Optional depending on flashing method) Arduino IDE - Select port (note I was using SWD via the STLink v2 so I didn't need to select a virtual COM port). 

10 - ~~Setup the AppImage desktop entry  (typ. in `~/.local/share/applications/Arduino-ide.desktop`) with e.g. `Exec=/path/to/arduino-ide --no-sandbox`~~ Run the AppImage directly from a `bash` user terminal so that it has access to the CubeProgrammer. Note I needed. the `--no-sandbox` flag as there are still issues with sandboxing. 



