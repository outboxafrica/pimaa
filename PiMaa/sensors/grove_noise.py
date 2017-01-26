# Noise Level sensor
#
# brian.muhumuza@gmail.com
# PiMaa Project
#
###################################

import sensor
import time
from lib.GrovePi import grovepi

class GroveNoise(sensor.Sensor):
	requiredData = ["analog_port"]
	optionalData = []
	
	def __init__(self, data):
		self.sensorName = "LM2904DR"
		self.valName = "Noise Level"
		self.valSymbol = "??"
		self.valUnit = "Unknown"
			
		self.port = int(data['analog_port'])
		

	def getVal(self):
		try:
			value = grovepi.analogRead(self.port)
			return value
		except IOError:
		    return None
		    
