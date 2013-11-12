import java.io.File;
import java.io.FileWriter;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;


import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


public class GameStatsParser {
	private static final String GAME_SUMMARY_OUTPUT = "GAME_SUMMARY.xml";
	private static final String GAME_STATS_OUTPUT = "GAME_STATS.dat";
	
	public static void parse(String year, String ncaamb_season, String curr_date) throws Exception {
		List<String> game_ids = ScheduleParser.findAllGames(year, ncaamb_season, curr_date);
		FileWriter game_stats_writer = new FileWriter(new File(GAME_STATS_OUTPUT));
		for(int i = 0; i < game_ids.size(); i++) {
			synchronized(GameStatsParser.class) {GameStatsParser.class.wait(1000);}
			parseGameSummary(game_ids.get(i), game_stats_writer);
			//game_stats_writer.flush();
			System.out.println("Parsed Game: " + game_ids.get(i) + " Games Remaining: " + (game_ids.size() - i));
			synchronized(GameStatsParser.class) {GameStatsParser.class.wait(1000);}
		}
		game_stats_writer.close();	
	}
	
	public static void parseGameSummary(String game_id, FileWriter game_stats_writer) throws Exception {
		String url = SportDataReader.getGameSummaryURL(game_id);
		SportDataReader.readSportData(url, GAME_SUMMARY_OUTPUT);
		
		Element root = getDocumentElement(new File(GAME_SUMMARY_OUTPUT));
		
		NodeList teams = root.getElementsByTagName("team");
		for (int i = 0; i < teams.getLength(); i++) {
			Element team = (Element) teams.item(i);
			NodeList players = team.getElementsByTagName("players");
			if (players.getLength() < 1) {continue;}
			players = ((Element) players.item(0)).getElementsByTagName("player");
			for (int j = 0; j < players.getLength(); j++) {
				Element player = (Element) players.item(j);
				if (player == null) {continue;}
				String id = player.getAttribute("id");
				
				Element stats = (Element) player.getElementsByTagName("statistics").item(0);
				if (stats == null) {continue;}
				String minutes = stats.getAttribute("minutes");
				if (minutes.contains(":")) {
					minutes = minutes.split(":")[0];
				}
				String three_point_attempts = stats.getAttribute("three_points_att");
				String three_point_makes = stats.getAttribute("three_points_made");
				String two_point_attempts = stats.getAttribute("two_points_att");
				String two_point_makes = stats.getAttribute("two_points_made");
				String field_goal_attempts = stats.getAttribute("field_goals_att");
				String field_goal_makes = stats.getAttribute("field_goals_made");
				String free_throw_attempts = stats.getAttribute("free_throw_att");
				String free_throw_makes = stats.getAttribute("free_throws_made");
				String offensive_rebounds = stats.getAttribute("offensive_rebounds");
				String defensive_rebounds = stats.getAttribute("defensive_rebounds");
				String assists = stats.getAttribute("assists");
				String turnovers = stats.getAttribute("turnovers");
				String steals = stats.getAttribute("steals");
				String blocks = stats.getAttribute("blocks");
				String personal_fouls = stats.getAttribute("personal_fouls");
				String technical_fouls = stats.getAttribute("tech_fouls");
				String flagrant_fouls = stats.getAttribute("flagrant_fouls");
				String points = stats.getAttribute("points");
				
				game_stats_writer.write(game_id + "|" + id + "|" + minutes + "|" + three_point_attempts + "|" + three_point_makes + "|" + two_point_attempts + "|" + 
				two_point_makes + "|" + field_goal_attempts + "|" + field_goal_makes  + "|" + free_throw_attempts + "|" + free_throw_makes + "|" + offensive_rebounds + "|" + defensive_rebounds
				 + "|" + assists + "|" + turnovers + "|" + steals + "|" + blocks + "|" + personal_fouls + "|" + technical_fouls + "|" + flagrant_fouls + "|" + points + "\n");
			}	
		}
	}
	
	public static Element getDocumentElement(File file) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(file);
	
		return document.getDocumentElement();
	}

}
