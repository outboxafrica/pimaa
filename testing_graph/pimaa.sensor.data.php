<?php
/**********************************
* get sensor data for a given node
* 
* Author: bmuhumuza@syntechug.com
* PiMaa Project
***********************************/

if (isset($_REQUEST['node']))
{
	$node = $_REQUEST['node'];
}
else
{
	print json_encode(array());
	return;
}

$db_conn = mysqli_connect("localhost", "pimaa", "pimaa", "pimaa") or die("error connecting to db: ".mysql_error());
$SENSORS_QUERY = "SELECT DISTINCT sensor, description FROM `sensors` WHERE node_id='{$node}'";
$sensors = mysqli_query($db_conn, $SENSORS_QUERY);

$sensor_readings = array();

while($S = mysqli_fetch_assoc($sensors))
{
	$LATEST_READING_QUERY = "SELECT * FROM `sensors` WHERE node_id='{$node}' AND sensor='{$S['sensor']}' AND description='{$S['description']}' ORDER BY timestamp DESC LIMIT 1";
	$latest_reading = mysqli_query($db_conn, $LATEST_READING_QUERY);
	$reading = null;
	
	while($R = mysqli_fetch_assoc($latest_reading))
	{
		$reading = $R;
		break;
	}
	
	$sensor_readings[$S['sensor'].$S['description']] = $reading;
}

print json_encode($sensor_readings);


?>
