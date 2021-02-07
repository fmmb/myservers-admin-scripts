#!/usr/bin/python3
# -*- coding: utf-8 -*-
import string
import random
import smtplib
import sys

def id_generator(size=6, chars=string.ascii_lowercase + string.digits):
    return ''.join(random.choice(chars) for x in range(size))

print( id_generator() )
