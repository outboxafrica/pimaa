# DHT11 is a blue colored sensor. 
#
# brian.muhumuza@gmail.com
# PiMaa Project
#
###################################

import sensor
import time
from lib.GrovePi import grovepi

class GroveDHT11(sensor.Sensor):
	requiredData = ["measurement","digital_port"]
	optionalData = []
	
	def __init__(self, data):
		self.sensorName = "DHT11"
		
		if 'temp' in data['measurement'].lower():
			self.measurement = 'temperature'
			self.valName = "Temperature"
			self.valSymbol = "C"
			self.valUnit = "Celsius"
		else:
			self.measurement = 'humidity'
			self.valName = "Relative Humidity"
			self.valSymbol = "%"
			self.valUnit = "% Relative Humidity"
			
		self.port = int(data['digital_port'])
		

	def getVal(self):
		try:
			# The first parameter is the port, the second parameter is the type of sensor.
			# blue = 0, white = 1
			[temp, humidity] = grovepi.dht(self.port, 0)
			
			if self.measurement == 'temperature':
				return temp
			else:
				return humidity
		except IOError:
		    return None
		    
