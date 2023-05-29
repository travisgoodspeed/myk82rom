#!/usr/bin/env python3

# Dirt simple code to swap the byte order, because the internal MYK82
# ROM has no endianness but should be marked as big endian for
# compatibility with the EEPROM.

import sys
while word := sys.stdin.buffer.read(4):
    sys.stdout.buffer.write(bytes(reversed(word)))
