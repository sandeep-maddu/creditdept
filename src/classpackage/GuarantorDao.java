package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GuarantorDao {

	private Connection conn=null;
	
	public GuarantorDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Guarantor> get_all_guarantors() throws Exception {
	List<Guarantor> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from guarantors order by aid,gid");
		while (rs.next()) {
			Guarantor tempGuarantor = convertRowToGuarantor(rs);
			list.add(tempGuarantor);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Guarantor get_a_guarantor(int gid) throws Exception {
		
		Guarantor tempGuarantor=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from guarantors where gid= ? ");
			stmt.setInt(1, gid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempGuarantor = convertRowToGuarantor(rs);
				
			}
			return tempGuarantor;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_guarantor(Guarantor guarantor) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into guarantors (gid,aid,guarantor_name,designation,networth,networth_basis,networth_date) values (guarantors_seq.nextval,?,?,?,?,?,?)");
			stmt.setInt(1, guarantor.getAid());
			stmt.setString(2, guarantor.getGuarantor_name());
			stmt.setString(3, guarantor.getDesignation());
			stmt.setFloat(4, guarantor.getNetworth());
			stmt.setString(5, guarantor.getNetworth_basis());
			stmt.setDate(6, new java.sql.Date(guarantor.getNetworth_date().getTime()));
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_guarantor(int gid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from Guarantors where gid=?");
			stmt.setInt(1, gid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_guarantor(Guarantor guarantor) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update Guarantors set aid=?,guarantor_name=?,designation=?,networth=?,networth_basis=?,networth_date=? where gid=?");
			stmt.setInt(1, guarantor.getAid());
			stmt.setString(2, guarantor.getGuarantor_name());
			stmt.setString(3, guarantor.getDesignation());
			stmt.setFloat(4, guarantor.getNetworth());
			stmt.setString(5, guarantor.getNetworth_basis());
			stmt.setDate(6, new java.sql.Date(guarantor.getNetworth_date().getTime()));
			stmt.setInt(7, guarantor.getGid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Guarantor convertRowToGuarantor(ResultSet rs) throws SQLException {
		
		int gid = rs.getInt("gid");	
		int aid = rs.getInt("aid");
		String guarantor_name = rs.getString("guarantor_name");
		String designation = rs.getString("designation");
		Float networth = rs.getFloat("networth");
		String networth_basis = rs.getString("networth_basis");
		Date networth_date=rs.getDate("networth_date");
					
		Guarantor tempGuarantor = new Guarantor(gid,aid,guarantor_name,designation,networth,networth_basis,networth_date);
				return tempGuarantor;
	}

}
