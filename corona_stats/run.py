import sys
import PyPDF2
import pdfminer
import logging
import requests
import os
import os.path
import shutil
import urllib
import urllib.request
from datetime import date, timedelta
import re
import wget

today = date.today()
url = 'http://covid19.barnim.de/fileadmin/portal/corona/Lagebericht/2021/'
url_notice = 'http://covid19.barnim.de/fileadmin/portal/corona/Lagebericht/2021/{0}_Lagebericht_Corona-Homepage.pdf'.format(today)
r = requests.get(url, allow_redirects=True)
pdf = open('{0}_Lagebericht_Corona-Homepage.pdf'.format(today), "r")

print('Download Link: {0}'.format(url_notice))

print('Downloading ...')
if os.path.isfile('{0}_Lagebericht_Corona-Homepage.pdf'.format(today)):
    print("File exist on local drive")
else:
        open('{0}_Lagebericht_Corona-Homepage.pdf'.format(today), 'wb').write(r.content)

print('opeing ...')
print(pdf.read())
