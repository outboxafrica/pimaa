<?php
/**********************************
* draw graph for sensor
* 
* Author: bmuhumuza@syntechug.com
* PiMaa Project
***********************************/

$GRAPH_COLOURS = array('#ACC26D','#181dff','#ff6600','#ff6600','#ff6600','#ff6600','#ff6600');
$node = null;
$node_details = null;

if (isset($_REQUEST['node']))
{
	$node = $_REQUEST['node'];
}

$db_conn = mysqli_connect("localhost", "pimaa", "pimaa", "pimaa") or die("error connecting to db: ".mysql_error());
$NODES_QUERY = "SELECT * FROM `nodes` ORDER BY id";
$nodes = mysqli_query($db_conn, $NODES_QUERY);

$node_list = array();

$counter = 0;
while($N = mysqli_fetch_assoc($nodes))
{
	$counter += 1;
	if ($counter == 1 && ! $node)
	{
		$node = $N['node_id'];
		$node_details = $N;
	}
	elseif($node && ! $node_details && $node == $N['node_id'])
	{
		$node_details = $N;
	}
	$node_list[] = $N;
}

$node_sensors = array();

if ($node)
{
	$NODE_SENSORS_SQL = "SELECT DISTINCT sensor, description, units_symbol FROM `sensors` WHERE node_id='{$node}'";
	$sensors = mysqli_query($db_conn, $NODE_SENSORS_SQL);
	
	while($S = mysqli_fetch_assoc($sensors))
	{
		$node_sensors[$S['sensor'].$S['description']] = $S;
	}
}



?>
<html>
<head>
<script type="text/javascript" src="Chart.bundle.min.js"></script>
</head>
<body>
<table style="width:100%;">
<tr><td><?php if ($node):?><h3>Node: <?=$node?></h3><b>Location:</b> <?=$node_details['location']?><br><b>GPS:</b> <?=$node_details['gps_location']?><?php endif;?></td>
<td style="text-align:right;">
<form method="post">
<label for="node"> Select Node</label> <select name="node" id="node">
<?php 
	foreach ($node_list as &$N){
		if ($node && $node == $N['node_id'])
		{
			echo '<option value="'.$N['node_id'].'" selected="selected">'.$N['node_id'].' ('.$N['location'].')</option>';
		}
		else
		{
			echo '<option value="'.$N['node_id'].'>'.$N['node_id'].' ('.$N['node_location'].')</option>';
		}
	}
?>
</select>
<input type="submit" value="Change To Selected Node" />
</form>
</td></tr>
</table>
<?php if ($node):?>
	<canvas id="tempChart" width="400" height="180"></canvas>

	<script>
	var ctx = document.getElementById('tempChart').getContext('2d');

	var sensorData = {
		labels : ["0"],
		datasets : [
			<?php
				$counter = 0;
				foreach ($node_sensors as $key => &$S)
				{
					echo '{';
					echo 'label: "'.$S['description'].' ('.$S['units_symbol'].')",';
					echo 'fill: false,';
					echo 'borderColor : "'.$GRAPH_COLOURS[$counter].'",';
					echo 'borderWidth: 2,';
					echo 'data : [0]';
					echo '},';
					$counter += 1;
				}
			?>
		]
	};

	dataSetOrder = [
		<?php
			foreach ($node_sensors as $key => &$S)
			{
				echo "'{$key}',";
			}
		?>
	];
	var maxDataPoints = 10;

	var tempChart = new Chart(ctx, {type: 'line', data: sensorData});

	setInterval(function(){

		var jsonObject = {};
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "pimaa.sensor.data.php?node=<?=$node?>", true);
		xhr.onreadystatechange = function ()
		{
			if (xhr.readyState == 4 && xhr.status == 200)
			{
				jsonObject = JSON.parse(xhr.responseText);

				for (var i = 0; i < dataSetOrder.length; i++)
				{
					if (i == 0)
					{
						sensorData.labels.push(jsonObject[dataSetOrder[i]].timestamp);
					
						if (sensorData.labels.length >= maxDataPoints)
						{
							sensorData.labels.splice(0, 1);
						}
					}
				
					if (dataSetOrder[i] in jsonObject)
					{
						sensorData.datasets[i].data.push(jsonObject[dataSetOrder[i]].value);
					
						if (sensorData.datasets[i].data.length >= maxDataPoints)
						{
							sensorData.datasets[i].data.splice(0, 1);
						}
					}
				}
				tempChart.update();
			}
		}
		xhr.send(null);
	}, 5000);
	</script>
<?php endif;?>

</body>
</html>

