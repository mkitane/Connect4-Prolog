#!/usr/bin/python

import os
import json
import subprocess
import re



if __name__ == "__main__":

	finalData = {
		'IA1' : 0, 
		'IA2' :0, 
		'draw' :0, 
	}

	for x in range(0,100):
		regexIA1Won = re.compile('.*IA1.*', re.DOTALL)
		regexIA2Won = re.compile('.*IA2.*', re.DOTALL)
		regexDraw = re.compile('.*draw.*', re.DOTALL)


		output = subprocess.check_output("./runAuto", stderr=subprocess.STDOUT, shell=True)
		output = output[20:]


		if regexIA1Won.match(output) : 
			finalData['IA1'] = finalData['IA1']+1
		elif regexIA2Won.match(output) : 
			finalData['IA2'] = finalData['IA2']+1
		elif regexDraw.match(output) : 
			finalData['draw'] = finalData['draw']+1


	print 'Finaly Finished'
	print finalData