---
title: Keeping Serial Device Connection Open in Python
date: 2023-10-30
description: 
tags:
  - python
slug: 
draft: false
math: false
---

Typically we use the `with` context manager to open and close e.g. a serial connection.

==TODO== need to go deeper on the underlying code how they are closed

For example
```python
settings = {"port": "/dev/ttyUSB0", "baudrate": 57600}

with serial.Serial(**settings) as ser:
	gps = adafruit_gps.GPS(ser, debug=False) # using pyserial
	# do things with the gps instance
```

But in the case where you want to later loop through the serial objects, like mine, we need to handle the connection ourselves. Digging through the adafruit GPS docs, and then the `busio` docs, since the first argument to the `.GPS` initializer is a `uart` device as defined there, I found the correct way to close the serial connection is the `.close()` method of the `uart` instance, which in the case of `adafruit_gps` is stored as `_uart`.

From https://docs.circuitpython.org/projects/gps/en/latest/_modules/adafruit_gps.html#GPS
![](attachments/Screenshot%202023-10-30%20at%203.38.59%20PM.png)

So the final code, to loop through various GPS devices on different serial ports, without having to open/close the connection every time is:


```python

# loop and create devices
devices = [
    {
        "name": "Device1",
        "port_settings": {"port": "/dev/ttyUSB0", "baudrate": BAUD_RATE}
    },
    {
         "name": "Device2",
         "port_settings": {"port": "/dev/ttyUSB1", "baudrate": BAUD_RATE}
    }
]

for device in devices:
	settings = device["port_settings"]
	ser = serial.Serial(**settings) 
	gps = adafruit_gps.GPS(ser)# <-- no longer using the context handler
	device["gps"] = gps # add gps object to dict, serial port stays open

try: 
	while True:
		for device in devices:
			device["gps"].update()
		# loop over devices and do things, e.g. printing out gps data
except KeyboardInterrupt:
	sys.exit(0)

finally: 
	for device in devices:
		device["gps"]._uart.close() # <-- handle closing the serial port

```


## Resources
- https://docs.circuitpython.org/en/latest/shared-bindings/busio/index.html#busio.UART
- https://docs.circuitpython.org/en/latest/docs/design_guide.html#lifetime-and-contextmanagers

> deinitializing the hardware using a with statement will ensure hardware isn’t enabled longer than needed.


Note - we could also use the `deinit()` class of `bus.io UART` but I found that it didn't work