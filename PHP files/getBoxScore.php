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
    $st = $dbh->query('SELECT GameStats.*, Player.first_name, Player.last_name
                       FROM GameStats, Player
                       WHERE game_id = \'' . $_GET["game_id"] . '\' AND GameStats.player_id = player.id');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('game_id', $myrow['game_id']);
        $result->addAttribute('player_id', $myrow['player_id']);
        $result->addAttribute('player_name', $myrow['first_name']. " " . $myrow['last_name']);
        $result->addAttribute('minutes', $myrow['minutes']);
        $result->addAttribute('three_point_attempts', $myrow['three_point_attempts']);
        $result->addAttribute('three_point_makes', $myrow['three_point_makes']);
        $result->addAttribute('two_point_attempts', $myrow['two_point_attempts']);
        $result->addAttribute('two_point_makes', $myrow['two_point_makes']);
        $result->addAttribute('field_goal_attempts', $myrow['field_goal_attempts']);
        $result->addAttribute('field_goal_makes', $myrow['field_goal_makes']);
        $result->addAttribute('free_throw_attempts', $myrow['free_throw_attempts']);
        $result->addAttribute('free_throw_makes', $myrow['free_throw_makes']);
        $result->addAttribute('offensive_rebounds', $myrow['offensive_rebounds']);
        $result->addAttribute('defensive_rebounds', $myrow['defensive_rebounds']);
        $result->addAttribute('assists', $myrow['assists']);
        $result->addAttribute('turnovers', $myrow['turnovers']);
        $result->addAttribute('steals', $myrow['steals']);
        $result->addAttribute('blocks', $myrow['blocks']);
        $result->addAttribute('personal_fouls', $myrow['personal_fouls']);
        $result->addAttribute('technical_fouls', $myrow['technical_fouls']);
        $result->addAttribute('flagrant_fouls', $myrow['flagrant_fouls']);
        $result->addAttribute('points', $myrow['points']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There is no box score for this game in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    