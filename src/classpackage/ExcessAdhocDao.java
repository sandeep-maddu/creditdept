package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ExcessAdhocDao {

	private Connection conn=null;
	
	public ExcessAdhocDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<ExcessAdhoc> get_all_excessadhocs() throws Exception {
	List<ExcessAdhoc> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from excess_adhoc order by aid,eid");
		while (rs.next()) {
			ExcessAdhoc tempExcessAdhoc = convertRowToExcessAdhoc(rs);
			list.add(tempExcessAdhoc);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public ExcessAdhoc get_a_excessadhoc(int eid) throws Exception {
		
		ExcessAdhoc tempExcessAdhoc=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from excess_adhoc where eid= ? ");
			stmt.setInt(1, eid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempExcessAdhoc = convertRowToExcessAdhoc(rs);
				
			}
			return tempExcessAdhoc;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_excessadhoc(ExcessAdhoc excessadhoc) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into excess_adhoc (eid, aid, type,availed_on, limit, number_of_days, due_date, times_since_last_renewal, when_actually_adjusted, pct_over_regular_roi, roc_status) values (eid_seq.nextval,?,?,?,?,?,?,?,?,?,?)");
			stmt.setInt(1, excessadhoc.getAid());
			stmt.setString(2, excessadhoc.getType());
			stmt.setDate(3, new java.sql.Date(excessadhoc.getAvailed_on().getTime()));
			stmt.setFloat(4, excessadhoc.getLimit());
			stmt.setInt(5, excessadhoc.getNumber_of_days());
			stmt.setDate(6, new java.sql.Date(excessadhoc.getDue_date().getTime()));
			stmt.setInt(7, excessadhoc.getTimes_since_last_renewal());
			stmt.setDate(8, new java.sql.Date(excessadhoc.getWhen_actually_adjusted().getTime()));
			stmt.setFloat(9, excessadhoc.getPct_over_regular_roi());
			stmt.setString(10, excessadhoc.getRoc_status());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_excessadhoc(int eid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from excess_adhoc where eid=?");
			stmt.setInt(1, eid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_excessadhoc(ExcessAdhoc excessadhoc) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update excess_adhoc set aid=?, type=?, availed_on=?, limit=?, number_of_days=?, due_date=?, times_since_last_renewal=?, when_actually_adjusted=?, pct_over_regular_roi=?, roc_status=? where eid=?");
			stmt.setInt(1, excessadhoc.getAid());
			stmt.setString(2, excessadhoc.getType());
			stmt.setDate(3, new java.sql.Date(excessadhoc.getAvailed_on().getTime()));
			stmt.setFloat(4, excessadhoc.getLimit());
			stmt.setInt(5, excessadhoc.getNumber_of_days());
			stmt.setDate(6, new java.sql.Date(excessadhoc.getDue_date().getTime()));
			stmt.setInt(7, excessadhoc.getTimes_since_last_renewal());
			stmt.setDate(8, new java.sql.Date(excessadhoc.getWhen_actually_adjusted().getTime()));
			stmt.setFloat(9, excessadhoc.getPct_over_regular_roi());
			stmt.setString(10, excessadhoc.getRoc_status());
			stmt.setInt(11, excessadhoc.getEid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private ExcessAdhoc convertRowToExcessAdhoc(ResultSet rs) throws SQLException {
		
		int eid = rs.getInt("eid");	
		int aid = rs.getInt("aid");
		String type = rs.getString("type");
		Date availed_on=rs.getDate("availed_on");
		Float limit=rs.getFloat("limit");
		int number_of_days = rs.getInt("number_of_days");
		Date due_date=rs.getDate("due_date");
		int times_since_last_renewal = rs.getInt("times_since_last_renewal");
		Date when_actually_adjusted=rs.getDate("when_actually_adjusted");
		Float pct_over_regular_roi=rs.getFloat("pct_over_regular_roi");
		String roc_status = rs.getString("roc_status");
		
		ExcessAdhoc tempExcessAdhoc = new ExcessAdhoc(eid, aid, type, availed_on, limit, number_of_days, due_date, times_since_last_renewal, when_actually_adjusted, pct_over_regular_roi, roc_status);
				return tempExcessAdhoc;
	}

}
