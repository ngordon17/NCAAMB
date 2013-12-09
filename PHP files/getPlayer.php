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
    $st = $dbh->query('SELECT Player.*, Team.alias, Team.name
                       FROM Player, Team
                       WHERE Player.id = \'' . $_GET["player_id"] . '\' AND Player.team_id = Team.id;');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('id', $myrow['id']);
        $result->addAttribute('first_name', $myrow['first_name']);
        $result->addAttribute('last_name', $myrow['last_name']);
        $result->addAttribute('team_id', $myrow['team_id']);
        $result->addAttribute('team_alias', $myrow['alias']);
        $result->addAttribute('team_name', $myrow['name']);
        $result->addAttribute('height', $myrow['height']);
        $result->addAttribute('weight', $myrow['weight']);
        $result->addAttribute('jersey_number', $myrow['jersey_number']);
        $result->addAttribute('year', $myrow['year']);
        $result->addAttribute('position', $myrow['position']);
        $result->addAttribute('birthplace', $myrow['birthplace']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There is no information for this player in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    