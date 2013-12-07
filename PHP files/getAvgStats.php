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
    $st = $dbh->query('SELECT COALESCE(AVG(offensive_rebounds), 0) AS ORPG, COALESCE(AVG(defensive_rebounds), 0) AS DRPG, COALESCE(AVG(steals), 0) AS SPG, 
                       COALESCE(AVG(assists), 0) AS APG, COALESCE(AVG(personal_fouls), 0) AS FPG, COALESCE(AVG(minutes), 0) as MPG,
                       COALESCE(SUM(cast(three_point_makes as float))/NULLIF(SUM(three_point_attempts), 0), 0) AS three_percent,
                       COALESCE(SUM(cast(two_point_makes as float))/NULLIF(SUM(two_point_attempts), 0), 0) AS two_percent,
                       COALESCE(SUM(cast(free_throw_makes as float))/NULLIF(SUM(free_throw_attempts), 0), 0) AS free_percent,
                       COALESCE((SUM(cast(two_point_makes as float)) * 2 + SUM(three_point_makes) * 3)/NULLIF(COUNT(*), 0), 0) AS avg_points
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
    