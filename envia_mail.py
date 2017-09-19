#!/usr/bin/python
# -*- coding: utf-8 -*-
import string
import random
import smtplib
import sys
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
    elif opt['name'] == None:
        opt['name'] = arg
    elif opt['email'] == None:
        opt['email'] = arg
    elif opt['user'] == None:
        opt['user'] = arg
    elif opt['pass'] == None:
        opt['pass'] = arg

if not opt['pass']:
	print("Error, incorrect number of arguments")
	sys.exit(1)
if opt['email'].find("@") < 0:
	print("Error, Incorrect e-mail string")
	sys.exit(1)


# Utility functions
# ------------------------------------------------------------------------------

mailfrom  = "Fernando Batista <fmmb@iscte.pt>"
mailto = "" 

(username, nome, email, passwd) = (opt['user'], opt['name'], opt['email'], opt['pass'])
username = unicode(username, 'utf-8')
nome = unicode(nome,'utf-8')
mailto = unicode(email,'utf-8')
passwd = unicode(passwd,'utf-8')

texto = u"Caro(a) aluno(a) " + nome + u""",

Os seus dados de acesso ao tigre.iul.lab, servidor de Sistemas Operativos, são:

username: """ + username + u"""
password: """ + passwd + u"""

O acesso ao servidor será feito durante as aulas práticas. 
Fora das aulas práticas o acesso está restrito a utilizadores ligados à rede do ISCTE, 
quer através da EDUROAM dentro do campus do ISCTE-IUL, ou através de uma VPN.
Os alunos de SO podem usar uma VPN que funciona em Windows, OSX e Linux.
Consulte as instruções no e-learning, na secção "Material das aulas".

No seu primeiro acesso ao servidor deve mudar a sua password usando o comando "passwd".
Esse comando começa por lhe pedir a password que lhe foi agora enviada e só depois é que 
introduzirá a sua nova password. Note que a nova password terá de ser digitada duas vezes.
Exemplo:

passwd
Changing password for """ + username + u""".
(current) UNIX password:  (colocar a password que lhe foi enviada)
Enter new UNIX password:  
Retype new UNIX password: 

Qualquer problema ou dúvida contacte o docente Fernando Batista ou João Oliveira.
Obrigado.
"""
msg = MIMEMultipart('alternative')
msg['Subject'] = "Servidor de Sistemas Operativos: tigre.iul.lab"
msg['From'] = mailfrom
msg['To'] = mailto
#		texto=unicode(texto,'utf-8')
#		print texto
part1 = MIMEText(texto,'plain','utf-8')
msg.attach(part1)

#		print unicode(texto,'utf-8')
# Send the message via local SMTP server.
s = smtplib.SMTP('smtp.iscte.pt')
s.sendmail(mailfrom, mailto, msg.as_string())
s.quit()
print "Message sent to %s <%s>: user=%s"%(nome, mailto, username)
sleep(2)
