package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DeclineDao {

	private Connection conn=null;
	
	public DeclineDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Decline> get_all_declines() throws Exception {
	List<Decline> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from declines order by did");
		while (rs.next()) {
			Decline tempDecline = convertRowToDecline(rs);
			list.add(tempDecline);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Decline get_a_decline(int did) throws Exception {
		
		Decline tempDecline=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from declines where did= ? ");
			stmt.setInt(1, did);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempDecline = convertRowToDecline(rs);
				
			}
			return tempDecline;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_decline(Decline decline) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into declines (did,decline_date,decline_authority,decline_letter_ref,reasons,report_higher,pid) values (declines_seq.nextval,?,?,?,?,?,?)");
			
			stmt.setDate(1, new java.sql.Date(decline.getDecline_date().getTime()));
			stmt.setInt(2, decline.getDecline_authority());
			stmt.setString(3, decline.getDecline_letter_ref());
			stmt.setString(4, decline.getReasons());
			stmt.setString(5, decline.getReport_higher());
			stmt.setInt(6, decline.getPid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_decline(int did) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from declines where did=?");
			stmt.setInt(1, did);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_decline(Decline decline) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update declines set did=?,decline_date=?,decline_authority=?,decline_letter_ref=?,reasons=?,report_higher=?,pid=? where did=?");
			stmt.setInt(1, decline.getDid());
			stmt.setDate(2, new java.sql.Date(decline.getDecline_date().getTime()));
			stmt.setInt(3, decline.getDecline_authority());
			stmt.setString(4, decline.getDecline_letter_ref());
			stmt.setString(5, decline.getReasons());
			stmt.setString(6, decline.getReport_higher());
			stmt.setInt(7, decline.getPid());
			stmt.setInt(8, decline.getDid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Decline convertRowToDecline(ResultSet rs) throws SQLException {
		
		int did = rs.getInt("did");
		Date decline_date=rs.getDate("decline_date");
		int decline_authority = rs.getInt("decline_authority");
		String decline_letter_ref = rs.getString("decline_letter_ref");
		String reasons = rs.getString("reasons");
		String report_higher = rs.getString("report_higher");
		int pid = rs.getInt("pid");
		
		Decline tempDecline = new Decline(did,decline_date,decline_authority,decline_letter_ref,reasons,report_higher,pid);
				return tempDecline;
	}

}
