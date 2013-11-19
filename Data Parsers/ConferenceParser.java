import java.io.File;
import java.io.FileWriter;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;


public class ConferenceParser {
	private static String DIVISION_I_ID = "c5a8d640-5093-4044-851d-2c562e929994";
	private static String XML_FILE_PATH = "LEAGUE_HIERARCHY.xml";
	private static String OUTPUT_PATH = "CONFERENCES.dat";
	
	public static void parse() throws Exception {
		String url = SportDataReader.getLeagueHierarchyURL();
		SportDataReader.readSportData(url, XML_FILE_PATH);
		parseConferenceXML();
	}
	
	private static void parseConferenceElement(Element conference, FileWriter writer) throws Exception {
		String id = conference.getAttribute("id");
		String name = conference.getAttribute("name");
		String alias = conference.getAttribute("alias");
		
		writer.write(id + "|" + name + "|" + alias + "\n");
	}
	
	private static void parseConferenceXML() throws Exception {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(new File(XML_FILE_PATH));
		
		Element root = document.getDocumentElement();
		FileWriter conference_writer = new FileWriter(new File(OUTPUT_PATH));
		
		Element division = null;
		
		for (int i = 0; i < root.getElementsByTagName("division").getLength(); i++) {
			Node child = root.getElementsByTagName("division").item(i);
			Element elem = (Element) child;
			if (elem.getAttribute("id").equals(DIVISION_I_ID)) {
				division = elem;
				break;
			}
		}
		
		if (division == null) {throw new Exception("ERROR: Division does not exist");}
	
		for (int i = 0; i < division.getElementsByTagName("conference").getLength(); i++) {
			Node conference = division.getElementsByTagName("conference").item(i);
			parseConferenceElement((Element) conference, conference_writer);
		}
		
		conference_writer.close();	
	}
}
