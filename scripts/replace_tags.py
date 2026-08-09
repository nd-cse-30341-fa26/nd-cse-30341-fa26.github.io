#!/usr/bin/env python3

import re
import sys

TAGS = (
    'primary',
    'success',
    'caution',
    'danger',
    'info',
    'warning',
    'special',
    'muted',
)

text = open(sys.argv[1]).read()

for tag in TAGS:
    text = re.sub(f'<{tag}>', f'<strong class="{tag}">', text, flags=re.MULTILINE)
    text = re.sub(f'</{tag}>', '</strong>', text, flags=re.MULTILINE)

print(text)
