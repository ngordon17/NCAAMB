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
    $st = $dbh->query('SELECT GameStats.game_id, scheduled_datetime, minutes, two_point_makes, two_point_attempts, three_point_makes, three_point_attempts,
       free_throw_makes, free_throw_attempts, offensive_rebounds + defensive_rebounds AS rebounds, assists, blocks, steals, 
       personal_fouls, turnovers, two_point_makes * 2 + three_point_makes * 3 + free_throw_makes AS total_points,
       (CASE WHEN home_team_id = Team.id THEN (SELECT alias FROM Team WHERE away_team_id = Team.id) ELSE (SELECT alias FROM Team WHERE home_team_id = Team.id) END) AS opponent,
       (CASE WHEN (home_team_id = Team.id AND home_score > away_score) OR (away_team_id = Team.id AND away_score > home_score) THEN \'W\' ELSE \'L\' END) AS result,
       home_score, away_score
FROM GameStats, Game, Player, Team, Score
WHERE player_id = \'' . $_GET["player_id"] . '\' AND minutes <> 0 AND GameStats.game_id = Game.id AND player_id = Player.id AND Player.team_id = Team.id AND Game.id = Score.game_id');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('game_id', $myrow['game_id']);
        $result->addAttribute('DATE', $myrow['scheduled_datetime']);
        $result->addAttribute('OPP', $myrow['opponent']);
        if ($myrow['home_score'] > $myrow['away_score']) {
            $result->addAttribute('RESULT', $myrow['result'] . ' ' . $myrow['home_score'] . '-' . $myrow['away_score']);
        } else {
            $result->addAttribute('RESULT', $myrow['result'] . ' ' . $myrow['away_score'] . '-' . $myrow['home_score']);
        }
        $result->addAttribute('MIN', $myrow['minutes']);
        $result->addAttribute('FGM-FGA', $myrow['two_point_makes'] . '-' . $myrow['two_point_attempts']);
        $result->addAttribute('FGpercent', round($myrow['two_point_makes']/floatval($myrow['two_point_attempts']), 3));
        $result->addAttribute('threePM-threePA', $myrow['three_point_makes'] . '-' . $myrow['three_point_attempts']);
        $result->addAttribute('threepercent', round($myrow['three_point_makes']/floatval($myrow['three_point_attempts']), 3));
        $result->addAttribute('FTM-FTA', $myrow['free_throw_makes'] . '-' . $myrow['free_throw_makes']);
        $result->addAttribute('Ftpercent', round($myrow['free_throw_makes']/floatval($myrow['free_throw_attempts']), 3));
        $result->addAttribute('REB', $myrow['rebounds']);
        $result->addAttribute('AST', $myrow['assists']);
        $result->addAttribute('BLK', $myrow['blocks']);
        $result->addAttribute('STL', $myrow['steals']);
        $result->addAttribute('PF', $myrow['personal_fouls']);
        $result->addAttribute('TO', $myrow['turnovers']);
        $result->addAttribute('PTS', $myrow['total_points']);
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
    