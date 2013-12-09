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
    $st = $dbh->query('SELECT Team.*, Venue.name AS vname
                       FROM Team, Venue
                       WHERE Team.id = \'' . $_GET["team_id"] . '\' AND Team.venue_id = Venue.id');
    if (($myrow = $st->fetch())) {
      do {
        $result = $xml->addChild('result');
        $result->addAttribute('team_id', $myrow['id']);
        $result->addAttribute('name', $myrow['name']);
        $result->addAttribute('alias', $myrow['alias']);
        $result->addAttribute('venue_id', $myrow['venue_id']);
        $result->addAttribute('venue_name', $myrow['vname']);
        $result->addAttribute('conference_id', $myrow['conference_id']);
      } while ($myrow = $st->fetch());
    } else {
      echo "There is no information for this team in the database.";
    }
  } catch (PDOException $e) {
    print "Database error: " . $e->getMessage() . "<br/>";
    die();
  }
  Header('Content-type: text/xml');
  print($xml->asXML());
  ?>
    