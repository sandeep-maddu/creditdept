package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OutstandingDao {

	private Connection conn=null;
	
	public OutstandingDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Outstanding> get_all_outstandings() throws Exception {
	List<Outstanding> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from outstanding order by lid,oid");
		while (rs.next()) {
			Outstanding tempOutstanding = convertRowToOutstanding(rs);
			list.add(tempOutstanding);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Outstanding get_a_outstanding(int oid) throws Exception {
		
		Outstanding tempOutstanding=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from outstanding where id= ? ");
			stmt.setInt(1, oid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempOutstanding = convertRowToOutstanding(rs);
				
			}
			return tempOutstanding;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_outstanding(Outstanding outstanding) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into outstanding (oid,lid,os,os_date) values (oid_seq.nextval,?,?,?)");
			stmt.setInt(1, outstanding.getLid());
			stmt.setFloat(2, outstanding.getOs());
			stmt.setDate(3, new java.sql.Date(outstanding.getOs_date().getTime()));
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_outstanding(int oid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from outstanding where oid=?");
			stmt.setInt(1, oid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_outstanding(Outstanding outstanding) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update outstanding set lid=?,os=?,os_date=? where oid=?");
			stmt.setInt(1, outstanding.getLid());
			stmt.setFloat(2, outstanding.getOs());
			stmt.setDate(3, new java.sql.Date(outstanding.getOs_date().getTime()));
			stmt.setInt(4, outstanding.getOid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Outstanding convertRowToOutstanding(ResultSet rs) throws SQLException {
		
		int oid = rs.getInt("oid");
		int lid = rs.getInt("lid");
		Float os = rs.getFloat("os");
		Date os_date = rs.getDate("os_date");
				
		Outstanding tempOutstanding = new Outstanding(oid,lid,os,os_date);
				return tempOutstanding;
	}

}
