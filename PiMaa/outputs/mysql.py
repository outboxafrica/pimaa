##################################################
# the table name is optional - default is sensors
#
# table should have the following fields:
# 
# sensor, description, units, units_symbol, value & timestamp
#
# CREATE TABLE `sensors` ( 
#	`node_id` VARCHAR(20) NOT NULL , 
# 	`sensor` VARCHAR(20) NOT NULL , 
# 	`description` VARCHAR(50) NOT NULL , 
# 	`units` VARCHAR(20) NOT NULL , 
# 	`units_symbol` VARCHAR(10) NOT NULL , 
# 	`value` FLOAT NOT NULL , 
# 	`timestamp` DATETIME NOT NULL , 
#	INDEX (`node_id`), 
# 	INDEX (`sensor`), 
# 	INDEX (`timestamp`)
# ) ENGINE = InnoDB;
#
####################################################
import output
import datetime, MySQLdb

class MySQLOutput(output.Output):
	requiredData = ['host','database','username','password']
	optionalData = ['table']
	
	def __init__(self, data):
		if 'table' in data:
			self.table = data['table']
		else:
			self.table = 'sensors'
		
		self.db = MySQLdb.connect(host=data['host'], user=data['username'], passwd=data['password'], db=data['database'])
		self.cursor = self.db.cursor()
		self.sql = "INSERT INTO `%s` (node_id,sensor,description,units,units_symbol,value,timestamp) VALUES ('%s','%s','%s','%s','%s','%s','%s')"
		
	def outputData(self, output_data):
		now = datetime.datetime.now()
		
		for O in output_data:
			try:
				value = float(O['value'])
			except:
				# invalid value, ignore
				continue
			
			sql = self.sql % (self.table, O['node_id'], O['sensor'], O['name'], O['unit'], O['symbol'], value, now)
			
			try:
				self.cursor.execute(sql)
			except:
				print "ERROR: failed to save readings for %s"%O['sensor']

		self.db.commit()
		return True
