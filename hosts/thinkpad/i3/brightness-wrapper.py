#!/usr/bin/env python3
import json
import subprocess
import sys

def brightness_percent():
    # brightnessctl -m gives: device,subsystem,???,current,max,percent
    out = run(["brightnessctl", "-m"], timeout=0.25).strip()
    if not out:
        return None
    # percent is last field like "42%"
    try:
        pct = out.split(",")[-1].strip()
        if pct.endswith("%"):
            return int(pct[:-1])
    except Exception:
        pass
    return None

def brightness_block():
    pct = brightness_percent()
    if pct is None:
        return None
    return {
        "name": "brightness",
        "full_text": f" {pct}%",
        "separator": False,
        "separator_block_width": 12,
    }
