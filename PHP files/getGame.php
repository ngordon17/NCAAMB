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
    $st = $dbh->query('SELECT *
                       FROM Game
                       WHERE scheduled_datetime::date = \'' . $_GET["game_date"] . '\'');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('id', $myrow['id']);
        $result->addAttribute('home_team_id', $myrow['home_team_id']);
        $result->addAttribute('away_team_id', $myrow['away_team_id']);
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
    