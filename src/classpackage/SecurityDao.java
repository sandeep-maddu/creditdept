package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SecurityDao {

	private Connection conn=null;
	
	public SecurityDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Security> get_all_security() throws Exception {
	List<Security> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from security order by aid,scid");
		while (rs.next()) {
			Security tempSecurity = convertRowToSecurity(rs);
			list.add(tempSecurity);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Security get_a_security(int scid) throws Exception {
		
		Security tempSecurity=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from security where scid= ? ");
			stmt.setInt(1, scid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempSecurity = convertRowToSecurity(rs);
				
			}
			return tempSecurity;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_security(Security security) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into security (scid,aid,type,location,description,owner,value,valuation_date) values (security_seq.nextval,?,?,?,?,?,?,?)");
			stmt.setInt(1, security.getAid());
			stmt.setString(2, security.getType());
			stmt.setString(3, security.getLocation());
			stmt.setString(4, security.getDescription());
			stmt.setString(5, security.getOwner());
			stmt.setFloat(6, security.getValue());
			stmt.setDate(7, new java.sql.Date(security.getValuation_date().getTime()));
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_security(int scid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from Security where scid=?");
			stmt.setInt(1, scid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_security(Security security) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update Security set aid=?,type=?,location=?,description=?,owner=?,value=?, valuation_date=? where scid=?");
			stmt.setInt(1, security.getAid());
			stmt.setString(2, security.getType());
			stmt.setString(3, security.getLocation());
			stmt.setString(4, security.getDescription());
			stmt.setString(5, security.getOwner());
			stmt.setFloat(6, security.getValue());
			stmt.setDate(7, new java.sql.Date(security.getValuation_date().getTime()));
			stmt.setInt(8, security.getScid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Security convertRowToSecurity(ResultSet rs) throws SQLException {
		
		int scid = rs.getInt("scid");	
		int aid = rs.getInt("aid");
		String type = rs.getString("type");
		String location = rs.getString("location");
		String description = rs.getString("description");
		String owner = rs.getString("owner");
		Float value = rs.getFloat("value");
		Date valuation_date=rs.getDate("valuation_date");
					
		Security tempSecurity = new Security(scid,aid,type,location,description,owner,value,valuation_date);
				return tempSecurity;
	}

}
