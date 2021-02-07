#!/usr/bin/python3
# -*- coding: utf-8 -*-
import string
import random
import smtplib
import sys
import os
import getpass
# import Encode

from time import sleep
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Default values
# ------------------------------------------------------------------------------
opt = {}
opt['name'] = None
opt['email'] = None
opt['user'] = None
opt['pass'] = None

# Arguments
# ------------------------------------------------------------------------------

for arg in sys.argv[1:]:
    if arg == "-h":
        pass
    elif opt['email'] == None:
        opt['email'] = arg

if not opt['email']:
	print("Error, incorrect number of arguments")
	sys.exit(1)
if opt['email'].find("@") < 0:
	print("Error, Incorrect e-mail string")
	sys.exit(1)

subject = None
mensagem=[]
for line in sys.stdin:
   if subject is None:
      subject = line
   else:
      mensagem.append(line)
texto="".join(mensagem)

msg = MIMEMultipart('alternative')
# Utility functions
# ------------------------------------------------------------------------------

emailuser = "fmmb@iscte-iul.pt"
try:
    emailpass = os.environ['admin_email_pass']
except:
	emailpass = getpass.getpass()

#mailfrom  = "Fernando Batista <" + emailuser + ">"
#mailfrom  = "Fernando Batista <Fernando.Batista@iscte-iul.pt>"
mailfrom  = "Fernando.Batista@iscte-iul.pt"
mailto = ""

#mailto = unicode(opt['email'],'utf-8')
mailto = opt['email']

msg['Subject'] = subject
msg['From'] = mailfrom
msg['To'] = mailto
#		texto=unicode(texto,'utf-8')
#		print texto
part1 = MIMEText(texto,'plain','utf-8')
msg.attach(part1)

#		print unicode(texto,'utf-8')
# Send the message via local SMTP server.
s = smtplib.SMTP('smtp.office365.com', 587)
s.ehlo()
s.starttls()
s.login(emailuser, emailpass)
s.sendmail(mailfrom, mailto, msg.as_string())
s.quit()
sleep(1)
print ("Message sent to user %s (%s)"%(mailto, mailto))
sleep(1)
