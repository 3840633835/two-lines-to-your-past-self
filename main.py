#!/usr/bin/env python3
"""Two Lines to Your Past Self - entry writer.

Writes the two-line entry to /output/entry.txt.

Line 1 warns the past self about one specific moment, in a single
sentence. Line 2 says in one sentence why that moment mattered and
what changed because of it.

The file is exactly two lines, newline-separated, with no trailing
newline: 136 bytes, inside the kit gate of 1-280 characters.
"""

import os

LINE_1 = "Don't tattoo her name on your arm the day you turn eighteen."
LINE_2 = "The ink fades but never leaves, and every new love reads the old one first."

ENTRY = LINE_1 + "\n" + LINE_2


def main() -> None:
    os.makedirs("/output", exist_ok=True)
    path = "/output/entry.txt"
    with open(path, "w", encoding="utf-8", newline="") as f:
        f.write(ENTRY)
    try:
        os.chmod(path, 0o644)
    except OSError:
        pass


if __name__ == "__main__":
    main()
