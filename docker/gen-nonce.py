#!/bin/env python
import os
import base64
import sys
b = 32
if len(sys.argv) > 1:
    b = int(sys.argv[1])
key = base64.urlsafe_b64encode(os.urandom(b)).decode('utf-8')[:b]
print(key)
