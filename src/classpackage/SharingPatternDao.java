package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SharingPatternDao {

private Connection conn=null;
	
	public SharingPatternDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}

	public List<SharingPattern> get_all_sharingpattern() throws Exception {
		List<SharingPattern> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from sharing_pattern order by bid,spid");
			while (rs.next()) {
				SharingPattern tempSharingPattern = convertRowToSharingPattern(rs);
				list.add(tempSharingPattern);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
		}
		
		public SharingPattern get_a_sharingpattern(int spid) throws Exception {
			
			SharingPattern tempSharingPattern=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from sharing_pattern where spid= ? ");
				stmt.setInt(1, spid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempSharingPattern = convertRowToSharingPattern(rs);
					
				}
				return tempSharingPattern;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_sharingpattern(int bid,String bank, Float limit,Float share_pct) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into sharing_pattern (spid,bid,bank,limit,share_pct) values (spid_seq.nextval,?,?,?,?)");
				
				stmt.setInt(1, bid);
				stmt.setString(2, bank);
				stmt.setFloat(3, limit);
				stmt.setFloat(4, share_pct);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_sharingpattern(int spid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from sharing_pattern where (spid=?)");
				stmt.setInt(1, spid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_sharingpattern(int spid,int bid,String bank,Float limit,Float share_pct) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update sharing_pattern set bid=?,bank=?,limit=?,share_pct=? where (spid=?)");
				
				stmt.setInt(1, bid);
				stmt.setString(2, bank);
				stmt.setFloat(3, limit);
				stmt.setFloat(4, share_pct);
				stmt.setInt(5, spid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private SharingPattern convertRowToSharingPattern(ResultSet rs) throws SQLException {
			
			int spid = rs.getInt("spid");
			int bid = rs.getInt("bid");
			String bank = rs.getString("bank");
			Float limit = rs.getFloat("limit");
			Float share_pct = rs.getFloat("share_pct");
					
			SharingPattern tempSharingPattern = new SharingPattern(spid,bid,bank,limit,share_pct);
					return tempSharingPattern;
		}
	
}
