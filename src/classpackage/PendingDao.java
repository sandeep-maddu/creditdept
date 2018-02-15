package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PendingDao {

private Connection conn=null;
	
	public PendingDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}
	
	public List<Pending> get_all_pending() throws Exception {
		List<Pending> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from pending_issues order by aid,pi_id");
			while (rs.next()) {
				Pending tempPending = convertRowToPending(rs);
				list.add(tempPending);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Pending get_a_pending(int pi_id) throws Exception {
			
			Pending tempPending=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from pending_issues where pi_id= ? ");
				stmt.setInt(1, pi_id);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempPending = convertRowToPending(rs);
					
				}
				return tempPending;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_pending(int aid,String pending_issue) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into pending_issues (pi_id,pending_issue,aid) values (pendingissue_seq.nextval,?,?)");
				
				stmt.setString(1, pending_issue);
				stmt.setInt(2, aid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_pending(int pi_id) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from pending_issues where (pi_id=?)");
				stmt.setInt(1, pi_id);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_pending(int pi_id,String pending_issue) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update pending_issues set pending_issue=? where (pi_id=?)");
				
				stmt.setString(1, pending_issue);
				stmt.setInt(2, pi_id);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Pending convertRowToPending(ResultSet rs) throws SQLException {
			
			int pi_id = rs.getInt("pi_id");
			String pending_issue = rs.getString("pending_issue");
			int aid = rs.getInt("aid");
					
			Pending tempPending = new Pending(pi_id,pending_issue,aid);
					return tempPending;
		}
}
