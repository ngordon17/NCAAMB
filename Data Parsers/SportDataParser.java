import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


public class SportDataParser {
	private static final String DIVISION_I_ID = "c5a8d640-5093-4044-851d-2c562e929994";
	private static final String LEAGUE_HIERARCHY_PATH = "LEAGUE_HIERARCHY.xml";
	private static final String TEAM_PROFILE_PATH = "TEAM_PROFILE.xml";
	private static final String TEAM_OUTPUT_PATH = "TEAM.dat";
	private static final String PLAYER_OUTPUT_PATH = "PLAYER.dat";

	public static void parse() throws Exception {
		FileWriter team_writer = new FileWriter(new File(TEAM_OUTPUT_PATH));
		FileWriter player_writer = new FileWriter(new File(PLAYER_OUTPUT_PATH));
		List<String> team_ids = findAllTeams();
		for (int i = 0; i < team_ids.size(); i++) {
			synchronized(SportDataParser.class) {SportDataParser.class.wait(2000);}
			parseTeamProfile(team_ids.get(i), team_writer, player_writer);
			System.out.println("Parsed Team: " + team_ids.get(i) + " Teams Remaining: " + (team_ids.size() - i));
			//synchronized(SportDataParser.class) {SportDataParser.class.wait(1000);}
		}
		team_writer.close();
		player_writer.close();
	}
	
	public static Element getDocumentElement(File file) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(file);
		return document.getDocumentElement();
	}
	

	public static List<String> findAllTeams() throws Exception {
		List<String> team_ids = new ArrayList<String>();
		String url = SportDataReader.getLeagueHierarchyURL();
		SportDataReader.readSportData(url, LEAGUE_HIERARCHY_PATH);
		
		File file = new File(LEAGUE_HIERARCHY_PATH);
		Element root = getDocumentElement(file);
		
		NodeList divisions = root.getElementsByTagName("division");
		Element division = null;
		for (int i = 0; i < divisions.getLength(); i++) {
			division = (Element) divisions.item(i);
			if (division.getAttribute("id").equals(DIVISION_I_ID)) {
				break;
			}
		}
		
		if (division == null) {return team_ids;}
		
		NodeList conferences = division.getElementsByTagName("conference");
		Element conference = null;
		for (int i = 0; i < conferences.getLength(); i++) {
			conference = (Element) conferences.item(i);
			NodeList teams = conference.getElementsByTagName("team");
			for (int j = 0; j < teams.getLength(); j++) {
				Element team = (Element) teams.item(j);
				team_ids.add(team.getAttribute("id"));
			}
		}
		return team_ids;
	}
	
	public static void parseTeamProfile(String team_id, FileWriter team_writer, FileWriter player_writer) throws Exception {
		String url = SportDataReader.getTeamProfileURL(team_id);
		SportDataReader.readSportData(url, TEAM_PROFILE_PATH);
		
		File file = new File(TEAM_PROFILE_PATH);
		Element root = getDocumentElement(file);
		
		String name = root.getAttribute("name");
		String alias = root.getAttribute("market");
		String venue_id = ((Element) root.getElementsByTagName("venue").item(0)).getAttribute("id");
		
		Element hierarchy = ((Element) root.getElementsByTagName("hierarchy").item(0));
		String conference_id = ((Element) hierarchy.getElementsByTagName("conference").item(0)).getAttribute("id");
		
		team_writer.write(team_id + "|" + name + "|" + alias + "|" + venue_id + "|" + conference_id + "\n");
		
		Element players_root = (Element) root.getElementsByTagName("players").item(0);
		NodeList players = players_root.getElementsByTagName("player");
		
		for (int i = 0; i < players.getLength(); i++) {
			Element player = (Element) players.item(i);
			String id = player.getAttribute("id");
			String first_name = player.getAttribute("first_name");
			String last_name = player.getAttribute("last_name");
			String height = player.getAttribute("height");
			String weight = player.getAttribute("weight");
			String position = player.getAttribute("position");
			String number = player.getAttribute("jersey_number");
			String experience = player.getAttribute("experience");
			String birth_place = player.getAttribute("birth_place");
			
			player_writer.write(id + "|" + first_name + "|" + last_name + "|" + team_id + "|" + height + "|" + weight + "|" + number + "|" + experience + "|" + position + "|" + birth_place + "\n");
		}
	}
	
}