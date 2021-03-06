import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


public class ScheduleParser {
	private static final String SCHEDULE_OUTPUT = "SCHEDULE.xml";
	private static final String GAME_OUTPUT = "GAME.dat";
	
	public static void parse(String year, String ncaamb_season) throws Exception {
		String url = SportDataReader.getScheduleURL(year, ncaamb_season);
		SportDataReader.readSportData(url, SCHEDULE_OUTPUT);
		FileWriter game_writer = new FileWriter(new File(GAME_OUTPUT));
		Element root = getDocumentElement(new File(SCHEDULE_OUTPUT));
		
		root = (Element) (root.getElementsByTagName("season-schedule").item(0));
		root = (Element)  (root.getElementsByTagName("games").item(0));
		
		NodeList games = root.getElementsByTagName("game");
		Set<String> div_one_teams = new HashSet<String>(SportDataParser.findAllTeams());
		for (int i = 0; i < games.getLength(); i++) {
			Element game = (Element) games.item(i);
			parseGame(game, game_writer, div_one_teams);
		}
		
		game_writer.close();	
	}
	
	public static List<String> findAllGames(String year, String ncaamb_season, String curr_date) throws Exception {
		List<String> game_ids = new ArrayList<String>();
		String url = SportDataReader.getScheduleURL(year, ncaamb_season);
		SportDataReader.readSportData(url, SCHEDULE_OUTPUT);	
		//FileWriter game_writer = new FileWriter(new File(GAME_OUTPUT));
		Element root = getDocumentElement(new File(SCHEDULE_OUTPUT));
		
		root = (Element) (root.getElementsByTagName("season-schedule").item(0));
		root = (Element)  (root.getElementsByTagName("games").item(0));
		
		NodeList games = root.getElementsByTagName("game");
		
		String[] date = curr_date.split("T")[0].split("-");
		
		for (int i = 0; i < games.getLength(); i++) {
			Element game = (Element) games.item(i);
			String home_team_id = game.getAttribute("home_team");
			String away_team_id = game.getAttribute("away_team");
			
			String game_date = game.getAttribute("scheduled");
			
			if (game_date == null || game_date.equals("")) { continue;}
			String[] gd = game_date.split("T")[0].split("-");
			
			if (Integer.parseInt(date[0]) < Integer.parseInt(gd[0])) {continue;}
			else if (Integer.parseInt(date[0]) == Integer.parseInt(gd[0]) && Integer.parseInt(date[1]) < Integer.parseInt(gd[1])) {continue;}
			else if (Integer.parseInt(date[0]) == Integer.parseInt(gd[0]) && Integer.parseInt(date[1]) == Integer.parseInt(gd[1]) && Integer.parseInt(date[2]) < Integer.parseInt(gd[2])) {continue;}
			
			if (home_team_id == null || away_team_id == null || home_team_id.length() == 0 || away_team_id.length() == 0) {continue;}
			game_ids.add(game.getAttribute("id"));
		}
		//System.out.println(game_ids.size());
		return game_ids;
	}
	
	public static void parseGame(Element game, FileWriter game_writer, Set<String> div_one_team_ids) throws Exception {
		String id = game.getAttribute("id");
		String home_team_id = game.getAttribute("home_team");
		String away_team_id = game.getAttribute("away_team");
		if (!div_one_team_ids.contains(home_team_id) || !div_one_team_ids.contains(away_team_id)) return;
		
		String scheduled_date = game.getAttribute("scheduled").split("T")[0];
		String scheduled_time = game.getAttribute("scheduled").split("T")[1];
		String scheduled_short_time = scheduled_time.substring(0, scheduled_time.indexOf('+'));
		String date_time = scheduled_date + " " + scheduled_short_time;
		
		if (home_team_id == null || away_team_id == null || home_team_id.length() == 0 || away_team_id.length() ==0) {
			System.err.println("NOTICE: Skipping game " + id + ". Home or Away is null");
			return;
		}
		game_writer.write(id + "|" + home_team_id + "|" + away_team_id + "|" + date_time + "\n");
	}
	
	public static Element getDocumentElement(File file) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(file);
	
		return document.getDocumentElement();
	}

}
