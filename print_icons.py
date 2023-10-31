#!/usr/bin/env python3

'''
check_icons.py
'''

import os
from collections import namedtuple

IconInfo = namedtuple('IconInfo', ['name', 'code'])
FontInfo = namedtuple('FontInfo', ['name', 'num_entries'])

def banner(text, width=80):
    ''' Just a banner
    '''
    title = ' '.join(text.upper()).center(width)
    print('#' * width)
    print('%s' % title)
    print('#' * width)

def icons_info(line):
    ''' Generator over icons in line
    '''
    icons = line.split(';')
    for icon in icons[:-1]:
        yield IconInfo(*icon.split(':'))

def fonts_info(mapping):
    ''' Generator over fonts and their icons
    '''
    for line in mapping:
        if line.startswith('#'):
            font_info = FontInfo(*line[1:].split(':'))
            continue
        yield font_info, icons_info(line)

def main():
    ''' main
    '''
    mapping = open('./build/mapping.txt', 'r')
    columns = int(os.popen('stty size', 'r').read().split()[1])
    for font_info, icons in fonts_info(mapping):
        banner(font_info.name, width=columns)
        for icon in icons:
            print('%s  ' % chr(int(icon.code, 16)), end='')
        print('\n' * 3)

if __name__ == '__main__':
    main()