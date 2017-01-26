# MAX6675 Thermocouple Amp
# 
# use GPIO pin numbering for
# cs_pin (CS), clock_pin (SCK) & data_pin (SO)
#
# brian.muhumuza@gmail.com
# PiMaa Project
#
###################################

import sensor
import time
from lib.max6675 import MAX6675, MAX6675Error

class MAX6675(sensor.Sensor):
	requiredData = ["cs_pin","clock_pin","data_pin"]
	optionalData = []
	
	def __init__(self, data):
		self.sensorName = "MAX6675"
		self.valName = "Temperature"
		self.valUnit = "Celsius"
		self.valSymbol = "C"
		
		self.thermocouple = MAX6675(data['cs_pin'], data['clock_pin'], data['data_pin'], 'c')

	def getVal(self):
		try:
			value = self.thermocouple.get()
			return value
		except IOError:
		    return None

