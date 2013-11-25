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
    $st = $dbh->query('SELECT g.gid, g.home_team_id, g.home_team_alias, g.home_team_name, g.away_team_id, g.away_team_alias, g.away_team_name, 
       COALESCE(s.home_score, 0) AS hscore, COALESCE(s.away_score, 0) AS ascore, g.scheduled_datetime
       FROM (SELECT Game.id AS gid, home_team_id, t1.alias AS home_team_alias, t1.name AS home_team_name, away_team_id, 
       t2.alias AS away_team_alias, t2.name AS away_team_name, scheduled_datetime
       FROM Game, Team t1, Team t2  
       WHERE scheduled_datetime::date = \'' . $_GET["date"] . '\' AND t1.id = home_team_id AND t2.id = away_team_id) AS g
       LEFT OUTER JOIN
       (SELECT game_id AS gid, home_score, away_score
       FROM Score) AS s
       ON g.gid = s.gid;');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('id', $myrow['gid']);
        $result->addAttribute('home_team_id', $myrow['home_team_id']);
        $result->addAttribute('home_team_alias', $myrow['home_team_alias']);
        $result->addAttribute('home_team_name', $myrow['home_team_name']);
        $result->addAttribute('away_team_id', $myrow['away_team_id']);
        $result->addAttribute('away_team_alias', $myrow['away_team_alias']);
        $result->addAttribute('away_team_name', $myrow['away_team_name']);
        $result->addAttribute('home_score', $myrow['hscore']);
        $result->addAttribute('away_score', $myrow['ascore']);
        $result->addAttribute('scheduled_datetime', $myrow['scheduled_datetime']);
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
    