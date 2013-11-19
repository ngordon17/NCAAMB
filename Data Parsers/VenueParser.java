import java.io.File;

import java.io.FileWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


public class VenueParser {
	private static final String DIVISION_I_ID = "c5a8d640-5093-4044-851d-2c562e929994";
	private static final String LEAGUE_HIERARCHY_OUTPUT = "LEAGUE_HIERARCHY_OUTPUT.xml";
	private static final String SCHEDULE_OUTPUT = "SCHEDULE.xml";
	private static final String VENUE_OUTPUT = "VENUE.dat";

	public static void parse(String year, String ncaamb_season) throws Exception{
		FileWriter venue_writer = new FileWriter(new File(VENUE_OUTPUT));
		parseHomeVenues(venue_writer);
		parseNeutralVenues(year, ncaamb_season, venue_writer);
		venue_writer.close();
	}
	
	public static void parseHomeVenues(FileWriter venue_writer) throws Exception {
		String url = SportDataReader.getLeagueHierarchyURL();
		SportDataReader.readSportData(url, LEAGUE_HIERARCHY_OUTPUT);
		
		Element root = getDocumentElement(new File(LEAGUE_HIERARCHY_OUTPUT));
		
		NodeList divisions = root.getElementsByTagName("division");
		Element division = null;
		
		for (int i = 0; i < divisions.getLength(); i++) {
			division = (Element) divisions.item(i);
			if (division.getAttribute("id").equals(DIVISION_I_ID)) {break;}
			else {division = null;}
		}
		if (division == null) {return;}
		
		NodeList conferences = division.getElementsByTagName("conference");
		for (int i = 0; i < conferences.getLength(); i++) {
			Element conference = (Element) conferences.item(i);
			NodeList teams = conference.getElementsByTagName("team");
			for (int j = 0; j < teams.getLength(); j++) {
				Element team = (Element) teams.item(j);
				Element venue = (Element) team.getElementsByTagName("venue").item(0);	
				parseVenue(venue, venue_writer);
			}
		}
	}
	
	public static void parseNeutralVenues(String year, String ncaamb_season, FileWriter venue_writer) throws Exception {
		String url = SportDataReader.getScheduleURL(year, ncaamb_season);
		SportDataReader.readSportData(url, SCHEDULE_OUTPUT);
		
		Element root = getDocumentElement(new File(SCHEDULE_OUTPUT));
		root = (Element) root.getElementsByTagName("season-schedule").item(0);
		root = (Element) root.getElementsByTagName("games").item(0);
		
		NodeList games = root.getElementsByTagName("game");
		
		for (int i = 0; i < games.getLength(); i++) {
			Element game = (Element) games.item(i);
			NodeList venues = game.getElementsByTagName("venue");
			if (venues.getLength() > 1) {
				Element venue = (Element) venues.item(0);
				parseVenue(venue, venue_writer);
			}
		}
	}
	
	public static void parseVenue(Element venue, FileWriter venue_writer) throws Exception {
		String id = venue.getAttribute("id");
		String name = venue.getAttribute("name");
		String address = venue.getAttribute("address");
		String city = venue.getAttribute("city");
		String state = venue.getAttribute("state");
		String country = venue.getAttribute("country");
		String zipcode = venue.getAttribute("zip");
		String capacity = venue.getAttribute("capacity");
		venue_writer.write(id + "|" + name + "|" + address + "|" + city + "|" + state + "|" + country + "|" + zipcode
				+ "|" + capacity + "\n");
	}
	
	public static Element getDocumentElement(File file) throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(file);
	
		return document.getDocumentElement();
	}
}
