package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class ActivityDao {

	private Connection conn=null;
	
	public ActivityDao() throws SQLException {
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
}

	public List<Activity> get_all_activities() throws Exception {
		List<Activity> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from activity order by activity_name");
			while (rs.next()) {
				
				Activity tempActivity = convertRowToActivity(rs);
				list.add(tempActivity);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Activity get_a_activity(String activity_name) throws Exception {
			
			Activity tempActivity=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				activity_name+="%";
				stmt=conn.prepareStatement("select * from activity where activity_name like ? ");
				stmt.setString(1, activity_name);
				rs=stmt.executeQuery();
				while (rs.next()) {
					
					tempActivity = convertRowToActivity(rs);
					
				}
				return tempActivity;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		
	
	public void add_activity(Activity actv) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into activity (activity_name,description,industry) values (?,?,?)");
			stmt.setString(1, actv.getActivity_name());
			stmt.setString(2, actv.getDescription());
			stmt.setString(3, actv.getIndustry());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}





	public void delete_activity(String activity_name) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from activity where activity_name=?");
			stmt.setString(1, activity_name);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_activity(Activity actv) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update activity set activity_name=?,description=?,industry=? where activity_name=?");
			stmt.setString(1, actv.getActivity_name());
			stmt.setString(2, actv.getDescription());
			stmt.setString(3, actv.getIndustry());
			stmt.setString(4, actv.getActivity_name());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}



	private Activity convertRowToActivity(ResultSet rs) throws SQLException {
			
			String activity_name = rs.getString("activity_name");
			String activity_description = rs.getString("description");
			String industry = rs.getString("industry");

			Activity tempActivity = new Activity(activity_name,activity_description,industry);
			
			return tempActivity;
		}
}
