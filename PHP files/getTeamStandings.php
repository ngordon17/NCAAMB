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
    $st = $dbh->query('SELECT COALESCE(windb.id, lossdb.id) AS team_id, COALESCE(windb.alias, lossdb.alias) AS team_alias, COALESCE(windb.name, lossdb.name) AS team_name, COALESCE(windb.win, 0) AS win, COALESCE(lossdb.loss, 0) AS loss
                       FROM (SELECT Team.id AS id, Team.alias AS alias, Team.name AS name, w.wins AS win
                             FROM Team,  (SELECT Team.id AS tid, COUNT(*) AS wins
                                          FROM Team, Game, Score
                                          WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND home_score > away_score)
                                          OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND away_score > home_score)
                                          GROUP BY tid) AS w
                             WHERE Team.conference_id = \'' . $_GET["conference_id"] . '\' AND Team.id = w.tid) AS windb
                       FULL OUTER JOIN
                       (SELECT Team.id AS id, Team.alias AS alias, Team.name AS name, l.losses AS loss
                        FROM Team,  (SELECT Team.id AS tid, COUNT(*) AS losses
                                     FROM Team, Game, Score
                                     WHERE (Team.id = Game.home_team_id AND Game.id = Score.game_id AND home_score < away_score)
                                     OR (Team.id = Game.away_team_id AND Game.id = Score.game_id AND away_score < home_score)
                                     GROUP BY tid) AS l
                        WHERE Team.conference_id = \'' . $_GET["conference_id"] . '\' AND Team.id = l.tid) AS lossdb
                        ON windb.id = lossdb.id
                        ORDER BY win DESC, loss ASC;');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('team_id', $myrow['team_id']);
        $result->addAttribute('team_alias', $myrow['team_alias']);
        $result->addAttribute('team_name', $myrow['team_name']);
        $result->addAttribute('num_wins', $myrow['win']);
        $result->addAttribute('num_losses', $myrow['loss']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There are no standings for this conference in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    