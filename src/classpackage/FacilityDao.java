package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FacilityDao {

private Connection conn=null;
	
	public FacilityDao() throws SQLException {
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}
	public List<Facility> get_all_facilities() throws Exception {
		List<Facility> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from facility order by facility_name");
			while (rs.next()) {
				
				Facility tempFacility = convertRowToFacility(rs);
				list.add(tempFacility);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Facility get_a_facility(String facility_name) throws Exception {
			
			Facility tempFacility=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from facility where facility_name = ? ");
				stmt.setString(1, facility_name);
				rs=stmt.executeQuery();
				while (rs.next()) {
					
					tempFacility = convertRowToFacility(rs);
					
				}
				return tempFacility;
			}
			finally {
				stmt.close();
				rs.close();
				}
			
						
			}
		
		
	
	public void add_facility(Facility facility) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into facility (facility_name,fb_or_nfb,wc_or_tl) values (?,?,?)");
			stmt.setString(1, facility.getFacility_name());
			stmt.setString(2, facility.getFb_or_nfb());
			stmt.setString(3, facility.getWc_or_tl());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}





	public void delete_facility(String facility_name) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from facility where facility_name=?");
			stmt.setString(1, facility_name);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_facility(Facility facility) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update facility set facility_name=?,fb_or_nfb=?,wc_or_tl=? where facility_name=?");
			stmt.setString(1, facility.getFacility_name());
			stmt.setString(2, facility.getFb_or_nfb());
			stmt.setString(3, facility.getWc_or_tl());
			stmt.setString(4, facility.getFacility_name());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}



	private Facility convertRowToFacility(ResultSet rs) throws SQLException {
			
			String facility_name = rs.getString("facility_name");
			String fb_or_nfb = rs.getString("fb_or_nfb");
			String wc_or_tl = rs.getString("wc_or_tl");

			Facility tempFacility = new Facility(facility_name,fb_or_nfb,wc_or_tl);
			
			return tempFacility;
		}

}
