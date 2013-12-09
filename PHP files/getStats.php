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
    $st = $dbh->query('SELECT COALESCE(AVG(offensive_rebounds), 0) AS avg_offense_rebounds, COALESCE(SUM(offensive_rebounds), 0) AS total_offense_rebounds,
                        COALESCE(AVG(defensive_rebounds), 0) AS avg_def_rebounds, COALESCE(SUM(defensive_rebounds), 0) AS total_def_rebounds, 
                        COALESCE(AVG(steals), 0) AS avg_steals, COALESCE(SUM(steals), 0) AS total_steals, 
                        COALESCE(AVG(assists), 0) AS avg_assists, COALESCE(SUM(assists), 0) AS total_assists, 
                        COALESCE(AVG(personal_fouls), 0) AS avg_fouls, COALESCE(SUM(personal_fouls), 0) AS total_fouls,
                        COALESCE(AVG(minutes), 0) as avg_minutes, COALESCE(SUM(minutes), 0) as total_minutes,
                        COALESCE(SUM(cast(three_point_makes as float))/NULLIF(SUM(three_point_attempts), 0), 0) AS three_percent,
                        COALESCE(SUM(three_point_makes) * 3, 0) AS three_points,
                        COALESCE(SUM(cast(two_point_makes as float))/NULLIF(SUM(two_point_attempts), 0), 0) AS two_percent,
                        COALESCE(SUM(two_point_makes) * 2, 0) AS two_points,
                        COALESCE(SUM(cast(free_throw_makes as float))/NULLIF(SUM(free_throw_attempts), 0), 0) AS free_percent,
                        COALESCE(SUM(free_throw_makes), 0) AS free_points,
                        COALESCE((SUM(cast(two_point_makes as float)) * 2 + SUM(cast(three_point_makes as float)) * 3 + SUM(cast(free_throw_makes as float)))/NULLIF(COUNT(*), 0), 0) AS avg_points,
                        COALESCE(SUM(two_point_makes) * 2 + SUM(three_point_makes) * 3 + SUM(free_throw_makes), 0) AS total_points
                       FROM GameStats
                       WHERE player_id = \'' . $_GET["player_id"] . '\' AND minutes <> 0');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('avg_offense_rebounds', (float)$myrow['avg_offense_rebounds']);
        $result->addAttribute('total_offense_rebounds', $myrow['total_offense_rebounds']);
        $result->addAttribute('avg_def_rebounds', (float)$myrow['avg_def_rebounds']);
        $result->addAttribute('total_def_rebounds', $myrow['total_def_rebounds']);
        $result->addAttribute('avg_steals', (float)$myrow['avg_steals']);
        $result->addAttribute('total_steals', $myrow['total_steals']);
        $result->addAttribute('avg_assists', (float)$myrow['avg_assists']);
        $result->addAttribute('total_assists', $myrow['total_assists']);
        $result->addAttribute('avg_fouls', (float)$myrow['avg_fouls']);
        $result->addAttribute('total_fouls', $myrow['total_fouls']);
        $result->addAttribute('avg_minutes', (float)$myrow['avg_minutes']);
        $result->addAttribute('total_minutes', $myrow['total_minutes']);
        $result->addAttribute('three_percent', (float)$myrow['three_percent']);
        $result->addAttribute('three_points', $myrow['three_points']);
        $result->addAttribute('two_percent', (float)$myrow['two_percent']);
        $result->addAttribute('two_points', $myrow['two_points']);
        $result->addAttribute('free_percent', (float)$myrow['free_percent']);
        $result->addAttribute('free_points', $myrow['free_points']);
        $result->addAttribute('avg_points', (float)$myrow['avg_points']);
        $result->addAttribute('total_points', $myrow['total_points']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There are no stats for this player in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    