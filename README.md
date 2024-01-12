## Embedded Controller Module for Linux Kernel

Fork from https://github.com/YADRO-KNS/fabric-ec.git

The sources of the multithreaded linux kernel module, which allows user space
applications to send data to STM32 microcontroller, which is connected to the
host via USB. This MCU uses the CAN bus to communicate with the equipment.

```text
+---------------------------------------------------------------+
|   +----------------------------+-+                            |
|   |   +-------------+  +-----+ |=|                            |
|   |   |             |  |     | |=|                            |
|   |   |             |  |     | |=|                            |    
|   |   |     CPU     |  | MEM | |=|                            |
|   |   |             |  |     | |o|                            |
|   |   |             |  |     | |=|                            |
|   |   +-------------+  +-----+ |=|         Mini-PCIe          |
|   |         +-------+          |=|       +-+---------+        |
|   |         |       |          |=|       |=| +-----+ O        |
|   |         |  PCH  |          |=|       |=| | EC/ | |        |
|   |         |       |          |=|<-USB->|=| | MCU | |-----> CAN0
|   |         +-------+    COME  |=|       |=| +-----+ |-----> CAN1
|   +----------------------------+-+       +-+---------+        |
|   Mini-ITX motherboard                                        |        
+---------------------------------------------------------------+
```

/dev/mcu0 for writing/reading. Management using ioctl().

```text
+-------+  +-------+  +-------+       +-------+
| App 0 |  | App 1 |  | App 2 | * * * | App X |
+-------+  +-------+  +-------+       +-------+
    |          |          |               |
    V          V          V               V
+---------------------------------------------+
|                 /dev/mcu0                   |
+---------------------------------------------+
                      |
                      V
+---------------------------------------------+
|                  ecdrv.ko                   |
+---------------------------------------------+
                      |
                      V
+---------------------------------------------+
|                    MCU                      |
+---------------------------------------------+
```

`statistics` in sysfs show the statistics of CAN packets.
`hreset` resets the MCU device.

```bash
(bash)$ make
(bash)$ make install
```

```bash
(bash)$ make remove
(bash)$ make clean
```
