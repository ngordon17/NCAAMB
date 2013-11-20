import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class SportDataReader {
	private static final String[] API_KEYS = new String[] {"hrk659wjj5nydjjx6mueq2m6", "vknf9t57hm9jtscqxa3ak3dd", 
		"gkpz93nzrgmerdnznrfggefm", "vdyyhmukpw2r2pepgf7azvqn", "3ycygyaqcytzb49z99uvtb9p", "ame4gk9kcgf3q9uaavgq8zer",
		"msfaz8qr42k74xzhk9xx2awx", "kqe6mbgdzu7kchtnmcvm6sgc"};
	private static int API_KEY_INDEX = 0;
	private static String API_KEY = "vknf9t57hm9jtscqxa3ak3dd";
	private static final String VERSION = "3";
	private static final String ACCESS_LEVEL = "t";
	
	public static String getScheduleURL(String season, String ncaamb_season) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/games/" + season + "/" + ncaamb_season + "/schedule.xml?api_key=" + API_KEY;
	}
	
	public static String getDailyScheduleURL(String year, String month, String day) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/games/" + year + "/" + month + "/" + day + "/schedule.xml?api_key=" + API_KEY;
	}
	
	public static String getTournamentListURL(String season, String ncaamb_season) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/tournaments/" + season + "/" + ncaamb_season + "/schedule.xml?api_key=" + API_KEY;
	}
	
	public static String getTournamentScheduleURL(String season,String tournament_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/schema/schedule-v2.0.xsd?api_key=" + API_KEY;
	}
	
	public static String getGameBoxscoreURL(String game_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/games/" + game_id + "/boxscore.xml?api_key=" + API_KEY;
	}
	
	public static String getCurrentWeekRankingURL(String poll_name, String season) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/polls/" + poll_name + "/" + season + "/rankings.xml?api_key=" + API_KEY;
	}
	
	public static String getWeeklyRankingURL(String season, String poll_name, String ncaamb_week) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/polls/" + poll_name + "/" + season + "/" + ncaamb_week + "/rankings.xml?api_key=" + API_KEY;
	}
	
	public static String getStandingsURL(String season, String ncaamb_season) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/seasontd/" + season + "/" + ncaamb_season + "/standings.xml?api_key=" + API_KEY;
	}
	
	public static String getLeagueHierarchyURL() {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/league/hierarchy.xml?api_key=" + API_KEY;
	}
	
	public static String getTeamProfileURL(String team_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/teams/" + team_id + "/profile.xml?api_key=" + API_KEY;
	}
	
	public static String getPlayerProfileURL(String player_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/players/" + player_id + "/profile.xml?api_key=" + API_KEY;
	}
	
	public static String getGameSummaryURL(String game_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/games/" + game_id + "/summary.xml?api_key=" + API_KEY;
	}
	
	public static String getPlayByPlayURL(String game_id) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/games/" + game_id + "/pbp.xml?api_key=" + API_KEY;
	}
	
	public static String getSeasonalStatsURL(String team_id, String season, String ncaamb_season) {
		return "http://api.sportsdatallc.org/ncaamb-" +ACCESS_LEVEL + VERSION + "/seasontd/" + season + "/" + ncaamb_season + "/teams/" + team_id + "/statistics.xml?api_key=" + API_KEY;
	}
	
	public static String getMaintainedTeamsURL(String season) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/seasontd/" + season + "/teams/maintained.xml?api_key=" + API_KEY;
	}
	
	public static String getDailyChangeLogURL(String year, String month, String day) {
		return "http://api.sportsdatallc.org/ncaamb-" + ACCESS_LEVEL + VERSION + "/league/" + year + "/" + month + "/" + day + "/changes.xml?api_key=" + API_KEY;
	}
	
	public static void readSportData(String url_path, String output_path) {
		try {
			readURL(url_path, output_path);
		} catch (Exception e) {
			System.err.println("ERROR: Could not read sport data...");
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	private static void readURL(String url_path, String output_path) throws Exception {
		URL url = new URL(url_path);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		
		int count = 2;
		BufferedReader reader = null;
		while(true) {
			try {
				reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				break;
			} catch (IOException e) {
				if (e.getMessage().contains("Server returned HTTP response code: 403")) {
					//e.printStackTrace();
					System.err.println(API_KEY);
					count--; 
					if (count < 0) {
						API_KEY_INDEX++;
						if (API_KEY_INDEX >= API_KEYS.length) {
							System.err.println("ERROR: No tries or keys remaining - exiting...");
							System.exit(1);
						}
						else {
							API_KEY = API_KEYS[API_KEY_INDEX];
							
							int beforeKey = url_path.indexOf("=");
							url_path = url_path.substring(0, beforeKey + 1) + API_KEY;
							url = new URL(url_path);
							conn = (HttpURLConnection) url.openConnection();
							conn.setRequestMethod("GET");
							
							System.err.println("NOTICE: Switching to new key: " + API_KEY);
							count = 2;
						}
					}
					else {System.err.println("ERROR: HTTP 403 - " + count + " tries remaining... ");}
					synchronized(SportDataReader.class) {SportDataReader.class.wait(10000);}
				}
				else {System.err.println("ERROR: Could not read from url...");}
			}
		}
		
		FileWriter writer = new FileWriter(new File(output_path));
		String line;
		
		while ((line = reader.readLine()) != null) {
			line = line.replaceAll("&", "&amp;");
			writer.write(line + "\n");
		}
		reader.close();
		writer.close();
	}
}
