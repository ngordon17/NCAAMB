We have a number of Java files that obtain the "production" dataset and then 
transform it into flat .dat files. There are 5 parser classes (VenueParser, 
ScheduleParser, ConferenceParser, and SportDataParser) that get the appropriate 
data from the dataset. The "production" dataset we are using comes from 
SportsData LLC. We can access their data regarding NCAA basketball through GET 
requests. This API returns XML documents. Each of the Java classes makes the 
appropriate GET request through static method calls in the SportDataReader class 
to get the appropriate XML file.

Each class then has DOM code to parse the XML file and write the data to a flat 
.dat file. The data will be arranged in each .dat file in such a way that it 
matches the schema of a corresponding SQL database.

CREATE-DATABASE.sql contains all the CREATE TABLE statements for all of our 
relations. Run "psql -af CREATE-DATABASE.sql" to initialize all of the tables. 
LOAD-DATABSE.sql copies all of the data from the .dat files into the SQL tables. 
Run "psql -af LOAD-DATABASE.sql" to do this. Once this step is ocmpleted, 
the "production" dataset has been transformed and loaded into our database. 