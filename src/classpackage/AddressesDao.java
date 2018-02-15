package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressesDao {

private Connection conn=null;
	
	public AddressesDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}

	public List<Addresses> get_all_addresses() throws Exception {
		List<Addresses> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from account_addresses order by aid,addid");
			while (rs.next()) {
				Addresses tempAddress = convertRowToAddress(rs);
				list.add(tempAddress);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
		}
		
		public Addresses get_a_address(int addid) throws Exception {
			
			Addresses tempAddress=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from account_addresses where addid= ? ");
				stmt.setInt(1, addid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempAddress = convertRowToAddress(rs);
					
				}
				return tempAddress;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_address(int aid,String sub_name, String address) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into account_addresses (addid,sub_name,address,aid) values (addresses_seq.nextval,?,?,?)");
				
				stmt.setString(1, sub_name);
				stmt.setString(2, address);
				stmt.setInt(3, aid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_address(int addid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from account_addresses where (addid=?)");
				stmt.setInt(1, addid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_address(int addid,String sub_name,String address) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update account_addresses set sub_name=?, address=? where (addid=?)");
				
				stmt.setString(1, sub_name);
				stmt.setString(2,address);
				stmt.setInt(3, addid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Addresses convertRowToAddress(ResultSet rs) throws SQLException {
			
			int addid = rs.getInt("addid");
			String sub_name = rs.getString("sub_name");
			String address = rs.getString("address");
			int aid = rs.getInt("aid");
					
			Addresses tempAddress = new Addresses(addid,sub_name,address,aid);
					return tempAddress;
		}
	
}
