
public class Main {

	public static void main(String[] args) {
		try {
			//VenueParser.parse("2013", "reg");
			//ScheduleParser.parse("2013", "reg");
			//ConferenceParser.parse();
			//SportDataParser.parse();
			GameStatsParser.parse("2013", "reg", "2013-11-09T00:00:00");
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
