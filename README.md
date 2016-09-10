# ThrustMeter
An thrustmeter for measuring thrust, power, efficiency of RC motors, propellers, ESC's.

Grams per watt (g/W) is calculated based on voltage and current, and a precise thrust measurement.
Serial data is output for collection/plotting by DataExplorer http://www.nongnu.org/dataexplorer/  - the xml is included in "dataexplorer" directory.

To be compiled in Arduino, usually for "Leonardo" board.
Looks like: https://www.youtube.com/watch?v=S2vaC5SftQc

The weight-cell is vertically mounted thru the center hole of the sled:
https://github.com/AndKe/ThrustMeter/blob/master/mount/Thrustmeter-assembled%20view.png
This design allow plenty of vibration dampening material(s) between sled and weight cell, giving much better thrust data.

# Extras:
The folder "mount" contains OpenSCAD files for 3D printed testbench.
There will be a description of the hardware and connections (which is now kind of self-explained in source ?)

# License  GNU GPL
I'll gladly accept pull requests with improvenets.
