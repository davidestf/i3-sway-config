#!/usr/bin/env python3
import subprocess

# Get monitor info using xrandr
output = subprocess.check_output(["xrandr"]).decode()
output = [line for line in output.split("\n") if " connected" in line]

mons = {}
for line in output:
    parts = line.split()
    name = parts[0]
    
    # Find the resolution in the output
    for part in parts:
        if 'x' in part and part[0].isdigit():
            # Split resolution and position
            res = part.split('+')[0]  # Take only the resolution part before '+'
            w, h = map(int, res.split('x'))
            mons[name] = [w, h]
            break

LAPTOP = "eDP-1"
EXTERNAL = "DP-3-1"

# Generate and execute xrandr commands directly
commands = [
    f"xrandr --output {LAPTOP} --primary --mode {mons[LAPTOP][0]}x{mons[LAPTOP][1]} --pos 0x{mons[EXTERNAL][1]}",
    f"xrandr --output {EXTERNAL} --mode {mons[EXTERNAL][0]}x{mons[EXTERNAL][1]} --pos 0x0"
]

for cmd in commands:
    subprocess.run(cmd.split())
