package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhonesDao {

private Connection conn=null;
	
	public PhonesDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}

	public List<Phones> get_all_phones() throws Exception {
		List<Phones> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from account_phones order by aid,phid");
			while (rs.next()) {
				Phones tempPhone = convertRowToPhone(rs);
				list.add(tempPhone);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
		}
		
		public Phones get_a_phone(int phid) throws Exception {
			
			Phones tempPhone=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from account_phones where phid= ? ");
				stmt.setInt(1, phid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempPhone = convertRowToPhone(rs);
					
				}
				return tempPhone;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_phone(int aid,String sub_name, String phone) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into account_phones (phid,sub_name,phone,aid) values (phones_seq.nextval,?,?,?)");
				
				stmt.setString(1, sub_name);
				stmt.setString(2, phone);
				stmt.setInt(3, aid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_phone(int phid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from account_phones where (phid=?)");
				stmt.setInt(1, phid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_phone(int phid,String sub_name,String phone) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update account_phones set sub_name=?, phone=? where (phid=?)");
				
				stmt.setString(1, sub_name);
				stmt.setString(2,phone);
				stmt.setInt(3, phid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Phones convertRowToPhone(ResultSet rs) throws SQLException {
			
			int phid = rs.getInt("phid");
			String sub_name = rs.getString("sub_name");
			String phone = rs.getString("phone");
			int aid = rs.getInt("aid");
					
			Phones tempPhone = new Phones(phid,sub_name,phone,aid);
					return tempPhone;
		}
	
}
