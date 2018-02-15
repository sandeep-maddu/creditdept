package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SpecialconditionsDao {

private Connection conn=null;
	
	public SpecialconditionsDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}
	
	public List<Specialconditions> get_all_specialconditions() throws Exception {
		List<Specialconditions> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from special_conditions order by sid,cid");
			while (rs.next()) {
				Specialconditions tempSpecialconditions = convertRowToSpecialconditions(rs);
				list.add(tempSpecialconditions);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Specialconditions get_a_specialcondition(int cid) throws Exception {
			
			Specialconditions tempSpecialconditions=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from special_conditions where cid= ? ");
				stmt.setInt(1, cid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempSpecialconditions = convertRowToSpecialconditions(rs);
					
				}
				return tempSpecialconditions;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_specialconditions(int sid,String condition) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into special_conditions (cid,condition,sid) values (specialcondition_seq.nextval,?,?)");
				
				stmt.setString(1, condition);
				stmt.setInt(2, sid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_specialconditions(int cid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from special_conditions where (cid=?)");
				stmt.setInt(1, cid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_specialconditions(int cid,String condition) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update special_conditions set condition=? where (cid=?)");
				
				stmt.setString(1, condition);
				stmt.setInt(2, cid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Specialconditions convertRowToSpecialconditions(ResultSet rs) throws SQLException {
			
			int cid = rs.getInt("cid");
			String condition = rs.getString("condition");
			int sid = rs.getInt("sid");
					
			Specialconditions tempSpecialconditions = new Specialconditions(cid,condition,sid);
					return tempSpecialconditions;
		}
}
