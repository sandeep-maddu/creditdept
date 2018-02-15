package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DirectorsDao {

private Connection conn=null;
	
	public DirectorsDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}

	public List<Directors> get_all_directors() throws Exception {
		List<Directors> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from account_directors order by aid,dirid");
			while (rs.next()) {
				Directors tempDirector = convertRowToDirector(rs);
				list.add(tempDirector);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
		}
		
		public Directors get_a_director(int dirid) throws Exception {
			
			Directors tempDirector=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from account_directors where dirid= ? ");
				stmt.setInt(1, dirid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempDirector = convertRowToDirector(rs);
					
				}
				return tempDirector;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_director(int aid,String director_name, String designation) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into account_directors (dirid,director_name,designation,aid) values (directors_seq.nextval,?,?,?)");
				
				stmt.setString(1, director_name);
				stmt.setString(2, designation);
				stmt.setInt(3, aid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_director(int dirid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from account_directors where (dirid=?)");
				stmt.setInt(1, dirid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_director(int dirid,String director_name,String designation) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update account_directors set director_name=?, designation=? where (dirid=?)");
				
				stmt.setString(1, director_name);
				stmt.setString(2,designation);
				stmt.setInt(3, dirid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Directors convertRowToDirector(ResultSet rs) throws SQLException {
			
			int dirid = rs.getInt("dirid");
			String director_name = rs.getString("director_name");
			String designation = rs.getString("designation");
			int aid = rs.getInt("aid");
					
			Directors tempDirector = new Directors(dirid,director_name,designation,aid);
					return tempDirector;
		}
	
}
