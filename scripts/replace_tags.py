#!/usr/bin/env python3

import re
import sys

TAGS = {
    'primary'   : 'primary',
    'success'   : 'success',
    'caution'   : 'caution',
    'danger'    : 'danger',
    'info'      : 'info',
    'warning'   : 'warning',
    'special'   : 'special',
    'muted'     : 'muted',
    'gold'      : 'gold',
    'comment'   : 'hljs-comment',
}

text = open(sys.argv[1]).read()

for tag, css_class in TAGS.items():
    text = re.sub(f'<{tag}>', f'<strong class="{css_class}">', text, flags=re.MULTILINE)
    text = re.sub(f'</{tag}>', '</strong>', text, flags=re.MULTILINE)

print(text, end='')
