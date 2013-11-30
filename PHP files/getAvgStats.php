<?php
  $xml = new SimpleXMLElement('<xml/>');
  try {
    // Including connection info (including database password) from outside
    // the public HTML directory means it is not exposed by the web server,
    // so it is safer than putting it directly in php code:
    include("/etc/php5/pdo-datasource.php");
    $dbh = new PDO($PDO_CONN, $PDO_USER, $PDO_PASSWORD);
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  } catch (PDOException $e) {
    print "Error connecting to the database: " . $e->getMessage() . "<br/>";
    die();
  }
  
  try {
    $st = $dbh->query('SELECT AVG(offensive_rebounds) AS ORPG, AVG(defensive_rebounds) AS DRPG, AVG(steals) AS SPG, 
                       AVG(assists) AS APG, AVG(personal_fouls) AS FPG, AVG(minutes) as MPG,
                       SUM(cast(three_point_makes as float))/SUM(three_point_attempts) AS three_percent,
                       SUM(cast(two_point_makes as float))/SUM(two_point_attempts) AS two_percent,
                       SUM(cast(free_throw_makes as float))/SUM(free_throw_attempts) AS free_percent,
                       (SUM(cast(two_point_makes as float)) * 2 + SUM(three_point_makes) * 3)/COUNT(*) AS avg_points
                       FROM GameStats
                       WHERE player_id = \'' . $_GET["player_id"] . '\' AND minutes <> 0');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('ORPG', $myrow['orpg']);
        $result->addAttribute('DRPG', $myrow['drpg']);
        $result->addAttribute('SPG', $myrow['spg']);
        $result->addAttribute('APG', $myrow['apg']);
        $result->addAttribute('PFPG', $myrow['fpg']);
        $result->addAttribute('MPG', $myrow['mpg']);
        $result->addAttribute('three_percent', $myrow['three_percent']);
        $result->addAttribute('two_percent', $myrow['two_percent']);
        $result->addAttribute('free_percent', $myrow['free_percent']);
        $result->addAttribute('avg_points', $myrow['avg_points']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There is no drinker in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    