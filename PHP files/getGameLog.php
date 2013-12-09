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
    $st = $dbh->query('SELECT game_id, scheduled_datetime, offensive_rebounds, defensive_rebounds, steals, assists, personal_fouls, minutes, three_point_makes * 3 AS three_points,
       two_point_makes * 2 AS two_points, free_throw_makes AS free_points, two_point_makes * 2 + three_point_makes * 3 + free_throw_makes AS total_points
       FROM GameStats, Game
       WHERE player_id = \'' . $_GET["player_id"] . '\' AND minutes <> 0 AND game_id = Game.id');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('game_id', $myrow['game_id']);
        $result->addAttribute('scheduled_datetime', $myrow['scheduled_datetime']);
        $result->addAttribute('offensive_rebounds', $myrow['offensive_rebounds']);
        $result->addAttribute('defensive_rebounds', $myrow['defensive_rebounds']);
        $result->addAttribute('steals', $myrow['steals']);
        $result->addAttribute('assists', $myrow['assists']);
        $result->addAttribute('personal_fouls', $myrow['personal_fouls']);
        $result->addAttribute('blocks', $myrow['blocks']);
        $result->addAttribute('minutes', $myrow['minutes']);
        $result->addAttribute('three_points', $myrow['three_points']);
        $result->addAttribute('two_points', $myrow['two_points']);
        $result->addAttribute('free_points', $myrow['free_points']);
        $result->addAttribute('total_points', $myrow['total_points']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There is no game log in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    