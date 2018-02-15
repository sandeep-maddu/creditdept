package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SanctionDao {

	private Connection conn=null;
	
	public SanctionDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Sanction> get_all_sanctions() throws Exception {
	List<Sanction> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from sanctions order by sid");
		while (rs.next()) {
			Sanction tempSanction = convertRowToSanction(rs);
			list.add(tempSanction);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Sanction get_a_sanction(int sid) throws Exception {
		
		Sanction tempSanction=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from sanctions where sid= ? ");
			stmt.setInt(1, sid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempSanction = convertRowToSanction(rs);
				
			}
			return tempSanction;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_sanction(Sanction sanction) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into sanctions (sid,sanction_date,sanction_authority,sanction_letter_ref,reviewing_authority,control_form_sent_on,cmrd_queries_received_on,cmrd_reply_sent_on,admin_clearance,confirmation,pid) values (sanctions_seq.nextval,?,?,?,?,?,?,?,?,?,?)");
			
			stmt.setDate(1, new java.sql.Date(sanction.getSanction_date().getTime()));
			stmt.setInt(2, sanction.getSanction_authority());
			stmt.setString(3, sanction.getSanction_letter_ref());
			stmt.setInt(4, sanction.getReviewing_authority());
			stmt.setDate(5, new java.sql.Date(sanction.getControl_form_sent_on().getTime()));
			stmt.setDate(6, new java.sql.Date(sanction.getCmrd_queries_received_on().getTime()));
			stmt.setDate(7, new java.sql.Date(sanction.getCmrd_reply_sent_on().getTime()));
			stmt.setString(8, sanction.getAdmin_clearance());
			stmt.setString(9, sanction.getConfirmation());
			stmt.setInt(10, sanction.getPid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_sanction(int sid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from sanctions where sid=?");
			stmt.setInt(1, sid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_sanction(Sanction sanction) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update sanctions set sid=?,sanction_date=?,sanction_authority=?,sanction_letter_ref=?,reviewing_authority=?,control_form_sent_on=?,cmrd_queries_received_on=?,cmrd_reply_sent_on=?,admin_clearance=?,confirmation=?,pid=? where sid=?");
			stmt.setInt(1, sanction.getSid());
			stmt.setDate(2, new java.sql.Date(sanction.getSanction_date().getTime()));
			stmt.setInt(3, sanction.getSanction_authority());
			stmt.setString(4, sanction.getSanction_letter_ref());
			stmt.setInt(5, sanction.getReviewing_authority());
			stmt.setDate(6, new java.sql.Date(sanction.getControl_form_sent_on().getTime()));
			stmt.setDate(7, new java.sql.Date(sanction.getCmrd_queries_received_on().getTime()));
			stmt.setDate(8, new java.sql.Date(sanction.getCmrd_reply_sent_on().getTime()));
			stmt.setString(9, sanction.getAdmin_clearance());
			stmt.setString(10, sanction.getConfirmation());
			stmt.setInt(11, sanction.getPid());
			stmt.setInt(12, sanction.getSid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Sanction convertRowToSanction(ResultSet rs) throws SQLException {
		
		int sid = rs.getInt("sid");
		Date sanction_date=rs.getDate("sanction_date");
		int sanction_authority = rs.getInt("sanction_authority");
		String sanction_letter_ref = rs.getString("sanction_letter_ref");
		int reviewing_authority = rs.getInt("reviewing_authority");
		Date control_form_sent_on=rs.getDate("control_form_sent_on");
		Date cmrd_queries_received_on=rs.getDate("cmrd_queries_received_on");
		Date cmrd_reply_sent_on=rs.getDate("cmrd_reply_sent_on");
		String admin_clearance = rs.getString("admin_clearance");
		String confirmation = rs.getString("confirmation");
		int pid = rs.getInt("pid");
		
		Sanction tempSanction = new Sanction(sid,sanction_date,sanction_authority,sanction_letter_ref,reviewing_authority,control_form_sent_on,cmrd_queries_received_on,cmrd_reply_sent_on,admin_clearance,confirmation,pid);
				return tempSanction;
	}

}
