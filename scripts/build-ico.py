#!/usr/bin/env python3
"""Pack PNG files into a single multi-resolution ICO file.

ICO entries use PNG compression (Vista+ format) so large resolutions stay small.

Usage: build-ico.py output.ico input1.png [input2.png ...]
"""

import struct
import sys


def build_ico(png_paths, output_path):
    count = len(png_paths)
    if count == 0:
        raise SystemExit("Error: no PNG inputs given")

    header = struct.pack("<HHH", 0, 1, count)
    offset = 6 + 16 * count
    entries = b""
    payload = b""

    for png_path in png_paths:
        with open(png_path, "rb") as f:
            png_data = f.read()
        if png_data[:8] != b"\x89PNG\r\n\x1a\n":
            raise SystemExit(f"Error: not a PNG file: {png_path}")

        # Dimensions come from the PNG IHDR chunk (width/height at offsets 16/20)
        width, height = struct.unpack(">II", png_data[16:24])
        # ICO stores 256 as 0 in the width/height bytes
        w_byte = 0 if width >= 256 else width
        h_byte = 0 if height >= 256 else height
        size = len(png_data)

        entries += struct.pack(
            "<BBBBHHII", w_byte, h_byte, 0, 0, 1, 32, size, offset
        )
        payload += png_data
        offset += size

    with open(output_path, "wb") as f:
        f.write(header + entries + payload)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        raise SystemExit(__doc__)
    build_ico(sys.argv[2:], sys.argv[1])
