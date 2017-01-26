# There are 5 gas sensor models
# MQ2 - Combustible Gas, Smoke, Carbon Monoxide
# MQ3 - Alcohol Vapor
# MQ5 - LPG, Natural Gas, Town Gas
# MQ9 - Carbon Monoxide, Coal Gas, Liquefied Gas
# 02 - Oxygen
#
# brian.muhumuza@gmail.com
# PiMaa Project
#
###################################

import sensor
import time
from lib.GrovePi import grovepi

class GroveGas(sensor.Sensor):
	requiredData = ["analog_port","sensor_model"]
	optionalData = []
	
	def __init__(self, data):
		self.sensorName = data['sensor_model']
		self.valName = "Gas Concentration"
		self.valSymbol = "ppm"
		self.valUnit = "Particles Per Million"
			
		self.port = int(data['analog_port'])
		

	def getVal(self):
		try:
			value = grovepi.analogRead(self.port)
			return value
		except IOError:
		    return None
		    
